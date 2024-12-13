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
import 'package:cloud_functions/cloud_functions.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();
  factory FFAppState() => _instance;
  FFAppState._internal();

  final ValueNotifier<String> monthYearTextNotifier =
      ValueNotifier<String>("December 2024");

  final ValueNotifier<String> dayTextNotifier =
      ValueNotifier<String>("Monday, 2");
}

class GroupCalendar extends StatefulWidget {
  const GroupCalendar({
    super.key,
    this.width,
    this.height,
    required this.groupName,
  });

  final double? width;
  final double? height;
  final String groupName;

  @override
  State<GroupCalendar> createState() => _GroupCalendarState();
}

class _GroupCalendarState extends State<GroupCalendar> {
  late MeetingDataSource _dataSource =
      MeetingDataSource([]); // Empty initial state
  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
    fetchGroupAppointments(widget.groupName);

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

  Future<void> fetchGroupAppointments(String groupName) async {
    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('getGroupAppointments');
      final response = await callable.call({'groupName': groupName});

      final appointmentsData = response.data['appointments'] as List;

      final groupAppointments = appointmentsData.map((data) {
        final startTimeUTC = DateTime.parse(data['eventTime']);
        final endTimeUTC = DateTime.parse(data['endTime']);
        final startTimeLocal = startTimeUTC.toLocal();
        final endTimeLocal = endTimeUTC.toLocal();
        final bool isDaily = data['isDaily'] ?? false;
        final bool isWeekly = data['isWeekly'] ?? false;
        final eventColor = _hexToColor(data['color']);
        final photoURL = data['photoURL'] ?? "";

        // Handle recurrence rules based on isDaily and isWeekly
        String? recurrenceRule;
        if (isDaily) {
          recurrenceRule = 'FREQ=DAILY;INTERVAL=1';
        } else if (isWeekly) {
          final weekdayAbbreviations = [
            'SU',
            'MO',
            'TU',
            'WE',
            'TH',
            'FR',
            'SA'
          ];
          final eventWeekday = weekdayAbbreviations[startTimeUTC.weekday % 7];
          recurrenceRule = 'FREQ=WEEKLY;BYDAY=$eventWeekday;INTERVAL=1';
        }

        return Appointment(
          startTime: startTimeLocal,
          endTime: endTimeLocal,
          subject: data['eventName'],
          isAllDay: data['isAllDay'] ?? false,
          color: eventColor,
          notes: photoURL,
          recurrenceRule: recurrenceRule,
        );
      }).toList();

      setState(() {
        _dataSource = MeetingDataSource(groupAppointments);
      });
    } catch (e) {
      print("Error fetching group appointments: $e");
    }
  }

  Color _hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
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
        // Month-Year Header
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
        // Day Header
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
              final String? photoURL = appointment.notes;

              return Container(
                color: appointment.color,
                child: appointment.isAllDay
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          appointment.subject,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          if (photoURL != null && photoURL.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(photoURL),
                                backgroundColor: Colors.grey[300],
                              ),
                            ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                appointment.subject,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
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
