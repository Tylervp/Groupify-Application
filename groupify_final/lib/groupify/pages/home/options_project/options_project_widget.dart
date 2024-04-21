import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/groupify/pages/home/are_you_sure_project/are_you_sure_project_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'options_project_model.dart';
export 'options_project_model.dart';
import '/auth/firebase_auth/auth_util.dart';

class OptionsProjectWidget extends StatefulWidget { // Class to represent the widget and calls its widgetState
  // values passed in to options widget to know which project we are in
  final String? pOwnerId;
  final String? pName;
  final String? pDescription;
  final String? pDue; 
  const OptionsProjectWidget({super.key, this.pOwnerId, this.pName, this.pDescription, this.pDue});

  @override
  State<OptionsProjectWidget> createState() => _OptionsProjectWidgetState();
}

class _OptionsProjectWidgetState extends State<OptionsProjectWidget> { // Class to manage the state of the widget
  late OptionsProjectModel _model; // Build instance of its model

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() { // Build the widget and model when initialized
    super.initState();
    _model = createModel(context, () => OptionsProjectModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() { // Cleans up widget when not being used
    _model.maybeDispose();
    super.dispose();
  }

  // Show the option of being able to edit or delete a project if current user is the owner of the project
  Widget isOwner(BuildContext context){
    return Column(
      children: [
        Row( // Show title of options widget
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 0.0, 8.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'tymhcmg1' /* Project Options */,
                ),
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts: GoogleFonts.asMap().containsKey('Outfit'),
                    ),
              ),
            ),
            Padding( // Exit icon to go back to home page
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.safePop();
                },
                child: Icon(
                  Icons.close_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
            ),
          ],
        ),
        InkWell( // Edit projects row
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async { // When pressed, go to edit projects and pass the data of the project you are in  
            context.pushNamed('EdtiProjectPage', queryParameters: {
              'pName' : widget.pName,
              'pDescription' : widget.pDescription,
              'pDue' : widget.pDue,
            });
          },
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                    child: Icon(
                      Icons.edit,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 20.0,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                      child: Text( // Show text of edit projects row
                        FFLocalizations.of(context).getText(
                          '4ijjngxt' /* Edit project information */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium
                            .override(
                              fontFamily: 'Urbanist',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Divider( // Show divider between edit projects and delete projects
          thickness: 1.0,
          color: Color(0xFFE0E3E7),
        ),
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async { // If delete projects is pressed, show are you sure bottomsheet 
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              enableDrag: false,
              context: context,
              builder: (context) {
                return Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: SizedBox(
                    height: 180.0,
                    child: AreYouSureProjectWidget( // Pass in the values of the project we are in to the are you sure bottomsheet
                      pOwnerId: widget.pOwnerId,
                      pName: widget.pName, 
                      pDescription: widget.pDescription,
                      pDue: widget.pDue,
                    ),
                  ),
                );
              },
            ).then((value) => safeSetState(() {}));
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                    child: Icon(
                      Icons.delete,
                      color: Color(0xB2F90101),
                      size: 20.0,
                    ),
                  ),
                  Expanded( // Show text for delete project
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'u5m4q2s5' /* Delete project */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium
                            .override(
                              fontFamily: 'Urbanist',
                              color: const Color(0xB2F90101),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }

  // Show the option of only being able to leave a project if the current user is not the owner of the project
  Widget notOwner(BuildContext context){
    return Column(
      children: [
        Row( // Show title of bottomsheet
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 0.0, 8.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'tymhcmg1' /* Project Options */,
                ),
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).labelMedium.override(
                      fontFamily: 'Outfit',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts:
                          GoogleFonts.asMap().containsKey('Outfit'),
                    ),
              ),
            ),
            Padding( // Exit button
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async { // When  pressed go back to previous page
                  context.safePop();
                },
                child: Icon(
                  Icons.close_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
            ),
          ],
        ),
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async { // If press on 'leave project', show 'are you sure' bottom sheet
            await showModalBottomSheet( 
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              enableDrag: false,
              context: context,
              builder: (context) {
                return Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: SizedBox(
                    height: 180.0,
                    child: AreYouSureProjectWidget( // Pass in the values of the project to 'are you sure' widget when pressed
                      pOwnerId: widget.pOwnerId,
                      pName: widget.pName, 
                      pDescription: widget.pDescription,
                      pDue: widget.pDue,
                    ),
                  ),
                );
              },
            ).then((value) => safeSetState(() {}));
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                    child: Icon(
                      Icons.group_remove_rounded,
                      color: Color(0xB2F90101),
                      size: 20.0,
                    ),
                  ),
                  Expanded(
                    child: Padding( // Show title of the leave project row
                      padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                      child: Text( 
                        'Leave Project',
                        style: FlutterFlowTheme.of(context).bodyMedium
                            .override(
                              fontFamily: 'Urbanist',
                              color: const Color(0xB2F90101),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding( // Building of bottom sheet
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ // Check if the user is the owner of the project
              if(widget.pOwnerId == currentUserDisplayName) // If owner, call widget that show editing and deleting options 
                isOwner(context)
              else // If not an owner, call the widget that only shows the options to leave the project
                notOwner(context)
            ]
          ),
        ),
      ),
    );
  }
}
