import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class NotesRecord extends FirestoreRecord {
  NotesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "owner" field.
  DocumentReference? _owner;
  DocumentReference? get owner => _owner;
  bool hasOwner() => _owner != null;

  // "taskRef" field.
  DocumentReference? _taskRef;
  DocumentReference? get taskRef => _taskRef;
  bool hasTaskRef() => _taskRef != null;

  // "note" field.
  String? _note;
  String get note => _note ?? '';
  bool hasNote() => _note != null;

  // "timePosted" field.
  DateTime? _timePosted;
  DateTime? get timePosted => _timePosted;
  bool hasTimePosted() => _timePosted != null;

  void _initializeFields() {
    _owner = snapshotData['owner'] as DocumentReference?;
    _taskRef = snapshotData['taskRef'] as DocumentReference?;
    _note = snapshotData['note'] as String?;
    _timePosted = snapshotData['timePosted'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notes');

  static Stream<NotesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotesRecord.fromSnapshot(s));

  static Future<NotesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotesRecord.fromSnapshot(s));

  static NotesRecord fromSnapshot(DocumentSnapshot snapshot) => NotesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotesRecordData({
  DocumentReference? owner,
  DocumentReference? taskRef,
  String? note,
  DateTime? timePosted,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'owner': owner,
      'taskRef': taskRef,
      'note': note,
      'timePosted': timePosted,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotesRecordDocumentEquality implements Equality<NotesRecord> {
  const NotesRecordDocumentEquality();

  @override
  bool equals(NotesRecord? e1, NotesRecord? e2) {
    return e1?.owner == e2?.owner &&
        e1?.taskRef == e2?.taskRef &&
        e1?.note == e2?.note &&
        e1?.timePosted == e2?.timePosted;
  }

  @override
  int hash(NotesRecord? e) =>
      const ListEquality().hash([e?.owner, e?.taskRef, e?.note, e?.timePosted]);

  @override
  bool isValidKey(Object? o) => o is NotesRecord;
}
