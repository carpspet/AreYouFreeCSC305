const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

const functions = require("firebase-functions");
const admin = require("firebase-admin");

const db = admin.firestore();

exports.compareSchedules = functions.https.onCall(async (data, context) => {
  // Authentication check
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "You must be authenticated to call this function.",
    );
  }

  const { currentUserId, friendId, date } = data;

  // Validate input
  if (!currentUserId || !friendId || !date) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "currentUserId, friendId, and date are required.",
    );
  }

  const startOfDay = new Date(date);
  startOfDay.setHours(0, 0, 0, 0);

  const endOfDay = new Date(date);
  endOfDay.setHours(23, 59, 59, 999);

  try {
    // Fetch current user's events
    const userEventsSnapshot = await db
      .collection("appointments")
      .where("userID", "==", currentUserId)
      .where("eventTime", ">=", startOfDay)
      .where("eventTime", "<=", endOfDay)
      .get();

    const friendEventsSnapshot = await db
      .collection("appointments")
      .where("userID", "==", friendId)
      .where("eventTime", ">=", startOfDay)
      .where("eventTime", "<=", endOfDay)
      .get();

    const userEvents = userEventsSnapshot.docs.map((doc) => doc.data());
    const friendEvents = friendEventsSnapshot.docs.map((doc) => doc.data());

    // Helper function to check overlapping events
    const hasOverlap = (start1, end1, start2, end2) => {
      return start1 < end2 && end1 > start2;
    };

    // Calculate availability
    let isFreeAllDay = userEvents.length === 0 && friendEvents.length === 0;

    if (isFreeAllDay) {
      return { status: "Free all day", color: "green" };
    }

    // Find the latest end time of the user's events
    let latestEndTime = userEvents.reduce((latest, event) => {
      const eventEnd = event.endTime.toDate();
      return eventEnd > latest ? eventEnd : latest;
    }, new Date(0));

    // Check for overlap with friend's events
    for (let event of friendEvents) {
      const friendStart = event.eventTime.toDate();
      const friendEnd = event.endTime.toDate();
      if (
        hasOverlap(
          latestEndTime,
          new Date("2100-01-01"),
          friendStart,
          friendEnd,
        )
      ) {
        return { status: "Not free at all", color: "red" };
      }
    }

    // If no overlap, return free after latest end time
    return {
      status: `Free after ${latestEndTime.getHours()}:${latestEndTime.getMinutes()}`,
      color: "yellow",
    };
  } catch (error) {
    console.error("Error comparing schedules:", error);
    throw new functions.https.HttpsError(
      "internal",
      "Unable to compare schedules.",
    );
  }
});
