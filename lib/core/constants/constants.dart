import 'package:finflow_iot/models/sensor_info.dart';

enum AuthState {
  auth,
  verify,
}

// enum SensorName {
//   dissO2,
//   co2,
//   nitrate,
//   nitrite,
//   pH,
//   temp,
//   ammonia,
//   hardness,
//   phosphates,
//   chlorine,
// }

abstract class SensorName {
  static String dissO2 = "dissO2";
  static String co2 = "co2";
  static String nitrate = "nitrate";
  static String nitrite = "nitrite";
  static String pH = "pH";
  static String temp = "temp";
  static String ammonia = "ammonia";
  static String hardness = "hardness";
  static String phosphates = "phosphates";
  static String chlorine = "chlorine";
}

class Constants {
  static const otpPageImage = 'assets/images/clip-calculating.png';
  static const signUpPageImage = 'assets/images/clip-1062.png';
  static const homePageImage =
      'assets/images/clip-end-of-quarantine-happy-and-joyful-girl-2.png';
  static const clickLottieFile = "assets/lottie_files/animation.json";
  static const notFoundLottie = "assets/lottie_files/not_found.json";
  static const productsCollection = 'products';

  static Map<String, SensorInfo> sensors = {
    SensorName.dissO2: SensorInfo(
        title: "Dissolved Oxygen", unit: "mg/L", expectedVal: [5, 8]),
    SensorName.ammonia:
        SensorInfo(title: "Ammonia", unit: "ppm", expectedVal: [0, 0]),
    SensorName.co2:
        SensorInfo(title: "Dissolved CO2", unit: "mg/L", expectedVal: [3, 15]),
    SensorName.nitrate:
        SensorInfo(title: "Nitrate Conc.", unit: "ppm", expectedVal: [0, 20]),
    SensorName.nitrite:
        SensorInfo(title: "Nitrite Conc.", unit: "ppm", expectedVal: [0, 0]),
    SensorName.pH: SensorInfo(title: "pH", unit: "", expectedVal: [6.5, 7.5]),
    SensorName.temp:
        SensorInfo(title: "Temperature", unit: "°C", expectedVal: [24, 28]),
    SensorName.hardness:
        SensorInfo(title: "Hardness", unit: "dGH", expectedVal: [6, 10]),
    SensorName.phosphates:
        SensorInfo(title: "Phosphates", unit: "ppm", expectedVal: [0, 1]),
    SensorName.chlorine:
        SensorInfo(title: "Chlorine", unit: "ppm", expectedVal: [0, 0]),
  };
}
