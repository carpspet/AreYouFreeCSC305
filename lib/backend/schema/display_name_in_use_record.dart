import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DisplayNameInUseRecord extends FirestoreRecord {
  DisplayNameInUseRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "displayNamesUsed" field.
  List<String>? _displayNamesUsed;
  List<String> get displayNamesUsed => _displayNamesUsed ?? const [];
  bool hasDisplayNamesUsed() => _displayNamesUsed != null;

  void _initializeFields() {
    _displayNamesUsed = getDataList(snapshotData['displayNamesUsed']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('displayNameInUse');

  static Stream<DisplayNameInUseRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DisplayNameInUseRecord.fromSnapshot(s));

  static Future<DisplayNameInUseRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => DisplayNameInUseRecord.fromSnapshot(s));

  static DisplayNameInUseRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DisplayNameInUseRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DisplayNameInUseRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DisplayNameInUseRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DisplayNameInUseRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DisplayNameInUseRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDisplayNameInUseRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class DisplayNameInUseRecordDocumentEquality
    implements Equality<DisplayNameInUseRecord> {
  const DisplayNameInUseRecordDocumentEquality();

  @override
  bool equals(DisplayNameInUseRecord? e1, DisplayNameInUseRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.displayNamesUsed, e2?.displayNamesUsed);
  }

  @override
  int hash(DisplayNameInUseRecord? e) =>
      const ListEquality().hash([e?.displayNamesUsed]);

  @override
  bool isValidKey(Object? o) => o is DisplayNameInUseRecord;
}
