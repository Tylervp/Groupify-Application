import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'invitations_page_model.dart';
export 'invitations_page_model.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:groupify_final/sql_files/invitations_DAO_BO/invitations_BO.dart';

class InvitationsPageWidget extends StatefulWidget { // Class to represent the widget and calls its widgetState
  const InvitationsPageWidget({super.key});
  @override
  State<InvitationsPageWidget> createState() => _InvitationsPageWidgetState();
}

class _InvitationsPageWidgetState extends State<InvitationsPageWidget> { // Class to manage the state of the widget
  late InvitationsPageModel _model; // Build instance of its model
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Invitations_BO _invitationsBO = Invitations_BO(); // BO instance to access invitatios queries
  Future<List<Invitation>>? invitationsFuture;

  @override
  void initState() { // Build the widget and model when initialized
    super.initState();
    _model = createModel(context, () => InvitationsPageModel());
    _initializeData(); // Initialize query to get the invitations for the user
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  void _initializeData() async {
    invitationsFuture = _invitationsBO.getUserInvitations(); // Get invitations when widget is initialized
    setState(() {}); // Once projects have been retrieved, trigger a rebuild of the widget
  }

  @override
  void dispose() { // Cleans up widget when not being used
    _model.dispose();
    super.dispose();
  }

  // Costum widget to build container for each invite with corresponding information
  Widget invitationContainer(BuildContext context, String pName, String oID, String uID){
    return  Padding(  
      padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
      child: Container( // Container for the invite
        height: 110.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).overlay,
          borderRadius: BorderRadius.circular(20.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.transparent,
            width: 0.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 5.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container( // Container to hold the profile picture of the inviting user
                width: 65.0,
                height: 65.0,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  valueOrDefault(
                  currentUserPhoto,
                  'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg'
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8.0, 3.0, 0.0, 0.0),
                    child: Text( // Show the ID of the owner of the project
                      oID, // owner ID
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(context).bodyMedium
                          .override(
                            fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                            fontSize: 23.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.4,
                    child: SizedBox(
                      width: 250.0,
                      child: Divider( // Divider between ID and project
                        height: 10.0,
                        thickness: 1.0,
                        indent: 8.0,
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                  ),
                  Padding( // Start of project
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          FFLocalizations.of(
                                  context)
                              .getText(
                            'jzjxgbcf' /* Project:  */,
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                    fontSize: 17.0,
                                    useGoogleFonts: GoogleFonts
                                            .asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                  ),
                        ),
                        Container( // Show the name of the project you are being invited to
                          width: 185.0,
                          decoration: const BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            child: Text(
                              pName, // Project Name
                              overflow: TextOverflow.ellipsis,
                              style: FlutterFlowTheme.of(context).bodyMedium
                                  .override(
                                    fontFamily: 'Urbanist',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),
                                  ),
                            ),
                          ),
                        ),
                      ]
                      .divide(const SizedBox(width: 2.0))
                      .addToStart(const SizedBox(width: 8.0)),
                    ),
                  ),
                  Padding( // Accept button
                    padding: const EdgeInsetsDirectional.fromSTEB(40.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () { // When pressed, join the project and remove the invitation
                              _invitationsBO.acceptInvite(pName, oID);
                              _invitationsBO.removeInvitation(pName, oID);
                              context.pushNamed('HomePage'); // Go back to home page
                            },
                            text: FFLocalizations.of(context).getText('r1lh1cce' /* Accept */,),
                            options: FFButtonOptions(
                              width: 90.0,
                              height: 25.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0,0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle:
                                  FlutterFlowTheme.of(context).titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 15.0,
                                        useGoogleFonts: GoogleFonts
                                                .asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),),
                              elevation: 3.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                          ),
                        ),
                        Align( // Decline button
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () { // When pressed, remove the invitations and go back to home page
                              _invitationsBO.removeInvitation(pName, oID);
                              context.pushNamed('HomePage');
                            },
                            text: FFLocalizations.of(context).getText('28ab5ai4' /* Decline */,),
                            options: FFButtonOptions(
                              width: 90.0,
                              height: 25.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).glass,
                              textStyle:
                                  FlutterFlowTheme.of(context).titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize:15.0,
                                        useGoogleFonts: GoogleFonts
                                                .asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),),
                              elevation: 3.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(60.0),
                            ),
                          ),
                        ),
                      ].divide(const SizedBox(width: 9.0)),
                    ),
                  ),
                ]
                .addToStart(const SizedBox(height: 5.0))
                .addToEnd(const SizedBox(height: 5.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) { // Main widget that displays the page
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold( // Building and aligning of background
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          alignment: const AlignmentDirectional(1.0, 1.0),
          children: [
            Align(
              alignment: const AlignmentDirectional(1.0, -1.4),
              child: Container(
                width: 500.0,
                height: 500.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).tertiary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            if (responsiveVisibility(
              context: context,
              tabletLandscape: false,
              desktop: false,
            ))
              Align(
                alignment: const AlignmentDirectional(-2.0, -1.5),
                child: Container(
                  width: 350.0,
                  height: 350.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (responsiveVisibility(
              context: context,
              tabletLandscape: false,
              desktop: false,
            ))
              Align(
                alignment: const AlignmentDirectional(3.49, -1.05),
                child: Container(
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            Align(
              alignment: const AlignmentDirectional(0.0, 1.4),
              child: Container(
                width: 500.0,
                height: 500.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).tertiary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            if (responsiveVisibility(
              context: context,
              tabletLandscape: false,
              desktop: false,
            ))
              Align(
                alignment: const AlignmentDirectional(7.98, 0.81),
                child: Container(
                  width: 350.0,
                  height: 350.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (responsiveVisibility(
              context: context,
              tabletLandscape: false,
              desktop: false,
            ))
              Align(
                alignment: const AlignmentDirectional(-3.41, 0.58),
                child: Container(
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 40.0,
                  sigmaY: 40.0,
                ),
                child: Container( // Build app bar
                  width: 558.0,
                  height: 1037.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).overlay,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 399.0,
                          height: 129.0,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          alignment: const AlignmentDirectional(0.0, 1.0),
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, 1.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 13.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding( // Title of the app bar
                                    padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        '4sz614g6' /* Invitations */,
                                      ),
                                      style: FlutterFlowTheme.of(context).displayMedium
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context).displayMediumFamily,
                                            fontSize: 40.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(FlutterFlowTheme.of(context).displayMediumFamily),
                                          ),
                                    ),
                                  ),
                                  Padding( // Exit icon
                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async { // When pressed go back to the homepage
                                              context.pushNamed('HomePage');
                                            },
                                            child: Icon(
                                              Icons.close_rounded,
                                              color: FlutterFlowTheme.of(context).primaryText,
                                              size: 35.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 694.0,
                            decoration: const BoxDecoration(),
                            child: FutureBuilder(
                              future: invitationsFuture, // Query for the list of final memebrs
                              builder: (BuildContext context, AsyncSnapshot snapshot){
                                if(snapshot.data == null){ // If null, show loading indicator
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color.fromARGB(100, 57, 210, 192),
                                      backgroundColor: Color.fromARGB(30, 57, 210, 192),
                                      strokeWidth: 4,
                                    )
                                  );
                                }
                                else { // Make a list of all the invitiations for a user
                                  return ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0,),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    //----- Iterate through list of invitations returned by _getUserInvitations and build contaier for each ----
                                    itemCount: snapshot.data.length,
                                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: 15),
                                    itemBuilder: (BuildContext context, int index) { // Call costum widget for each invitation
                                      return invitationContainer(context, snapshot.data[index].projectName,
                                              snapshot.data[index].ownerID, snapshot.data[index].userID);
                                    },
                                  );
                                }
                              }
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}