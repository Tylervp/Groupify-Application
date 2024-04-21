import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'rating_page_model.dart';
export 'rating_page_model.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:groupify_final/sql_files/projects_DAO_BO/projects_BO.dart';
import 'package:groupify_final/sql_files/members_DAO_BO/members_BO.dart';

class RatingPageWidget extends StatefulWidget { // Class to represent the widget and calls its widgetState
  // Values that are sent in to rating page (info about which project we are in).
  final String projectOwnerID;
  final String projectName;
  final String projectDescription;
  const RatingPageWidget({super.key, required this.projectOwnerID,required this.projectName, required this.projectDescription});

  @override
  State<RatingPageWidget> createState() => _RatingPageWidgetState();
}

class _RatingPageWidgetState extends State<RatingPageWidget> { // Class to manage the state of the widget
  late RatingPageModel _model; // Build instance of its model
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  Map<String, double> memberRatings = {}; // Map that will hold the ratings of each user
  final Projects_BO _projectsBO = Projects_BO(); // BO instances to gain access to project and members queries 
  final Members_BO _membersBO = Members_BO();
  Future<List<Member>>? finalMembersFuture; // variable to hold the value of initial finalMember query

  @override
  void initState() { // Build the widget and model when initialized
    super.initState();
    _model = createModel(context, () => RatingPageModel());
    _initializeData(); // Initialize finalMember query
  }

  // Perform query to get finalMembers in a project whe initialized
  void _initializeData() async {
    finalMembersFuture = _membersBO.getFinalMembers(widget.projectOwnerID, widget.projectName);
    setState(() {}); // Trigger rebuild once data is being fetched 
  }

  @override
  void dispose() { // Cleans up widget when not being used
    _model.dispose();
    super.dispose();
  }

  // Remove current user from project once you submit the survey
  Future<void>_leaveProject(String pName, String pOwnerID) async{
    final results = await _membersBO.getMembers(pOwnerID, pName); // Get the members still left in projects
    if(results.length == 1){ // last member in project so need to delete the whole project
      await _projectsBO.removeProject(pOwnerID, pName);
    }
    else{ // just leave the project becasue there is still members in it and remove from assigned tasks/subtasks
      await _projectsBO.leaveProject(pOwnerID, pName);
    }
  }

  // Widget to build a container for each member
  Widget memberContainer(BuildContext context, String username){
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          height: 90.0,
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
                Container( // show profile picture of the member
                  width: 65.0,
                  height: 65.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    valueOrDefault(
                      currentUserPhoto, 
                      'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
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
                      child: Text( 
                        username, // show the username of the member
                        overflow: TextOverflow.ellipsis,
                        style:
                            FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                                          FlutterFlowTheme.of(context).bodyMediumFamily),
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
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(7.0, 0.0, 0.0, 0.0),
                          child: Text(
                            FFLocalizations.of(context).getText('8vssdylo' /* Rating:  */,),
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ),
                        RatingBar.builder(
                          onRatingUpdate: (newValue) {
                            memberRatings[username] = newValue; // Add ratings for the user to the Map 
                          },
                          itemBuilder: (context, index) => Icon(Icons.star_rounded, color: FlutterFlowTheme.of(context).tertiary,),
                          direction: Axis.horizontal,
                          initialRating:  memberRatings[username] ??= 3.0, 
                          unratedColor: FlutterFlowTheme.of(context).accent3,
                          itemCount: 5,
                          itemSize: 34.0,
                          minRating: 1.0,
                          glowColor: FlutterFlowTheme.of(context).tertiary,
                        ),
                      ].divide(const SizedBox(width: 9.0)),
                    ),
                  ]
                  .addToStart(const SizedBox(height: 5.0))
                  .addToEnd(const SizedBox(height: 5.0)),
                ),
              ],
            ),
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack( // Building and aligning of background of the page
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
                child: Container( // App bar
                  width: 558.0,
                  height: 1037.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).overlay,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
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
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                        child: Text( // show app bar title
                                          FFLocalizations.of(context).getText(
                                            '37qjb5e9' /* Rate Members */,
                                          ),
                                          style: FlutterFlowTheme.of(context).displayMedium
                                              .override(
                                                fontFamily: FlutterFlowTheme.of(context).displayMediumFamily,
                                                fontSize: 40.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(FlutterFlowTheme.of(context).displayMediumFamily),
                                              ),
                                        ),
                                      ),
                                      Padding( // exit button 
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
                                                highlightColor:Colors.transparent,
                                                onTap: () async { // when exit is pressed, go back to projectPage
                                                    context.pushNamed('ProjectPage', queryParameters: {
                                                      'projectOwnerID': widget.projectOwnerID,
                                                      'projectName': widget.projectName,
                                                      'projectDescription': widget.projectDescription,
                                                      });
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
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width: 368.0,
                                          height: 122,
                                          decoration: const BoxDecoration(),
                                          alignment: const AlignmentDirectional(0.0, -1.0),
                                          child: Text( // show text stating the project has been complete
                                            'The project has been complete! Please rate your fellow group members based on their performance. Once you click confirm, you will be taken out of the project.',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                  fontSize: 20.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 530.0,
                              decoration: const BoxDecoration(),
                              child: FutureBuilder(
                                future: finalMembersFuture, // query for list of final members
                                builder: (BuildContext context, AsyncSnapshot snapshot){
                                  if(snapshot.connectionState == ConnectionState.waiting){ // if the list is null, show loading progress
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: Color.fromARGB(100, 57, 210, 192),
                                        backgroundColor: Color.fromARGB(30, 57, 210, 192),
                                        strokeWidth: 4,
                                      ),
                                    );
                                  }
                                  else if (snapshot.hasError) { // if there is an error, show error message
                                    return Center(
                                        child: Text('Error: ${snapshot.error.toString()}'),
                                    );
                                  }
                                  else { // List wasnt null 
                                    if(snapshot.data.length == 1){ // If you are the only member in the list
                                      return const Center(
                                        child: Text('You are the only member in this project.')
                                      );
                                    }
                                    else { // more than one member in the list
                                      return ListView.separated( // make a list for every final members in the project
                                        padding: const EdgeInsets.fromLTRB(0, 20.0, 0,0,),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data.length,
                                        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15.0),
                                        itemBuilder: (BuildContext context, int index){
                                          if(currentUserDisplayName == snapshot.data[index].username){ // skip current user so you cant rate yourself
                                            return const SizedBox();
                                          }
                                          else { // call memberContainer widget to build a contaier for every member in list
                                            return memberContainer(context, snapshot.data[index].username); 
                                          }
                                        }
                                      );
                                    }
                                  }     
                                }
                              ),
                            )
                          ],
                        ),
                        Align( // Confirm button 
                          alignment: const AlignmentDirectional(0.0, 0.28),
                          child: FFButtonWidget(
                            onPressed: () async { // when pressed, insert ratings in rating table and go back to home page. Also leave the project
                              await _leaveProject(widget.projectName, widget.projectOwnerID);
                              context.pushNamed('HomePage');
                              _membersBO.addRatings(memberRatings);
                            },
                            text: FFLocalizations.of(context).getText('lykhybrz' /* Confirm */,),
                            options: FFButtonOptions(
                              width: 130.0,
                              height: 50.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context).titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                    color: Colors.white,
                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                  ),
                              elevation: 3.0,
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(60.0),
                            ),
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
