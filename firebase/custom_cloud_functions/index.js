const admin = require("firebase-admin/app");
admin.initializeApp();

const getGroupAppointments = require("./get_group_appointments.js");
exports.getGroupAppointments = getGroupAppointments.getGroupAppointments;
const compareSchedules = require("./compare_schedules.js");
exports.compareSchedules = compareSchedules.compareSchedules;
const getFriendListAvailability = require("./get_friend_list_availability.js");
exports.getFriendListAvailability =
  getFriendListAvailability.getFriendListAvailability;
const getGroupAvailability = require("./get_group_availability.js");
exports.getGroupAvailability = getGroupAvailability.getGroupAvailability;
const removeFriend = require("./remove_friend.js");
exports.removeFriend = removeFriend.removeFriend;
const leaveGroup = require("./leave_group.js");
exports.leaveGroup = leaveGroup.leaveGroup;
