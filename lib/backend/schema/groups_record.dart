import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GroupsRecord extends FirestoreRecord {
  GroupsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "GroupName" field.
  String? _groupName;
  String get groupName => _groupName ?? '';
  bool hasGroupName() => _groupName != null;

  // "UserInGroup" field.
  List<String>? _userInGroup;
  List<String> get userInGroup => _userInGroup ?? const [];
  bool hasUserInGroup() => _userInGroup != null;

  void _initializeFields() {
    _groupName = snapshotData['GroupName'] as String?;
    _userInGroup = getDataList(snapshotData['UserInGroup']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Groups');

  static Stream<GroupsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GroupsRecord.fromSnapshot(s));

  static Future<GroupsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GroupsRecord.fromSnapshot(s));

  static GroupsRecord fromSnapshot(DocumentSnapshot snapshot) => GroupsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GroupsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GroupsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GroupsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GroupsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGroupsRecordData({
  String? groupName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'GroupName': groupName,
    }.withoutNulls,
  );

  return firestoreData;
}

class GroupsRecordDocumentEquality implements Equality<GroupsRecord> {
  const GroupsRecordDocumentEquality();

  @override
  bool equals(GroupsRecord? e1, GroupsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.groupName == e2?.groupName &&
        listEquality.equals(e1?.userInGroup, e2?.userInGroup);
  }

  @override
  int hash(GroupsRecord? e) =>
      const ListEquality().hash([e?.groupName, e?.userInGroup]);

  @override
  bool isValidKey(Object? o) => o is GroupsRecord;
}
