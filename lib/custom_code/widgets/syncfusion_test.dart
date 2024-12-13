// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SyncfusionTest extends StatefulWidget {
  const SyncfusionTest({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<SyncfusionTest> createState() => _SyncfusionTestState();
}

class _SyncfusionTestState extends State<SyncfusionTest> {
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
        bool isAllDay = data['isAllDay'] ?? false;

        // Parse color or use default blue
        Color appointmentColor;
        if (data['color'] != null && data['color'] is String) {
          try {
            appointmentColor = _hexToColor(data['color']);
          } catch (e) {
            appointmentColor = Colors.blue; // Default color
          }
        } else {
          appointmentColor = Colors.blue; // Default color
        }

        meetings.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: eventName,
          notes: doc.id, // Document ID stored in notes
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

  // Helper to convert hex string to Color
  Color _hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse("0x$hexColor"));
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
              final Appointment appointment = details.appointments!.first;
              final String? eventID = appointment.notes;

              if (eventID != null) {
                // Fetch full document from Firestore
                final docSnapshot = await FirebaseFirestore.instance
                    .collection('appointments')
                    .doc(eventID)
                    .get();

                if (docSnapshot.exists) {
                  context.pushNamed(
                    'editEvent',
                    extra: docSnapshot.data(),
                  );
                } else {
                  print('Document with eventID: $eventID does not exist.');
                }
              } else {
                print('Event ID is null for the selected appointment.');
              }
            }
          } catch (e, stackTrace) {
            print('Error while opening editEvent: $e');
            print(stackTrace);
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
