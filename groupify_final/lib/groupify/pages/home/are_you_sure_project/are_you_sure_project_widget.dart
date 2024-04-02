import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'are_you_sure_project_model.dart';
export 'are_you_sure_project_model.dart';
import 'package:groupify_final/sql_database_connection.dart';
import '/auth/firebase_auth/auth_util.dart';

class AreYouSureProjectWidget extends StatefulWidget {
  final String? pOwnerId;
  final String? pName;
  final String? pDescription;
  final String? pDue; 
  const AreYouSureProjectWidget({super.key, this.pOwnerId, this.pName, this.pDescription, this.pDue});

  @override
  State<AreYouSureProjectWidget> createState() =>
      _AreYouSureProjectWidgetState();
}

class _AreYouSureProjectWidgetState extends State<AreYouSureProjectWidget> {
  late AreYouSureProjectModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  // Connect to DB
  late SQLDatabaseHelper _sqldatabaseHelper;
  Future<void> _connectToDatabase() async {
    await _sqldatabaseHelper.connectToDatabase();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AreYouSureProjectModel());
    _sqldatabaseHelper = SQLDatabaseHelper();
    _connectToDatabase();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  Future<void> _deleteProjectMembers(String? pOwnerID, String? pName, String? pDescription, String? pDue) async {
    await _sqldatabaseHelper.connection.query( 
      'DELETE FROM projectMembers WHERE projectName = ? and ownerID = ?;', [pName, currentUserDisplayName]);
  }

  Future<void> _deleteProject(String? pOwnerID, String? pName, String? pDescription, String? pDue) async {
   await _sqldatabaseHelper.connection.query( 
      'DELETE FROM TaskComments WHERE projectName = ? and ownerID = ?;', [pName, currentUserDisplayName]);

    await _sqldatabaseHelper.connection.query( 
      'DELETE FROM SubTaskComments WHERE projectName = ? and ownerID = ?;', [pName, currentUserDisplayName]);

    await _sqldatabaseHelper.connection.query( 
      'DELETE FROM Tasks WHERE projectName = ? and ownerID = ?;', [pName, currentUserDisplayName]);

     await _sqldatabaseHelper.connection.query( 
      'DELETE FROM Subtasks WHERE projectName = ? and ownerID = ?;', [pName, currentUserDisplayName]);

    await _sqldatabaseHelper.connection.query( 
      'DELETE FROM projects WHERE projectName = ? and ownerId = ?;', [pName, currentUserDisplayName]);

    _sqldatabaseHelper.closeConnection();
  }

  Future<void> _leaveProjectMembers(String? pOwnerID, String? pName, String? pDescription, String? pDue) async {  
    await _sqldatabaseHelper.connection.query( 
      'DELETE FROM projectMembers WHERE userID = ? and projectName = ? and ownerID = ?;', 
      [currentUserDisplayName, pName, pOwnerID]);
  }

  Future<void> _unassign(String? pOwnerID, String? pName, String? pDescription, String? pDue) async {  
    print(pOwnerID.toString() + '------------------------------------================');

    await _sqldatabaseHelper.connection.query( 
      'UPDATE Tasks SET taskAssigned = ? WHERE projectName = ? and ownerID = ? and taskAssigned = ?;', 
      ['', pName, pOwnerID, currentUserDisplayName]);

    await _sqldatabaseHelper.connection.query( 
      'UPDATE Subtasks SET taskAssigned = ? WHERE projectName = ? and ownerID = ?;', 
      ['', pName, pOwnerID]);

    _sqldatabaseHelper.closeConnection();
  }

  Widget isOwner(BuildContext context){
    return Column(
      children: [
        Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
            child: Container(
              width: 368.0,
              height: 77.0,
              decoration: const BoxDecoration(),
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'nktukkcp' /* Are you sure you wish to delet... */,
                ),
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 20.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).bodyMediumFamily),
                    ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FFButtonWidget(
              onPressed: () async {
                _deleteProjectMembers(widget.pOwnerId, widget.pName, widget.pDescription, widget.pDue);
                context.pushNamed('HomePage');
                _deleteProject(widget.pOwnerId, widget.pName, widget.pDescription, widget.pDue);
              },
              text: FFLocalizations.of(context).getText(
                'aqswhyc8' /* Yes */,
              ),
              options: FFButtonOptions(
                height: 40.0,
                padding:
                    const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: const Color(0xB2F90101),
                textStyle: FlutterFlowTheme.of(context)
                    .titleSmall
                    .override(
                      fontFamily:
                          FlutterFlowTheme.of(context).titleSmallFamily,
                      color: Colors.white,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleSmallFamily),
                    ),
                elevation: 3.0,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                context.safePop();
              },
              text: FFLocalizations.of(context).getText(
                'wl40gcpc' /* No */,
              ),
              options: FFButtonOptions(
                height: 40.0,
                padding:
                    const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).secondaryText,
                textStyle: FlutterFlowTheme.of(context)
                    .titleSmall
                    .override(
                      fontFamily:
                          FlutterFlowTheme.of(context).titleSmallFamily,
                      color: Colors.white,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleSmallFamily),
                    ),
                elevation: 3.0,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget notOwner(BuildContext context){
    return Column(
      children: [
        Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
            child: Container(
              width: 368.0,
              height: 77.0,
              decoration: const BoxDecoration(),
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Text(
                'Are you sure you wish to leave this project?',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily:
                          FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 20.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).bodyMediumFamily),
                    ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FFButtonWidget(
              onPressed: () async {
                _leaveProjectMembers(widget.pOwnerId, widget.pName, widget.pDescription, widget.pDue);
                context.pushNamed('HomePage');
                _unassign(widget.pOwnerId, widget.pName, widget.pDescription, widget.pDue);
              },
              text: FFLocalizations.of(context).getText(
                'aqswhyc8' /* Yes */,
              ),
              options: FFButtonOptions(
                height: 40.0,
                padding:
                    const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: const Color(0xB2F90101),
                textStyle: FlutterFlowTheme.of(context)
                    .titleSmall
                    .override(
                      fontFamily:
                          FlutterFlowTheme.of(context).titleSmallFamily,
                      color: Colors.white,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleSmallFamily),
                    ),
                elevation: 3.0,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                context.safePop();
              },
              text: FFLocalizations.of(context).getText(
                'wl40gcpc' /* No */,
              ),
              options: FFButtonOptions(
                height: 40.0,
                padding:
                    const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).secondaryText,
                textStyle: FlutterFlowTheme.of(context)
                    .titleSmall
                    .override(
                      fontFamily:
                          FlutterFlowTheme.of(context).titleSmallFamily,
                      color: Colors.white,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleSmallFamily),
                    ),
                elevation: 3.0,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ],
        ),
      ],
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 300.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(0.0, 2.0),
            )
          ],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children : [
              if(widget.pOwnerId == currentUserDisplayName)
                isOwner(context)
              else 
                notOwner(context)
            ],
          ),
        ),
      ),
    );
  }
}
