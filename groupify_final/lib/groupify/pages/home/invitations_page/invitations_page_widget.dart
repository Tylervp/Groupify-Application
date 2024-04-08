import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'invitations_page_model.dart';
export 'invitations_page_model.dart';
import 'package:groupify_final/sql_database_connection.dart';
import '/auth/firebase_auth/auth_util.dart';


class Invitation {
  String projectName = '';
  String ownerID = '';
  String userID = '';


  Invitation(String projectName, String ownerID, String userID){
    this.projectName = projectName;
    this.ownerID = ownerID;
    this.userID = userID;
  }
}


class InvitationsPageWidget extends StatefulWidget {
  const InvitationsPageWidget({super.key});


  @override
  State<InvitationsPageWidget> createState() => _InvitationsPageWidgetState();
}


class _InvitationsPageWidgetState extends State<InvitationsPageWidget> {
  late InvitationsPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InvitationsPageModel());
    _sqldatabaseHelper = SQLDatabaseHelper();
    _connectToDatabase();


    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }


  @override
  void dispose() {
    _model.dispose();


    super.dispose();
  }


  late SQLDatabaseHelper _sqldatabaseHelper;
  Future<void> _connectToDatabase() async {
    await _sqldatabaseHelper.connectToDatabase();
  }


  Future<List<Invitation>> _getInvitations(BuildContext context) async {
    List<Invitation> invitations = [];
    final results = await _sqldatabaseHelper.connection.query('SELECT * FROM Inbox WHERE userID = ?', [currentUserDisplayName]);
    print('GOT THE INVITATIONS FOR THE CURRENT USER');
    for(final row in results){
      String tempName = row['projectName'] as String;
      String tempOwnerID = row['ownerID'] as String;
      String tempUserID = row['userID'] as String;
      invitations.insert(0, Invitation(tempName, tempOwnerID, tempUserID));
    }
    return invitations;
  }


  Future<void> _insertProjectMembers(BuildContext context, String pName, String oID) async {
    await _sqldatabaseHelper.connection.query('INSERT ProjectMembers (userID, projectName, ownerID) VALUES (?,?,?)',
                                  [currentUserDisplayName, pName, oID]);
    print('CURRENT USER JOINED THE PROJECT');
  }


  Future<void> _deleteInvitation(BuildContext context, String pName, String oID) async {
    await _sqldatabaseHelper.connection.query('DELETE FROM Inbox WHERE userID = ? and projectName = ? and ownerID = ?',
                                  [currentUserDisplayName, pName, oID]);
    print('INVITATION WAS REMOVED');
    setState(() {});
    _sqldatabaseHelper.closeConnection();
  }


  Widget invitationContainer(BuildContext context, String pName, String oID, String uID){
    return  Padding(  
      padding: const EdgeInsetsDirectional.fromSTEB(
          15.0, 0.0, 15.0, 0.0),
      child: Container(
        height: 110.0,
        decoration: BoxDecoration(
          color:
              FlutterFlowTheme.of(context).overlay,
          borderRadius: BorderRadius.circular(20.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.transparent,
            width: 0.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              10.0, 0.0, 0.0, 5.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 65.0,
                height: 65.0,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://picsum.photos/seed/513/600',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional
                        .fromSTEB(
                            8.0, 3.0, 0.0, 0.0),
                    child: Text(
                      oID,
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(
                              context)
                          .bodyMedium
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(
                                        context)
                                    .bodyMediumFamily,
                            fontSize: 23.0,
                            fontWeight:
                                FontWeight.w600,
                            useGoogleFonts: GoogleFonts
                                    .asMap()
                                .containsKey(
                                    FlutterFlowTheme.of(
                                            context)
                                        .bodyMediumFamily),
                          ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.4,
                    child: SizedBox(
                      width: 250.0,
                      child: Divider(
                        height: 10.0,
                        thickness: 1.0,
                        indent: 8.0,
                        color: FlutterFlowTheme.of(
                                context)
                            .primaryText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional
                        .fromSTEB(
                            0.0, 0.0, 0.0, 8.0),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.max,
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      children: [
                        Text(
                          FFLocalizations.of(
                                  context)
                              .getText(
                            'jzjxgbcf' /* Project:  */,
                          ),
                          style:
                              FlutterFlowTheme.of(
                                      context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(
                                            context)
                                        .bodyMediumFamily,
                                    fontSize: 17.0,
                                    useGoogleFonts: GoogleFonts
                                            .asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                        ),
                        Container(
                          width: 185.0,
                          decoration:
                              const BoxDecoration(),
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional
                                    .fromSTEB(
                                        0.0,
                                        0.0,
                                        0.0,
                                        0.0),
                            child: Text(
                              pName,  /////////////////////////////
                              overflow: TextOverflow.ellipsis,  ////////////////////////////
                              style: FlutterFlowTheme
                                      .of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily:
                                        'Urbanist',
                                    fontSize:
                                        17.0,
                                    fontWeight:
                                        FontWeight
                                            .normal,
                                    useGoogleFonts: GoogleFonts
                                            .asMap()
                                        .containsKey(
                                            'Urbanist'),
                                  ),
                            ),
                          ),
                        ),
                      ]
                      .divide(const SizedBox(width: 2.0))
                      .addToStart(const SizedBox(width: 8.0)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional
                        .fromSTEB(
                            40.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.max,
                      children: [
                        Align(
                          alignment:
                              const AlignmentDirectional(
                                  0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () {
                              _insertProjectMembers(context, pName, oID);
                              _deleteInvitation(context, pName, oID);
                              context.pushNamed('HomePage');
                            },
                            text:
                                FFLocalizations.of(
                                        context)
                                    .getText(
                              'r1lh1cce' /* Accept */,
                            ),
                            options:
                                FFButtonOptions(
                              width: 90.0,
                              height: 25.0,
                              padding:
                                  const EdgeInsetsDirectional
                                      .fromSTEB(
                                          0.0,
                                          0.0,
                                          0.0,
                                          0.0),
                              iconPadding:
                                  const EdgeInsetsDirectional
                                      .fromSTEB(
                                          0.0,
                                          0.0,
                                          0.0,
                                          0.0),
                              color: FlutterFlowTheme
                                      .of(context)
                                  .primary,
                              textStyle:
                                  FlutterFlowTheme.of(
                                          context)
                                      .titleSmall
                                      .override(
                                        fontFamily:
                                            FlutterFlowTheme.of(context)
                                                .titleSmallFamily,
                                        color: FlutterFlowTheme.of(
                                                context)
                                            .primaryText,
                                        fontSize:
                                            15.0,
                                        useGoogleFonts: GoogleFonts
                                                .asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context).titleSmallFamily),
                                      ),
                              elevation: 3.0,
                              borderSide:
                                  const BorderSide(
                                color: Colors
                                    .transparent,
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          60.0),
                            ),
                          ),
                        ),
                        Align(
                          alignment:
                              const AlignmentDirectional(
                                  0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () {
                              _deleteInvitation(context, pName, oID);
                              context.pushNamed('HomePage');
                            },
                            text:
                                FFLocalizations.of(
                                        context)
                                    .getText(
                              '28ab5ai4' /* Decline */,
                            ),
                            options:
                                FFButtonOptions(
                              width: 90.0,
                              height: 25.0,
                              padding:
                                  const EdgeInsetsDirectional
                                      .fromSTEB(
                                          0.0,
                                          0.0,
                                          0.0,
                                          0.0),
                              iconPadding:
                                  const EdgeInsetsDirectional
                                      .fromSTEB(
                                          0.0,
                                          0.0,
                                          0.0,
                                          0.0),
                              color: FlutterFlowTheme
                                      .of(context)
                                  .glass,
                              textStyle:
                                  FlutterFlowTheme.of(
                                          context)
                                      .titleSmall
                                      .override(
                                        fontFamily:
                                            FlutterFlowTheme.of(context)
                                                .titleSmallFamily,
                                        color: FlutterFlowTheme.of(
                                                context)
                                            .primaryText,
                                        fontSize:
                                            15.0,
                                        useGoogleFonts: GoogleFonts
                                                .asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context).titleSmallFamily),
                                      ),
                              elevation: 3.0,
                              borderSide:
                                  const BorderSide(
                                color: Colors
                                    .transparent,
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          60.0),
                            ),
                          ),
                        ),
                      ].divide(
                          const SizedBox(width: 9.0)),
                    ),
                  ),
                ]
                    .addToStart(
                        const SizedBox(height: 5.0))
                    .addToEnd(
                        const SizedBox(height: 5.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                child: Container(
                  width: 558.0,
                  height: 1037.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).overlay,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 13.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        '4sz614g6' /* Invitations */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .displayMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .displayMediumFamily,
                                            fontSize: 40.0,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .displayMediumFamily),
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 15.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 5.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed('HomePage');
                                            },
                                            child: Icon(
                                              Icons.close_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
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
                              future: _getInvitations(context),
                              builder: (BuildContext context, AsyncSnapshot snapshot){
                                if(snapshot.data == null){
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color.fromARGB(100, 57, 210, 192),
                                      backgroundColor: Color.fromARGB(30, 57, 210, 192),
                                      strokeWidth: 4,
                                    )
                                  );
                                }
                                else {
                                  return ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      5.0,
                                      0,
                                      0,
                                    ),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    //-----ITERATE THROUGH PROJECT LIST----
                                    itemCount: snapshot.data.length,
                                    separatorBuilder: (BuildContext context, int index) => SizedBox(height: 15),
                                    itemBuilder: (BuildContext context, int index) {
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



