import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProjectsRecord extends FirestoreRecord {
  ProjectsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "owner" field.
  DocumentReference? _owner;
  DocumentReference? get owner => _owner;
  bool hasOwner() => _owner != null;

  // "usersAssigned" field.
  List<DocumentReference>? _usersAssigned;
  List<DocumentReference> get usersAssigned => _usersAssigned ?? const [];
  bool hasUsersAssigned() => _usersAssigned != null;

  // "projectName" field.
  String? _projectName;
  String get projectName => _projectName ?? '';
  bool hasProjectName() => _projectName != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "numberTasks" field.
  int? _numberTasks;
  int get numberTasks => _numberTasks ?? 0;
  bool hasNumberTasks() => _numberTasks != null;

  // "completedTasks" field.
  int? _completedTasks;
  int get completedTasks => _completedTasks ?? 0;
  bool hasCompletedTasks() => _completedTasks != null;

  // "lastEdited" field.
  DateTime? _lastEdited;
  DateTime? get lastEdited => _lastEdited;
  bool hasLastEdited() => _lastEdited != null;

  // "timeCreated" field.
  DateTime? _timeCreated;
  DateTime? get timeCreated => _timeCreated;
  bool hasTimeCreated() => _timeCreated != null;

  // "orgRef" field.
  DocumentReference? _orgRef;
  DocumentReference? get orgRef => _orgRef;
  bool hasOrgRef() => _orgRef != null;

  void _initializeFields() {
    _owner = snapshotData['owner'] as DocumentReference?;
    _usersAssigned = getDataList(snapshotData['usersAssigned']);
    _projectName = snapshotData['projectName'] as String?;
    _description = snapshotData['description'] as String?;
    _numberTasks = castToType<int>(snapshotData['numberTasks']);
    _completedTasks = castToType<int>(snapshotData['completedTasks']);
    _lastEdited = snapshotData['lastEdited'] as DateTime?;
    _timeCreated = snapshotData['timeCreated'] as DateTime?;
    _orgRef = snapshotData['orgRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('projects');

  static Stream<ProjectsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProjectsRecord.fromSnapshot(s));

  static Future<ProjectsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProjectsRecord.fromSnapshot(s));

  static ProjectsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProjectsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProjectsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProjectsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProjectsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProjectsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProjectsRecordData({
  DocumentReference? owner,
  String? projectName,
  String? description,
  int? numberTasks,
  int? completedTasks,
  DateTime? lastEdited,
  DateTime? timeCreated,
  DocumentReference? orgRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'owner': owner,
      'projectName': projectName,
      'description': description,
      'numberTasks': numberTasks,
      'completedTasks': completedTasks,
      'lastEdited': lastEdited,
      'timeCreated': timeCreated,
      'orgRef': orgRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProjectsRecordDocumentEquality implements Equality<ProjectsRecord> {
  const ProjectsRecordDocumentEquality();

  @override
  bool equals(ProjectsRecord? e1, ProjectsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.owner == e2?.owner &&
        listEquality.equals(e1?.usersAssigned, e2?.usersAssigned) &&
        e1?.projectName == e2?.projectName &&
        e1?.description == e2?.description &&
        e1?.numberTasks == e2?.numberTasks &&
        e1?.completedTasks == e2?.completedTasks &&
        e1?.lastEdited == e2?.lastEdited &&
        e1?.timeCreated == e2?.timeCreated &&
        e1?.orgRef == e2?.orgRef;
  }

  @override
  int hash(ProjectsRecord? e) => const ListEquality().hash([
        e?.owner,
        e?.usersAssigned,
        e?.projectName,
        e?.description,
        e?.numberTasks,
        e?.completedTasks,
        e?.lastEdited,
        e?.timeCreated,
        e?.orgRef
      ]);

  @override
  bool isValidKey(Object? o) => o is ProjectsRecord;
}
