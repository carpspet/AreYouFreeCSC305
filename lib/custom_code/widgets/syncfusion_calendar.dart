// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:googleapis/calendar/v3.dart' as google_calendar;
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis_auth/auth_io.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();
  factory FFAppState() => _instance;
  FFAppState._internal();

  final ValueNotifier<String> monthYearTextNotifier =
      ValueNotifier("December 2024");
  final ValueNotifier<String> dayTextNotifier = ValueNotifier("Monday, 2");
}

class SyncfusionCalendar extends StatefulWidget {
  const SyncfusionCalendar({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  State<SyncfusionCalendar> createState() => _SyncfusionCalendarState();
}

class _SyncfusionCalendarState extends State<SyncfusionCalendar> {
  late MeetingDataSource _dataSource;
  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
    fetchAppointmentsFromFirebase();

    final currentDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateHeaderText(currentDate);
    });

    _calendarController.addPropertyChangedListener(_onCalendarPropertyChanged);
  }

  @override
  void dispose() {
    _calendarController
        .removePropertyChangedListener(_onCalendarPropertyChanged);
    super.dispose();
  }

  void _onCalendarPropertyChanged(String propertyName) {
    if (propertyName == 'displayDate') {
      final displayDate = _calendarController.displayDate ?? DateTime.now();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateHeaderText(displayDate);
      });
    }
  }

  Future<void> fetchAppointmentsFromFirebase() async {
    List<Appointment> meetings = [];
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print("No user is logged in.");
      return;
    }

    try {
      // Fetch the current user's display_name from the users collection
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (!userSnapshot.exists) {
        print("No user document found for the current user.");
        return;
      }

      final userData = userSnapshot.data() as Map<String, dynamic>;
      final String? displayName = userData['display_name'];

      if (displayName == null || displayName.isEmpty) {
        print("Display name not found for the current user.");
        return;
      }

      // Query the appointments collection using the display_name as userID
      final snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('userID', isEqualTo: displayName)
          .get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();

        DateTime startTime = (data['eventTime'] as Timestamp).toDate();
        DateTime endTime = (data['endTime'] as Timestamp).toDate();
        String eventName = data['eventName'] ?? 'No Title';
        String eventDescription = data['eventDescription'] ?? '';
        bool isAllDay = data['isAllDay'] ?? false;
        bool isDaily = data['daily'] ?? false;
        bool isWeekly = data['weekly'] ?? false;
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

        String? recurrenceRule;

        // Define recurrence rules based on daily and weekly flags
        if (isDaily) {
          recurrenceRule = 'FREQ=DAILY;INTERVAL=1';
        } else if (isWeekly) {
          // Determine the day of the week for the event
          final weekdayAbbreviations = [
            'SU',
            'MO',
            'TU',
            'WE',
            'TH',
            'FR',
            'SA'
          ]; // Sunday to Saturday
          String eventWeekday = weekdayAbbreviations[startTime.weekday % 7];

          // Set the recurrence rule for the specific day of the week
          recurrenceRule = 'FREQ=WEEKLY;BYDAY=$eventWeekday;INTERVAL=1';
        }

        meetings.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: "$eventName\n$eventDescription",
          notes: doc.id,
          isAllDay: isAllDay,
          color: appointmentColor,
          recurrenceRule: recurrenceRule,
        ));
      }

      setState(() {
        _dataSource = MeetingDataSource(meetings);
      });
    } catch (e) {
      print("Error fetching appointments from Firebase: $e");
    }
  }

  Color _hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll("#", ""); // Remove "#" if it exists
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Add full opacity if alpha is not specified
    }
    return Color(int.parse("0x$hexColor"));
  }

  void _updateHeaderText(DateTime date) {
    FFAppState().monthYearTextNotifier.value =
        "${_monthName(date.month)} ${date.year}";
    FFAppState().dayTextNotifier.value =
        "${_weekdayName(date.weekday)}, ${date.day}";
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  String _weekdayName(int weekday) {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return weekdays[weekday - 1];
  }

  void _showMiniCalendar() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _calendarController.displayDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _calendarController.displayDate = selectedDate;
        _updateHeaderText(selectedDate);
      });
    }
  }

  void _resetToCurrentDay() {
    final currentDate = DateTime.now();
    setState(() {
      _calendarController.displayDate = currentDate;
      _updateHeaderText(currentDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                onPressed: () {
                  final currentDate =
                      _calendarController.displayDate ?? DateTime.now();
                  final newDate = DateTime(
                      currentDate.year, currentDate.month - 1, currentDate.day);
                  _calendarController.displayDate = newDate;
                },
              ),
              GestureDetector(
                onTap: _showMiniCalendar,
                child: ValueListenableBuilder<String>(
                  valueListenable: FFAppState().monthYearTextNotifier,
                  builder: (context, value, child) {
                    return Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.white),
                onPressed: () {
                  final currentDate =
                      _calendarController.displayDate ?? DateTime.now();
                  final newDate = DateTime(
                      currentDate.year, currentDate.month + 1, currentDate.day);
                  _calendarController.displayDate = newDate;
                },
              ),
            ],
          ),
        ),
        Container(
          color: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                onPressed: () {
                  final currentDate =
                      _calendarController.displayDate ?? DateTime.now();
                  final newDate = currentDate.subtract(Duration(days: 1));
                  _calendarController.displayDate = newDate;
                },
              ),
              GestureDetector(
                onTap: _resetToCurrentDay,
                child: ValueListenableBuilder<String>(
                  valueListenable: FFAppState().dayTextNotifier,
                  builder: (context, value, child) {
                    return Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.white),
                onPressed: () {
                  final currentDate =
                      _calendarController.displayDate ?? DateTime.now();
                  final newDate = currentDate.add(Duration(days: 1));
                  _calendarController.displayDate = newDate;
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: SfCalendar(
            controller: _calendarController,
            view: CalendarView.week,
            headerHeight: 0,
            viewHeaderHeight: 0,
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
            appointmentBuilder:
                (BuildContext context, CalendarAppointmentDetails details) {
              final Appointment appointment = details.appointments.first;

              return GestureDetector(
                onTap: () async {
                  try {
                    final String? eventID = appointment.notes;

                    if (eventID != null) {
                      // Navigate to the edit event screen with the event ID
                      context.pushNamed(
                        'editEvent',
                        queryParameters: {'eventID': eventID},
                      );
                      print('Navigated to editEvent with eventID: $eventID');
                    } else {
                      print('Event ID is null for the selected appointment.');
                    }
                  } catch (e, stackTrace) {
                    print('Error while opening editEvent: $e');
                    print(stackTrace);
                  }
                },
                child: Container(
                  color: appointment.color, // Use the appointment's color
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Only show the event name for all-day events
                      if (appointment.isAllDay)
                        Text(
                          appointment.subject.split('\n')[0], // Event name
                          style: const TextStyle(
                            fontSize: 14, // Slightly smaller font size
                            fontWeight: FontWeight.bold, // Bold event name
                            color:
                                Colors.white, // White text for better contrast
                          ),
                        ),
                      if (!appointment.isAllDay) ...[
                        Text(
                          appointment.subject.split('\n')[0], // Event name
                          style: const TextStyle(
                            fontSize: 14, // Bigger font size for event name
                            fontWeight: FontWeight.bold, // Bold event name
                            color: Colors.white, // White text for contrast
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          appointment.subject.split('\n').length > 1
                              ? appointment.subject.split('\n')[1]
                              : '', // Subject/description
                          style: const TextStyle(
                            fontSize: 12, // Smaller font size for description
                            color: Colors.white, // Less visible grey color
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

// Future<void> fetchAppointmentsFromGoogleCalendar() async {
//   List<Appointment> meetings = [];
//   final currentUser = FirebaseAuth.instance.currentUser;

//   if (currentUser == null) {
//     print("No user is logged in.");
//     return;
//   }

//   try {
//     final googleSignIn = GoogleSignIn(
//       scopes: [google_calendar.CalendarApi.calendarScope],
//     );

//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) {
//       print("Google sign-in failed.");
//       return;
//     }

//     final authHeaders = await googleUser.authHeaders;
//     final authenticatedClient = authenticatedClient(
//       Client(),
//       AccessCredentials(
//         AccessToken(
//           'Bearer',
//           authHeaders['Authorization']!.split(' ').last,
//           DateTime.now().add(Duration(hours: 1)),
//         ),
//         null,
//         ['https://www.googleapis.com/auth/calendar.readonly'],
//       ),
//     );

//     final calendarApi = google_calendar.CalendarApi(authenticatedClient);
//     final events = await calendarApi.events.list('primary');

//     for (var event in events.items!) {
//       DateTime startTime = event.start!.dateTime ?? DateTime.now();
//       DateTime endTime =
//           event.end!.dateTime ?? DateTime.now().add(Duration(hours: 1));
//       String eventName = event.summary ?? 'No Title';
//       String eventDescription = event.description ?? '';
//       bool isAllDay = event.start!.date != null;

//       meetings.add(Appointment(
//         startTime: startTime,
//         endTime: endTime,
//         subject: eventName,
//         notes: event.id,
//         isAllDay: isAllDay,
//         color: Colors.blue, // Default color for Google Calendar events
//       ));
//     }

//     setState(() {
//       _dataSource = MeetingDataSource(meetings);
//       print(
//           "Appointments fetched from Google Calendar and data source updated successfully.");
//     });
//   } catch (e) {
//     print("Error fetching appointments from Google Calendar: $e");
//   }
// }
