import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AppointmentsRecord extends FirestoreRecord {
  AppointmentsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "userID" field.
  String? _userID;
  String get userID => _userID ?? '';
  bool hasUserID() => _userID != null;

  // "eventName" field.
  String? _eventName;
  String get eventName => _eventName ?? '';
  bool hasEventName() => _eventName != null;

  // "eventTime" field.
  DateTime? _eventTime;
  DateTime? get eventTime => _eventTime;
  bool hasEventTime() => _eventTime != null;

  // "endTime" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  bool hasEndTime() => _endTime != null;

  // "eventDescription" field.
  String? _eventDescription;
  String get eventDescription => _eventDescription ?? '';
  bool hasEventDescription() => _eventDescription != null;

  // "isAllDay" field.
  bool? _isAllDay;
  bool get isAllDay => _isAllDay ?? false;
  bool hasIsAllDay() => _isAllDay != null;

  // "weekly" field.
  bool? _weekly;
  bool get weekly => _weekly ?? false;
  bool hasWeekly() => _weekly != null;

  // "color" field.
  Color? _color;
  Color? get color => _color;
  bool hasColor() => _color != null;

  // "daily" field.
  bool? _daily;
  bool get daily => _daily ?? false;
  bool hasDaily() => _daily != null;

  void _initializeFields() {
    _userID = snapshotData['userID'] as String?;
    _eventName = snapshotData['eventName'] as String?;
    _eventTime = snapshotData['eventTime'] as DateTime?;
    _endTime = snapshotData['endTime'] as DateTime?;
    _eventDescription = snapshotData['eventDescription'] as String?;
    _isAllDay = snapshotData['isAllDay'] as bool?;
    _weekly = snapshotData['weekly'] as bool?;
    _color = getSchemaColor(snapshotData['color']);
    _daily = snapshotData['daily'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('appointments');

  static Stream<AppointmentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AppointmentsRecord.fromSnapshot(s));

  static Future<AppointmentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AppointmentsRecord.fromSnapshot(s));

  static AppointmentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AppointmentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AppointmentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AppointmentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AppointmentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AppointmentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAppointmentsRecordData({
  String? userID,
  String? eventName,
  DateTime? eventTime,
  DateTime? endTime,
  String? eventDescription,
  bool? isAllDay,
  bool? weekly,
  Color? color,
  bool? daily,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userID': userID,
      'eventName': eventName,
      'eventTime': eventTime,
      'endTime': endTime,
      'eventDescription': eventDescription,
      'isAllDay': isAllDay,
      'weekly': weekly,
      'color': color,
      'daily': daily,
    }.withoutNulls,
  );

  return firestoreData;
}

class AppointmentsRecordDocumentEquality
    implements Equality<AppointmentsRecord> {
  const AppointmentsRecordDocumentEquality();

  @override
  bool equals(AppointmentsRecord? e1, AppointmentsRecord? e2) {
    return e1?.userID == e2?.userID &&
        e1?.eventName == e2?.eventName &&
        e1?.eventTime == e2?.eventTime &&
        e1?.endTime == e2?.endTime &&
        e1?.eventDescription == e2?.eventDescription &&
        e1?.isAllDay == e2?.isAllDay &&
        e1?.weekly == e2?.weekly &&
        e1?.color == e2?.color &&
        e1?.daily == e2?.daily;
  }

  @override
  int hash(AppointmentsRecord? e) => const ListEquality().hash([
        e?.userID,
        e?.eventName,
        e?.eventTime,
        e?.endTime,
        e?.eventDescription,
        e?.isAllDay,
        e?.weekly,
        e?.color,
        e?.daily
      ]);

  @override
  bool isValidKey(Object? o) => o is AppointmentsRecord;
}
