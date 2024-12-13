import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ThemesRecord extends FirestoreRecord {
  ThemesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "themePhotos" field.
  String? _themePhotos;
  String get themePhotos => _themePhotos ?? '';
  bool hasThemePhotos() => _themePhotos != null;

  void _initializeFields() {
    _themePhotos = snapshotData['themePhotos'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('themes');

  static Stream<ThemesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ThemesRecord.fromSnapshot(s));

  static Future<ThemesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ThemesRecord.fromSnapshot(s));

  static ThemesRecord fromSnapshot(DocumentSnapshot snapshot) => ThemesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ThemesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ThemesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ThemesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ThemesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createThemesRecordData({
  String? themePhotos,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'themePhotos': themePhotos,
    }.withoutNulls,
  );

  return firestoreData;
}

class ThemesRecordDocumentEquality implements Equality<ThemesRecord> {
  const ThemesRecordDocumentEquality();

  @override
  bool equals(ThemesRecord? e1, ThemesRecord? e2) {
    return e1?.themePhotos == e2?.themePhotos;
  }

  @override
  int hash(ThemesRecord? e) => const ListEquality().hash([e?.themePhotos]);

  @override
  bool isValidKey(Object? o) => o is ThemesRecord;
}
