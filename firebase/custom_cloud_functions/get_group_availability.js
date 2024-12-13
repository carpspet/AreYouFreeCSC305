const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.getGroupAvailability = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated.",
    );
  }

  const userUID = context.auth.uid;
  const groupName = data.groupName || "";

  try {
    // Get the authenticated user's document to check their group
    const userDoc = await admin
      .firestore()
      .collection("users")
      .doc(userUID)
      .get();
    if (!userDoc.exists) {
      throw new functions.https.HttpsError("not-found", "User not found.");
    }

    // Verify the user belongs to the specified group
    const userGroups = userDoc.get("authGroup") || [];
    if (!userGroups.includes(groupName)) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "You are not authorized.",
      );
    }

    // Fetch the group's information
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
      return { groupAvailability: [] };
    }

    // Get today's date for filtering appointments (current day start and end in UTC)
    const todayStart = new Date();
    todayStart.setHours(0, 0, 0, 0); // Start of today in UTC
    const todayEnd = new Date();
    todayEnd.setHours(23, 59, 59, 999); // End of today in UTC

    // Fetch all appointments for the day (no filtering by user initially)
    const appointmentsQuerySnapshot = await admin
      .firestore()
      .collection("appointments")
      .where("eventTime", ">=", todayStart) // Only appointments for today
      .where("eventTime", "<=", todayEnd) // Only appointments for today
      .get();

    const appointments = [];
    appointmentsQuerySnapshot.forEach((doc) => {
      appointments.push(doc.data());
    });

    // Process each user from the group and find their relevant appointments
    const availabilityListPromises = usersInGroup.map(async (displayName) => {
      let status = "free all day"; // Default status
      let latestEndTime = null;
      let isAllDay = false;

      // Filter appointments for this user
      const userAppointments = appointments.filter(
        (appointment) => appointment.userID === displayName,
      );

      // Check if the user has any appointments today
      if (userAppointments.length > 0) {
        userAppointments.forEach((data) => {
          if (data.isAllDay) {
            isAllDay = true;
          } else {
            const endTime = data.endTime.toDate();
            if (!latestEndTime || endTime > latestEndTime) {
              latestEndTime = endTime;
            }
          }
        });

        if (isAllDay) {
          status = "busy all day";
        } else if (latestEndTime) {
          // Adjust endTime to UTC-5 (Eastern Time)
          const localEndTime = new Date(latestEndTime); // Convert to Date object
          const timezoneOffset = 5 * 60; // UTC-5 in minutes

          localEndTime.setMinutes(localEndTime.getMinutes() - timezoneOffset); // Adjust by UTC-5

          // Extract the hours from the endTime and format to AM/PM
          const hours = localEndTime.getHours();
          const period = hours >= 12 ? "PM" : "AM";
          const endTime = hours % 12 === 0 ? 12 : hours % 12; // 12-hour format
          status = `free after ${endTime} ${period}`;
        }
      }

      return {
        displayName: displayName,
        status: status,
      };
    });

    const groupAvailability = await Promise.all(availabilityListPromises);
    return { groupAvailability: groupAvailability };
  } catch (error) {
    console.error("Error fetching group availability:", error);
    throw new functions.https.HttpsError("unknown", error.message);
  }
});
