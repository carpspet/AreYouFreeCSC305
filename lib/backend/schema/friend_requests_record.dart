import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FriendRequestsRecord extends FirestoreRecord {
  FriendRequestsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "senderID" field.
  String? _senderID;
  String get senderID => _senderID ?? '';
  bool hasSenderID() => _senderID != null;

  // "receiverID" field.
  String? _receiverID;
  String get receiverID => _receiverID ?? '';
  bool hasReceiverID() => _receiverID != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "username" field.
  String? _username;
  String get username => _username ?? '';
  bool hasUsername() => _username != null;

  void _initializeFields() {
    _senderID = snapshotData['senderID'] as String?;
    _receiverID = snapshotData['receiverID'] as String?;
    _status = snapshotData['status'] as String?;
    _username = snapshotData['username'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('friendRequests');

  static Stream<FriendRequestsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FriendRequestsRecord.fromSnapshot(s));

  static Future<FriendRequestsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FriendRequestsRecord.fromSnapshot(s));

  static FriendRequestsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FriendRequestsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FriendRequestsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FriendRequestsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FriendRequestsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FriendRequestsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFriendRequestsRecordData({
  String? senderID,
  String? receiverID,
  String? status,
  String? username,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'senderID': senderID,
      'receiverID': receiverID,
      'status': status,
      'username': username,
    }.withoutNulls,
  );

  return firestoreData;
}

class FriendRequestsRecordDocumentEquality
    implements Equality<FriendRequestsRecord> {
  const FriendRequestsRecordDocumentEquality();

  @override
  bool equals(FriendRequestsRecord? e1, FriendRequestsRecord? e2) {
    return e1?.senderID == e2?.senderID &&
        e1?.receiverID == e2?.receiverID &&
        e1?.status == e2?.status &&
        e1?.username == e2?.username;
  }

  @override
  int hash(FriendRequestsRecord? e) => const ListEquality()
      .hash([e?.senderID, e?.receiverID, e?.status, e?.username]);

  @override
  bool isValidKey(Object? o) => o is FriendRequestsRecord;
}
