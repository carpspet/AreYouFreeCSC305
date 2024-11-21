// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SyncfusionCalendar extends StatefulWidget {
  const SyncfusionCalendar({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<SyncfusionCalendar> createState() => _SyncfusionCalendarState();
}

class _SyncfusionCalendarState extends State<SyncfusionCalendar> {
  late MeetingDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    fetchAppointmentsFromFirebase();
  }

  Future<void> fetchAppointmentsFromFirebase() async {
    List<Appointment> meetings = [];
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print("No user is logged in.");
      return;
    }

    try {
      // Query the 'appointments' collection where 'userID' matches the current user's ID
      final snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('userID', isEqualTo: currentUser.uid)
          .get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();

        // Parse data from Firebase document to create an Appointment object
        DateTime startTime = (data['eventTime'] as Timestamp).toDate();
        DateTime endTime = (data['endTime'] as Timestamp).toDate();
        String eventName = data['eventName'] ?? 'No Title';
        String eventDescription = data['eventDescription'] ?? '';
        bool isAllDay = data['isAllDay'] ?? false;

        // Check if color is in the form of hex string (e.g., "#ef3939") and parse, otherwise set default color
        Color appointmentColor;
        if (data['color'] != null && data['color'] is String) {
          try {
            appointmentColor = _hexToColor(data['color']);
          } catch (e) {
            print("Invalid color format in database, defaulting to blue");
            appointmentColor = Colors.blue; // Default blue color
          }
        } else {
          appointmentColor = Colors.blue; // Default blue color
        }

        // Create Appointment object and add it to the list
        meetings.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: eventName,
          notes: doc.id, // Pass the document ID in notes for navigation
          isAllDay: isAllDay,
          color: appointmentColor,
        ));
      }

      setState(() {
        _dataSource = MeetingDataSource(meetings);
      });
    } catch (e) {
      print("Error fetching appointments from Firebase: $e");
    }
  }

  // Helper function to convert a hex color string (e.g., "#ef3939") to a Color object
  Color _hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll("#", ""); // Remove "#" if it exists
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Add full opacity if alpha is not specified
    }
    return Color(int.parse("0x$hexColor"));
  }

  // Method to refresh calendar data
  void refreshCalendar() {
    fetchAppointmentsFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.week,
        showCurrentTimeIndicator: true,
        dataSource: _dataSource,
        timeSlotViewSettings: const TimeSlotViewSettings(
          startHour: 1,
          endHour: 24,
          numberOfDaysInView: 1,
          timeIntervalHeight: 100,
          timeRulerSize: 90,
          timeTextStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Colors.blue,
          ),
        ),
        onTap: (CalendarTapDetails details) async {
          try {
            if (details.targetElement == CalendarElement.appointment) {
              // Get the tapped appointment
              final Appointment appointment = details.appointments!.first;

              // Extract the document reference (eventID)
              final String? eventID =
                  appointment.notes; // Ensure `notes` contains the document ID

              if (eventID != null) {
                // Navigate to the editEvent component
                context.pushNamed(
                  'editEvent',
                  queryParameters: {
                    'eventID': eventID, // Pass the document reference
                  },
                );
                print('Tapped eventID: $eventID');
              } else {
                print('Event ID is null for the selected appointment.');
                print('Tapped eventID: $eventID');
              }
            }
          } catch (e) {
            print('Error while opening editEvent: $e');
          }
        },
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
