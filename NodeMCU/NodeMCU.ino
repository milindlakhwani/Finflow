#include <ESP8266WiFi.h>

//Firebase Arduino library to upload data to realtime database
#include <Firebase_ESP_Client.h>

//NTP Client library to fetch current time from NTP client
#include <NTPClient.h>
#include <WiFiUdp.h>

//Wifi manager library to change SSID and Password during runtime
#include <WiFiManager.h>

// Provide the token generation process info.
#include <addons/TokenHelper.h>
// Provide the RTDB payload printing info and other helper functions.
#include <addons/RTDBHelper.h>

// Wifi Credentials
#define WIFI_SSID "Wifi SSID"
#define WIFI_PASSWORD "Pasword for wifi"

// Defining API key
#define API_KEY "enter api key here"

// User email and password for this project
#define USER_EMAIL "user email from firebase"
#define USER_PASSWORD "user password"

// RTDB URL
#define DATABASE_URL "Realtime database url" 

//Time related parameters
const long utcOffsetInSeconds = 19800;
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org", utcOffsetInSeconds);

// Firebase data object

FirebaseData fbdo;

// Firebase auth object
FirebaseAuth auth;

// Firebase config object
FirebaseConfig config;

unsigned long dataMillis = 0;
int count = 0;

// pins for indicator LEDs and button
#define TRIGGER_PIN 0
int connection_pin = 2;
int ap_mode = 4;
int error_pin = 5;

int timeout = 600;
bool isAPOn = false;

void setup()
{

  //Setting the pins
  pinMode(connection_pin , OUTPUT);
  pinMode(ap_mode , OUTPUT);
  pinMode(error_pin , OUTPUT);
  pinMode(TRIGGER_PIN, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(TRIGGER_PIN) , setAPmode , FALLING);

  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  unsigned long ms = millis();

  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
    digitalWrite(connection_pin , HIGH);
    delay(100);
    digitalWrite(connection_pin , LOW);
    delay(100);
  }
  Serial.println();
  digitalWrite(connection_pin , HIGH);
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  // Setting up firebase
  config.api_key = API_KEY;

  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  config.database_url = DATABASE_URL;

  Firebase.reconnectWiFi(true);
  fbdo.setResponseSize(4096);

  String base_path = "/UsersData/";
  config.token_status_callback = tokenStatusCallback;

  // Initialising firebase with auth and config
  Firebase.begin(&config, &auth);

  // Starting the time client
  timeClient.begin();
}

void loop()
{
  //Check if user presses button, then turn on AP mode
  if (isAPOn) {
    changePass();
  }

  // listen for serial data regularly and upload the data to firebase when available
  if (Serial.available() && Firebase.ready()) {
    //Read incoming string
    String str = Serial.readString();

    // Creating a new json object from json string recieved from arduino
    FirebaseJson jsonData;
    jsonData.setJsonData(str);

    //Updating time client to insert timeStamp
    timeClient.update();
    jsonData.add("timeStamp", timeClient.getEpochTime());

    //create the document path
    String path = auth.token.uid.c_str();
    Serial.println("Uploading");

    //Upload the json object
    bool res = Firebase.RTDB.setJSON(&fbdo, path, &jsonData);

    // handle error
    if (res) {
      digitalWrite(error_pin , HIGH);
      Serial.print("setting /message failed:");
      Serial.println(fbdo.errorReason().c_str());
      return;
    }
    Serial.println("Uploaded");
    digitalWrite(error_pin , LOW);
  }

}

void changePass() {
  //Indicate AP mode is on
  digitalWrite(ap_mode , HIGH);

  //WiFiManager Object initialized
  WiFiManager wm;

  // set configportal timeout
  wm.setConfigPortalTimeout(timeout);

  if (!wm.startConfigPortal("On_Demand_AP")) {
    Serial.println("failed to connect and hit timeout");
    digitalWrite(error_pin , HIGH);
    delay(3000);
    digitalWrite(error_pin , LOW);
    //reset and try again, or maybe put it to deep sleep
    ESP.restart();
  }

  //On Connected to new WiFi network
  Serial.println("connected...yeey :)");
  isAPOn = false;
  digitalWrite(ap_mode , LOW);
}

void setAPmode() {
  digitalWrite(ap_mode , HIGH);
  isAPOn = true;
}
