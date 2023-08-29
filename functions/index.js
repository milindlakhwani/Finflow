const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);
const fcm = admin.messaging();

exports.ammoniaChange = functions.database
  .ref("{productId}/ammonia")
  .onUpdate(async (change, context) => {
    const productId = context.params.productId;

    // fetch reciever tokens
    const querySnapshot = await admin
      .firestore()
      .collection("products")
      .doc(productId)
      .collection("tokens")
      .get();

    const tokens = querySnapshot.docs.map((snap) => snap.id);
    const updatedVal = change.after.val();

    if (updatedVal > 1) {
      const payload = {
        notification: {
          title: "Alert",
          body: "Ammonia value has been increased.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };
      fcm.sendToDevice(tokens, payload);
    }
  });

exports.chlorineChange = functions.database
  .ref("{productId}/chlorine")
  .onUpdate(async (change, context) => {
    const productId = context.params.productId;

    // fetch reciever tokens
    const querySnapshot = await admin
      .firestore()
      .collection("products")
      .doc(productId)
      .collection("tokens")
      .get();

    const tokens = querySnapshot.docs.map((snap) => snap.id);
    const updatedVal = change.after.val();

    if (updatedVal > 1) {
      const payload = {
        notification: {
          title: "Alert",
          body: "Chlorine concentration has been increased.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };
      fcm.sendToDevice(tokens, payload);
    }
  });

exports.co2Change = functions.database
  .ref("{productId}/co2")
  .onUpdate(async (change, context) => {
    const productId = context.params.productId;
    // fetch reciever tokens
    const querySnapshot = await admin
      .firestore()
      .collection("products")
      .doc(productId)
      .collection("tokens")
      .get();

    const tokens = querySnapshot.docs.map((snap) => snap.id);
    const updatedVal = change.after.val();

    if (updatedVal > 15) {
      const payload = {
        notification: {
          title: "Alert",
          body: "CO2 concentration has been increased.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };

      fcm.sendToDevice(tokens, payload);
    }

    if (updatedVal < 3) {
      const payload = {
        notification: {
          title: "Alert",
          body: "CO2 value has been dropped.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };
      fcm.sendToDevice(tokens, payload);
    }
  });

exports.dissO2Change = functions.database
  .ref("{productId}/dissO2")
  .onUpdate(async (change, context) => {
    const productId = context.params.productId;

    // fetch reciever tokens
    const querySnapshot = await admin
      .firestore()
      .collection("products")
      .doc(productId)
      .collection("tokens")
      .get();

    const tokens = querySnapshot.docs.map((snap) => snap.id);
    const updatedVal = change.after.val();

    if (updatedVal > 8) {
      const payload = {
        notification: {
          title: "Alert",
          body: "Dissolved Oxygen has been increased.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };
      fcm.sendToDevice(tokens, payload);
    }

    if (updatedVal < 5) {
      const payload = {
        notification: {
          title: "Alert",
          body: "Dissolved Oxygen value has dropped.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };
      fcm.sendToDevice(tokens, payload);
    }
  });

exports.hardnessChange = functions.database
  .ref("{productId}/hardness")
  .onUpdate(async (change, context) => {
    const productId = context.params.productId;

    // fetch reciever tokens
    const querySnapshot = await admin
      .firestore()
      .collection("products")
      .doc(productId)
      .collection("tokens")
      .get();

    const tokens = querySnapshot.docs.map((snap) => snap.id);
    const updatedVal = change.after.val();

    if (updatedVal > 10) {
      const payload = {
        notification: {
          title: "Alert",
          body: "Hardness in water has increased.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };
      fcm.sendToDevice(tokens, payload);
    }

    if (updatedVal < 6) {
      const payload = {
        notification: {
          title: "Alert",
          body: "Hardness in water has dropped.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };
      fcm.sendToDevice(tokens, payload);
    }
  });

exports.nitrateChange = functions.database
  .ref("{productId}/nitrate")
  .onUpdate(async (change, context) => {
    const productId = context.params.productId;
    // fetch reciever tokens
    const querySnapshot = await admin
      .firestore()
      .collection("products")
      .doc(productId)
      .collection("tokens")
      .get();

    const tokens = querySnapshot.docs.map((snap) => snap.id);
    const updatedVal = change.after.val();

    if (updatedVal > 20) {
      const payload = {
        notification: {
          title: "Alert",
          body: "Nitrate concentration has been increased.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };

      fcm.sendToDevice(tokens, payload);
    }
  });

exports.nitriteChange = functions.database
  .ref("{productId}/nitrite")
  .onUpdate(async (change, context) => {
    const productId = context.params.productId;
    // fetch reciever tokens
    const querySnapshot = await admin
      .firestore()
      .collection("products")
      .doc(productId)
      .collection("tokens")
      .get();

    const tokens = querySnapshot.docs.map((snap) => snap.id);
    const updatedVal = change.after.val();

    if (updatedVal > 1) {
      const payload = {
        notification: {
          title: "Alert",
          body: "Hardness in water has increased.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };

      fcm.sendToDevice(tokens, payload);
    }
  });

exports.pHChange = functions.database
  .ref("{productId}/pH")
  .onUpdate(async (change, context) => {
    const productId = context.params.productId;

    // fetch reciever tokens
    const querySnapshot = await admin
      .firestore()
      .collection("products")
      .doc(productId)
      .collection("tokens")
      .get();

    const tokens = querySnapshot.docs.map((snap) => snap.id);
    const updatedVal = change.after.val();

    if (updatedVal > 7.5) {
      const payload = {
        notification: {
          title: "Alert",
          body: "pH value has been increased.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };
      fcm.sendToDevice(tokens, payload);
    }

    if (updatedVal < 6.5) {
      const payload = {
        notification: {
          title: "Alert",
          body: "pH value has been dropped.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };
      fcm.sendToDevice(tokens, payload);
    }
  });

exports.phosphatesChange = functions.database
  .ref("{productId}/phosphates")
  .onUpdate(async (change, context) => {
    const productId = context.params.productId;

    // fetch reciever tokens
    const querySnapshot = await admin
      .firestore()
      .collection("products")
      .doc(productId)
      .collection("tokens")
      .get();

    const tokens = querySnapshot.docs.map((snap) => snap.id);
    const updatedVal = change.after.val();

    if (updatedVal > 1.5) {
      const payload = {
        notification: {
          title: "Alert",
          body: "Hardness in water has increased.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };
      fcm.sendToDevice(tokens, payload);
    }
  });

exports.tempChange = functions.database
  .ref("{productId}/temp")
  .onUpdate(async (change, context) => {
    const productId = context.params.productId;

    // fetch reciever tokens
    const querySnapshot = await admin
      .firestore()
      .collection("products")
      .doc(productId)
      .collection("tokens")
      .get();

    const tokens = querySnapshot.docs.map((snap) => snap.id);
    const updatedVal = change.after.val();

    if (updatedVal > 28) {
      const payload = {
        notification: {
          title: "Alert",
          body: "Temperature of water has increased.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };
      fcm.sendToDevice(tokens, payload);
    }

    if (updatedVal < 24) {
      const payload = {
        notification: {
          title: "Alert",
          body: "Temperature of water has dropped.",
          badge: "1",
          sound: "default",
          android_channel_id: "high_importance_channel",
          channel_id: "high_importance_channel",
        },
      };
      fcm.sendToDevice(tokens, payload);
    }
  });
