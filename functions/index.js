const functions = require('firebase-functions/v1');
const admin = require("firebase-admin");
admin.initializeApp();

exports.newOrderNotification = functions.firestore
  .document("users/{userDocId}/orders/{orderId}")
  .onCreate((snapshot, context) => {
    // Ensure userDocId and orderId are extracted correctly
    const userDocId = context.params.userDocId; // Extract userDocId
    const orderId = context.params.orderId; // Extract orderId

    if (!userDocId || !orderId) {
      console.error("Missing userDocId or orderId in context.params");
      return null;
    }

    const orderData = snapshot.data(); // Get order data

    console.log("Triggered for userDocId:", userDocId);
    console.log("Triggered for orderId:", orderId);
    console.log("Order data:", orderData);

    // Construct the notification payload
    const payload = {
      notification: {
        title: "New Order",
        body: `Order #${orderId} has been placed.`,
      },
      data: {
        orderId: orderId,
        userDocId: userDocId,
      },
    };

    // Send the notification to the "orders" topic
    return admin.messaging().sendToTopic("orders", payload)
      .then((response) => {
        console.log("Notification sent successfully:", response);
      })
      .catch((error) => {
        console.error("Error sending notification:", error.message);
      });
  });