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
// import 'package:googleapis/calendar/v3.dart' as google_calendar;
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis_auth/auth_io.dart';

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
                final Appointment appointment = details.appointments!.first;
                final String? eventID = appointment.notes;

                if (eventID != null) {
                  // Fetch the full document from Firestore
                  final docSnapshot = await FirebaseFirestore.instance
                      .collection('appointments')
                      .doc(eventID)
                      .get();

                  if (docSnapshot.exists) {
                    // Navigate to the FlutterFlow `editEvent` screen
                    context.pushNamed(
                      'editEvent', // The name of your screen in FlutterFlow
                      extra: docSnapshot
                          .data(), // Pass the full document data as extra
                    );

                    print(
                        'Navigated to editEvent with document: ${docSnapshot.data()}');
                  } else {
                    print('Document with eventID: $eventID does not exist.');
                  }
                } else {
                  print('Event ID is null for the selected appointment.');
                }
              } else {
                print('Tapped on a non-appointment element.');
              }
            } catch (e, stackTrace) {
              print('Error while opening editEvent: $e');
              print(stackTrace);
            }
          }),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

/* Future<void> fetchAppointmentsFromGoogleCalendar() async {
  List<Appointment> meetings = [];
  final currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser == null) {
    print("No user is logged in.");
    return;
  }

  try {
    final googleSignIn = GoogleSignIn(
      scopes: [google_calendar.CalendarApi.calendarScope],
    );

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      print("Google sign-in failed.");
      return;
    }

    final authHeaders = await googleUser.authHeaders;
    final authenticatedClient = authenticatedClient(
      Client(),
      AccessCredentials(
        AccessToken(
          'Bearer',
          authHeaders['Authorization']!.split(' ').last,
          DateTime.now().add(Duration(hours: 1)),
        ),
        null,
        ['https://www.googleapis.com/auth/calendar.readonly'],
      ),
    );

    final calendarApi = google_calendar.CalendarApi(authenticatedClient);
    final events = await calendarApi.events.list('primary');

    for (var event in events.items!) {
      DateTime startTime = event.start!.dateTime ?? DateTime.now();
      DateTime endTime =
          event.end!.dateTime ?? DateTime.now().add(Duration(hours: 1));
      String eventName = event.summary ?? 'No Title';
      String eventDescription = event.description ?? '';
      bool isAllDay = event.start!.date != null;

      meetings.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: eventName,
        notes: event.id,
        isAllDay: isAllDay,
        color: Colors.blue, // Default color for Google Calendar events
      ));
    }

    setState(() {
      _dataSource = MeetingDataSource(meetings);
      print(
          "Appointments fetched from Google Calendar and data source updated successfully.");
    });
  } catch (e) {
    print("Error fetching appointments from Google Calendar: $e");
  }
} */
