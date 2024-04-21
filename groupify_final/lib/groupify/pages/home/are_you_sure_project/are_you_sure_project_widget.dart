import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'are_you_sure_project_model.dart';
export 'are_you_sure_project_model.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:groupify_final/sql_files/projects_DAO_BO/projects_BO.dart';

class AreYouSureProjectWidget extends StatefulWidget { // Class to represent the widget and calls its widgetState
// Values passed in to 'are you sure' project bottomsheet
  final String? pOwnerId;
  final String? pName;
  final String? pDescription;
  final String? pDue; 
  const AreYouSureProjectWidget({super.key, this.pOwnerId, this.pName, this.pDescription, this.pDue});

  @override
  State<AreYouSureProjectWidget> createState() =>
      _AreYouSureProjectWidgetState();
}

class _AreYouSureProjectWidgetState extends State<AreYouSureProjectWidget> { // Class to manage the state of the widget
  late AreYouSureProjectModel _model; // Build instance of its model
  final Projects_BO _projectsBO = Projects_BO(); // Project BO to gain access to project db and queries

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() { // Build the widget and model when initialized
    super.initState();
    _model = createModel(context, () => AreYouSureProjectModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {  // Cleans up widget when not being used
    _model.maybeDispose();
    super.dispose();
  }

  // Widget that shows different text when current user is the owner of the project and perform delete project queries 
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
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 20.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
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
              onPressed: () async { // When yes is pressed, peform query to complete remove project and its info 
                await _projectsBO.removeProject(widget.pOwnerId, widget.pName);
                context.pushNamed('HomePage'); // Go back to home page
              },
              text: FFLocalizations.of(context).getText('aqswhyc8' /* Yes */,),
              options: FFButtonOptions(
                height: 40.0,
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: const Color(0xB2F90101),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: Colors.white,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
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
              onPressed: () async { // If no is pressed, go back to the options bottomsheet
                context.safePop(); 
              },
              text: FFLocalizations.of(context).getText(
                'wl40gcpc' /* No */,
              ),
              options: FFButtonOptions(
                height: 40.0,
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).secondaryText,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: Colors.white,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
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

  // Widget that shows different text when current user is not the owner of the project and perform leaving project queries
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
              child: Text( // Show the text that asks the user if they would want to leave the project rather than delete
                'Are you sure you wish to leave this project?',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                      fontSize: 20.0,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
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
              onPressed: () async { // If yes, perform the queries that will unassign tasks/subtasks theuser is in leave proj.
                await _projectsBO.leaveProject(widget.pOwnerId, widget.pName); 
                context.pushNamed('HomePage'); // Go back to homepage
              },
              text: FFLocalizations.of(context).getText('aqswhyc8' /* Yes */,),
              options: FFButtonOptions(
                height: 40.0,
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: const Color(0xB2F90101),
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily:FlutterFlowTheme.of(context).titleSmallFamily,
                      color: Colors.white,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
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
              onPressed: () async { // If no, go back to options bottomsheet
                context.safePop();
              },
              text: FFLocalizations.of(context).getText('wl40gcpc' /* No */,),
              options: FFButtonOptions(
                height: 40.0,
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).secondaryText,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                      color: Colors.white,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
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
  Widget build(BuildContext context) { // Main widget that displays the page
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
            children : [  /// Determing if the current user is the owner of the project
              if(widget.pOwnerId == currentUserDisplayName) // If owner, call the widget for the owner
                isOwner(context)
              else  // If not the owner, call the member widget
                notOwner(context)
            ],
          ),
        ),
      ),
    );
  }
}
