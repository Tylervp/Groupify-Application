import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class OrganizationsRecord extends FirestoreRecord {
  OrganizationsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "OrgName" field.
  String? _orgName;
  String get orgName => _orgName ?? '';
  bool hasOrgName() => _orgName != null;

  // "createdOn" field.
  DateTime? _createdOn;
  DateTime? get createdOn => _createdOn;
  bool hasCreatedOn() => _createdOn != null;

  // "OrgMembers" field.
  List<DocumentReference>? _orgMembers;
  List<DocumentReference> get orgMembers => _orgMembers ?? const [];
  bool hasOrgMembers() => _orgMembers != null;

  // "OrgLogo" field.
  String? _orgLogo;
  String get orgLogo => _orgLogo ?? '';
  bool hasOrgLogo() => _orgLogo != null;

  // "OrgDescription" field.
  String? _orgDescription;
  String get orgDescription => _orgDescription ?? '';
  bool hasOrgDescription() => _orgDescription != null;

  // "lastEdited" field.
  DateTime? _lastEdited;
  DateTime? get lastEdited => _lastEdited;
  bool hasLastEdited() => _lastEdited != null;

  // "OrgAdmin" field.
  DocumentReference? _orgAdmin;
  DocumentReference? get orgAdmin => _orgAdmin;
  bool hasOrgAdmin() => _orgAdmin != null;

  void _initializeFields() {
    _orgName = snapshotData['OrgName'] as String?;
    _createdOn = snapshotData['createdOn'] as DateTime?;
    _orgMembers = getDataList(snapshotData['OrgMembers']);
    _orgLogo = snapshotData['OrgLogo'] as String?;
    _orgDescription = snapshotData['OrgDescription'] as String?;
    _lastEdited = snapshotData['lastEdited'] as DateTime?;
    _orgAdmin = snapshotData['OrgAdmin'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('organizations');

  static Stream<OrganizationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OrganizationsRecord.fromSnapshot(s));

  static Future<OrganizationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OrganizationsRecord.fromSnapshot(s));

  static OrganizationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      OrganizationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OrganizationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OrganizationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OrganizationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OrganizationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOrganizationsRecordData({
  String? orgName,
  DateTime? createdOn,
  String? orgLogo,
  String? orgDescription,
  DateTime? lastEdited,
  DocumentReference? orgAdmin,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'OrgName': orgName,
      'createdOn': createdOn,
      'OrgLogo': orgLogo,
      'OrgDescription': orgDescription,
      'lastEdited': lastEdited,
      'OrgAdmin': orgAdmin,
    }.withoutNulls,
  );

  return firestoreData;
}

class OrganizationsRecordDocumentEquality
    implements Equality<OrganizationsRecord> {
  const OrganizationsRecordDocumentEquality();

  @override
  bool equals(OrganizationsRecord? e1, OrganizationsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.orgName == e2?.orgName &&
        e1?.createdOn == e2?.createdOn &&
        listEquality.equals(e1?.orgMembers, e2?.orgMembers) &&
        e1?.orgLogo == e2?.orgLogo &&
        e1?.orgDescription == e2?.orgDescription &&
        e1?.lastEdited == e2?.lastEdited &&
        e1?.orgAdmin == e2?.orgAdmin;
  }

  @override
  int hash(OrganizationsRecord? e) => const ListEquality().hash([
        e?.orgName,
        e?.createdOn,
        e?.orgMembers,
        e?.orgLogo,
        e?.orgDescription,
        e?.lastEdited,
        e?.orgAdmin
      ]);

  @override
  bool isValidKey(Object? o) => o is OrganizationsRecord;
}
