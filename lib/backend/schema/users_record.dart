import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "birthday" field.
  DateTime? _birthday;
  DateTime? get birthday => _birthday;
  bool hasBirthday() => _birthday != null;

  // "realName" field.
  String? _realName;
  String get realName => _realName ?? '';
  bool hasRealName() => _realName != null;

  // "manualEventName" field.
  String? _manualEventName;
  String get manualEventName => _manualEventName ?? '';
  bool hasManualEventName() => _manualEventName != null;

  // "friendsList" field.
  List<String>? _friendsList;
  List<String> get friendsList => _friendsList ?? const [];
  bool hasFriendsList() => _friendsList != null;

  // "manualEventTime" field.
  DateTime? _manualEventTime;
  DateTime? get manualEventTime => _manualEventTime;
  bool hasManualEventTime() => _manualEventTime != null;

  // "manualEventDescription" field.
  String? _manualEventDescription;
  String get manualEventDescription => _manualEventDescription ?? '';
  bool hasManualEventDescription() => _manualEventDescription != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _birthday = snapshotData['birthday'] as DateTime?;
    _realName = snapshotData['realName'] as String?;
    _manualEventName = snapshotData['manualEventName'] as String?;
    _friendsList = getDataList(snapshotData['friendsList']);
    _manualEventTime = snapshotData['manualEventTime'] as DateTime?;
    _manualEventDescription = snapshotData['manualEventDescription'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  DateTime? birthday,
  String? realName,
  String? manualEventName,
  DateTime? manualEventTime,
  String? manualEventDescription,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'birthday': birthday,
      'realName': realName,
      'manualEventName': manualEventName,
      'manualEventTime': manualEventTime,
      'manualEventDescription': manualEventDescription,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.birthday == e2?.birthday &&
        e1?.realName == e2?.realName &&
        e1?.manualEventName == e2?.manualEventName &&
        listEquality.equals(e1?.friendsList, e2?.friendsList) &&
        e1?.manualEventTime == e2?.manualEventTime &&
        e1?.manualEventDescription == e2?.manualEventDescription;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.birthday,
        e?.realName,
        e?.manualEventName,
        e?.friendsList,
        e?.manualEventTime,
        e?.manualEventDescription
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
