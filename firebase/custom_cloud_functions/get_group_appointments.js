const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.getGroupAppointments = functions.https.onCall(async (data, context) => {
  const groupName = (data.groupName || "").trim();

  if (!groupName) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Group name is required.",
    );
  }

  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated.",
    );
  }

  const userUID = context.auth.uid;

  try {
    const userDoc = await admin
      .firestore()
      .collection("users")
      .doc(userUID)
      .get();
    if (!userDoc.exists) {
      throw new functions.https.HttpsError("not-found", "User not found.");
    }

    const userGroups = userDoc.get("authGroup") || [];
    if (!userGroups.includes(groupName)) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "You are not authorized.",
      );
    }

    const groupSnapshot = await admin
      .firestore()
      .collection("Groups")
      .where("GroupName", "==", groupName)
      .get();

    if (groupSnapshot.empty) {
      throw new functions.https.HttpsError("not-found", "Group not found.");
    }

    const groupDoc = groupSnapshot.docs[0];
    const usersInGroup = groupDoc.get("UserInGroup") || [];

    if (usersInGroup.length === 0) {
      return { appointments: [] };
    }

    const appointmentsPromises = usersInGroup.map(async (displayName) => {
      const userQuery = await admin
        .firestore()
        .collection("users")
        .where("display_name", "==", displayName)
        .get();

      if (userQuery.empty) return [];

      const userDoc = userQuery.docs[0];
      const userPhotoURL =
        userDoc.get("photo_url") || "https://example.com/default-profile.png";

      const appointmentQuery = await admin
        .firestore()
        .collection("appointments")
        .where("userID", "==", displayName)
        .get();

      return appointmentQuery.docs.map((doc) => {
        const data = doc.data();
        return {
          id: doc.id,
          eventTime: data.eventTime.toDate().toISOString(),
          endTime: data.endTime.toDate().toISOString(),
          eventName: `${displayName}'s Event`,
          isAllDay: data.isAllDay || false,
          color: data.color || "#0000FF",
          photoURL: userPhotoURL,
          isDaily: data.daily || false,
          isWeekly: data.weekly || false,
        };
      });
    });

    const appointments = (await Promise.all(appointmentsPromises)).flat();
    return { appointments };
  } catch (error) {
    console.error("Error fetching group appointments:", error);
    throw new functions.https.HttpsError("unknown", error.message);
  }
});
