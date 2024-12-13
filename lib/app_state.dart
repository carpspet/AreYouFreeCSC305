import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _BorderColor =
          _colorFromIntValue(prefs.getInt('ff_BorderColor')) ?? _BorderColor;
    });
    _safeInit(() {
      _ButtonColor =
          _colorFromIntValue(prefs.getInt('ff_ButtonColor')) ?? _ButtonColor;
    });
    _safeInit(() {
      _BackgroundColor =
          _colorFromIntValue(prefs.getInt('ff_BackgroundColor')) ??
              _BackgroundColor;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _pendingStatus = '';
  String get pendingStatus => _pendingStatus;
  set pendingStatus(String value) {
    _pendingStatus = value;
  }

  String _friendEmail = '';
  String get friendEmail => _friendEmail;
  set friendEmail(String value) {
    _friendEmail = value;
  }

  List<String> _userFriendsList = [];
  List<String> get userFriendsList => _userFriendsList;
  set userFriendsList(List<String> value) {
    _userFriendsList = value;
  }

  void addToUserFriendsList(String value) {
    userFriendsList.add(value);
  }

  void removeFromUserFriendsList(String value) {
    userFriendsList.remove(value);
  }

  void removeAtIndexFromUserFriendsList(int index) {
    userFriendsList.removeAt(index);
  }

  void updateUserFriendsListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    userFriendsList[index] = updateFn(_userFriendsList[index]);
  }

  void insertAtIndexInUserFriendsList(int index, String value) {
    userFriendsList.insert(index, value);
  }

  List<String> _usersFriendRequests = [];
  List<String> get usersFriendRequests => _usersFriendRequests;
  set usersFriendRequests(List<String> value) {
    _usersFriendRequests = value;
  }

  void addToUsersFriendRequests(String value) {
    usersFriendRequests.add(value);
  }

  void removeFromUsersFriendRequests(String value) {
    usersFriendRequests.remove(value);
  }

  void removeAtIndexFromUsersFriendRequests(int index) {
    usersFriendRequests.removeAt(index);
  }

  void updateUsersFriendRequestsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    usersFriendRequests[index] = updateFn(_usersFriendRequests[index]);
  }

  void insertAtIndexInUsersFriendRequests(int index, String value) {
    usersFriendRequests.insert(index, value);
  }

  bool _allDay = false;
  bool get allDay => _allDay;
  set allDay(bool value) {
    _allDay = value;
  }

  bool _Weekly = false;
  bool get Weekly => _Weekly;
  set Weekly(bool value) {
    _Weekly = value;
  }

  bool _Monthly = false;
  bool get Monthly => _Monthly;
  set Monthly(bool value) {
    _Monthly = value;
  }

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  set selectedDate(DateTime? value) {
    _selectedDate = value;
  }

  bool _goToNextDay = false;
  bool get goToNextDay => _goToNextDay;
  set goToNextDay(bool value) {
    _goToNextDay = value;
  }

  bool _goToPreviousDay = false;
  bool get goToPreviousDay => _goToPreviousDay;
  set goToPreviousDay(bool value) {
    _goToPreviousDay = value;
  }

  bool _goToNextMonth = false;
  bool get goToNextMonth => _goToNextMonth;
  set goToNextMonth(bool value) {
    _goToNextMonth = value;
  }

  bool _goToPreviousMonth = false;
  bool get goToPreviousMonth => _goToPreviousMonth;
  set goToPreviousMonth(bool value) {
    _goToPreviousMonth = value;
  }

  String _monthYearText = 'Month';
  String get monthYearText => _monthYearText;
  set monthYearText(String value) {
    _monthYearText = value;
  }

  String _dayText = 'Day';
  String get dayText => _dayText;
  set dayText(String value) {
    _dayText = value;
  }

  bool _daily = false;
  bool get daily => _daily;
  set daily(bool value) {
    _daily = value;
  }

  String _groupName = '';
  String get groupName => _groupName;
  set groupName(String value) {
    _groupName = value;
  }

  Color _BorderColor = const Color(0xcfa839ef);
  Color get BorderColor => _BorderColor;
  set BorderColor(Color value) {
    _BorderColor = value;
    prefs.setInt('ff_BorderColor', value.value);
  }

  Color _ButtonColor = const Color(0xfff1f4f8);
  Color get ButtonColor => _ButtonColor;
  set ButtonColor(Color value) {
    _ButtonColor = value;
    prefs.setInt('ff_ButtonColor', value.value);
  }

  Color _BackgroundColor = const Color(0xfff1f4f8);
  Color get BackgroundColor => _BackgroundColor;
  set BackgroundColor(Color value) {
    _BackgroundColor = value;
    prefs.setInt('ff_BackgroundColor', value.value);
  }

  bool _groupCalendar = false;
  bool get groupCalendar => _groupCalendar;
  set groupCalendar(bool value) {
    _groupCalendar = value;
  }

  String _groupNameTab = '';
  String get groupNameTab => _groupNameTab;
  set groupNameTab(String value) {
    _groupNameTab = value;
  }

  bool _timePicked1 = false;
  bool get timePicked1 => _timePicked1;
  set timePicked1(bool value) {
    _timePicked1 = value;
  }

  bool _timePicked2 = false;
  bool get timePicked2 => _timePicked2;
  set timePicked2(bool value) {
    _timePicked2 = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

Color? _colorFromIntValue(int? val) {
  if (val == null) {
    return null;
  }
  return Color(val);
}
