const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.leaveGroup = functions.https.onCall(async (data, context) => {
  try {
    // Log received data
    console.log("Received data:", data);

    const { groupName, userID } = data;

    if (!groupName || !userID) {
      console.error("Invalid parameters:", { groupName, userID });
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Both groupName and userID are required.",
      );
    }

    const usersCollection = admin.firestore().collection("users");
    const groupsCollection = admin.firestore().collection("Groups");

    // Fetch user document
    const userDoc = await usersCollection.doc(userID).get();
    if (!userDoc.exists) {
      console.error(`User document not found for ID: ${userID}`);
      throw new functions.https.HttpsError("not-found", "User not found.");
    }

    const userDisplayName = userDoc.data().display_name;

    // Fetch group document
    const groupQuery = await groupsCollection
      .where("GroupName", "==", groupName)
      .get();

    if (groupQuery.empty) {
      console.error(`Group document not found for name: ${groupName}`);
      throw new functions.https.HttpsError("not-found", "Group not found.");
    }

    const groupDocID = groupQuery.docs[0].id;

    // Remove user from UserInGroup in Groups collection
    const groupRef = groupsCollection.doc(groupDocID);
    await groupRef.update({
      UserInGroup: admin.firestore.FieldValue.arrayRemove(userDisplayName),
    });
    console.log(
      `Removed user ${userDisplayName} from group ${groupName} in Groups collection.`,
    );

    // Remove group from authGroup in Users collection
    const userRef = usersCollection.doc(userID);
    await userRef.update({
      authGroup: admin.firestore.FieldValue.arrayRemove(groupName),
    });
    console.log(
      `Removed group ${groupName} from user ${userID} in Users collection.`,
    );

    return { success: true, message: "User removed from group successfully." };
  } catch (error) {
    console.error("Error in leaveGroup function:", error);
    throw new functions.https.HttpsError(
      "unknown",
      "An error occurred while leaving the group.",
      error.message,
    );
  }
});
