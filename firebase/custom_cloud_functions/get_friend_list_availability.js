const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.getFriendListAvailability = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated.",
      );
    }

    const userUID = context.auth.uid;

    try {
      // Get the authenticated user's document to get the friends list
      const userDoc = await admin
        .firestore()
        .collection("users")
        .doc(userUID)
        .get();
      if (!userDoc.exists) {
        throw new functions.https.HttpsError("not-found", "User not found.");
      }

      const friendsList = userDoc.get("friendsList") || [];

      if (friendsList.length === 0) {
        return { friendListAvailability: [] };
      }

      // Get today's date for filtering appointments (current day start and end in UTC)
      const todayStart = new Date();
      todayStart.setHours(0, 0, 0, 0); // Start of today in UTC
      const todayEnd = new Date();
      todayEnd.setHours(23, 59, 59, 999); // End of today in UTC

      // Fetch all appointments for the day (we're not filtering by friend here initially)
      const appointmentsQuerySnapshot = await admin
        .firestore()
        .collection("appointments")
        .where("eventTime", ">=", todayStart) // Only appointments for today
        .where("eventTime", "<=", todayEnd) // Only appointments for today
        .get();

      let appointments = [];
      appointmentsQuerySnapshot.forEach((doc) => {
        appointments.push(doc.data());
      });

      // Process each friend from the friends list and find their relevant appointments
      const availabilityListPromises = friendsList.map(
        async (friendDisplayName) => {
          let status = "free all day"; // Default status
          let latestEndTime = null;
          let isAllDay = false;

          // Filter appointments for this friend
          const friendAppointments = appointments.filter(
            (appointment) => appointment.userID === friendDisplayName,
          );

          // Check if the friend has any appointments today
          if (friendAppointments.length > 0) {
            friendAppointments.forEach((data) => {
              // If any event is marked as "all day", update the status to "busy all day"
              if (data.isAllDay) {
                isAllDay = true;
              } else {
                const endTime = data.endTime.toDate(); // Convert Firestore Timestamp to Date object
                if (latestEndTime == null || endTime > latestEndTime) {
                  latestEndTime = endTime;
                }
              }
            });

            // Set the final status based on "all day" events or latest "endTime"
            if (isAllDay) {
              status = "busy all day";
            } else if (latestEndTime) {
              // Adjust endTime to UTC-5 (Eastern Time)
              const localEndTime = new Date(latestEndTime); // Convert to Date object
              const timezoneOffset = 5 * 60; // UTC-5 in minutes

              localEndTime.setMinutes(
                localEndTime.getMinutes() - timezoneOffset,
              ); // Adjust by UTC-5

              // Extract the hours from the endTime and format to AM/PM
              const hours = localEndTime.getHours();
              const period = hours >= 12 ? "PM" : "AM";
              const formattedHours = hours % 12 === 0 ? 12 : hours % 12; // Convert to 12-hour format
              const minutes = localEndTime.getMinutes();
              const formattedTime = `${formattedHours}:${minutes < 10 ? "0" + minutes : minutes} ${period}`;

              // Set status to free after formatted time
              status = `free after ${formattedTime}`;
            }
          }

          return {
            displayName: friendDisplayName,
            status: status,
          };
        },
      );

      const availabilityList = await Promise.all(availabilityListPromises);

      return { friendListAvailability: availabilityList };
    } catch (error) {
      console.error("Error fetching friend list availability:", error);
      throw new functions.https.HttpsError("unknown", error.message);
    }
  },
);
