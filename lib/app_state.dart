import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

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
}
