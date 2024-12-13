const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.removeFriend = functions.https.onCall(async (data, context) => {
  try {
    // Log the received data
    console.log("Received data:", data);

    // Extract parameters
    const removerID = data.removerID;
    const friendDisplayName = data.friendDisplayName;

    // Validate parameters
    if (!removerID || !friendDisplayName) {
      console.error("Invalid parameters:", { removerID, friendDisplayName });
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Both removerID and friendDisplayName are required.",
      );
    }

    console.log("removerID:", removerID);
    console.log("friendDisplayName:", friendDisplayName);

    const usersCollection = admin.firestore().collection("users");

    // Fetch the remover's document
    const removerDoc = await usersCollection.doc(removerID).get();
    if (!removerDoc.exists) {
      console.error(`Remover document not found for ID: ${removerID}`);
      throw new functions.https.HttpsError(
        "not-found",
        "Remover user not found.",
      );
    }

    const removerDisplayName = removerDoc.data().display_name;

    // Fetch the friend's document using their display name
    const friendQuery = await usersCollection
      .where("display_name", "==", friendDisplayName)
      .get();
    if (friendQuery.empty) {
      console.error(
        `Friend document not found for display name: ${friendDisplayName}`,
      );
      throw new functions.https.HttpsError(
        "not-found",
        "Friend user not found.",
      );
    }

    const friendDoc = friendQuery.docs[0];
    const friendDocId = friendDoc.id;

    console.log("Friend Document ID:", friendDocId);
    console.log("Remover Display Name:", removerDisplayName);

    // Update the friends list for both users
    await usersCollection.doc(removerID).update({
      friendsList: admin.firestore.FieldValue.arrayRemove(friendDisplayName),
    });

    await usersCollection.doc(friendDocId).update({
      friendsList: admin.firestore.FieldValue.arrayRemove(removerDisplayName),
    });

    console.log(
      `Successfully removed friendship between ${removerDisplayName} and ${friendDisplayName}`,
    );

    return { success: true, message: "Friend removed successfully." };
  } catch (error) {
    console.error("Error in removeFriend function:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Failed to remove friend. See logs for details.",
    );
  }
});
