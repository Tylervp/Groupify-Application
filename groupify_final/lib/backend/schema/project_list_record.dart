import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class ProjectListRecord extends FirestoreRecord {
  ProjectListRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "projects" field.
  List<String>? _projects;
  List<String> get projects => _projects ?? const [];
  bool hasProjects() => _projects != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  void _initializeFields() {
    _projects = getDataList(snapshotData['projects']);
    _userRef = snapshotData['userRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('projectList');

  static Stream<ProjectListRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProjectListRecord.fromSnapshot(s));

  static Future<ProjectListRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProjectListRecord.fromSnapshot(s));

  static ProjectListRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProjectListRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProjectListRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProjectListRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProjectListRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProjectListRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProjectListRecordData({
  DocumentReference? userRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProjectListRecordDocumentEquality implements Equality<ProjectListRecord> {
  const ProjectListRecordDocumentEquality();

  @override
  bool equals(ProjectListRecord? e1, ProjectListRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.projects, e2?.projects) &&
        e1?.userRef == e2?.userRef;
  }

  @override
  int hash(ProjectListRecord? e) =>
      const ListEquality().hash([e?.projects, e?.userRef]);

  @override
  bool isValidKey(Object? o) => o is ProjectListRecord;
}
