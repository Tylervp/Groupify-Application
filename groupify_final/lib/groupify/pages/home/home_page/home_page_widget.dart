import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/groupify/pages/home/options_project/options_project_widget.dart';
import 'dart:ui';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:groupify_final/sql_files/projects_DAO_BO/projects_BO.dart';
import 'package:groupify_final/sql_files/invitations_DAO_BO/invitations_BO.dart';
import 'package:groupify_final/sql_files/members_DAO_BO/members_BO.dart';

class HomePageWidget extends StatefulWidget { // Class to represent the widget and calls its widgetState
  const HomePageWidget({super.key});
  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> { // Class to manage the state of the widget
  late HomePageModel _model; // build instance of its model
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Creating instances of BO's in order to get access to DAO's to have access to database
  final Projects_BO _projectsBO = Projects_BO();
  final Invitations_BO _invitationsBO = Invitations_BO();
  final Members_BO _membersBO = Members_BO();
  // Variables to hold initial queries when initialized
  Future<List<Project>>? projectsFuture;
  Future<String>? invitationsFuture;

  @override
  void initState() { // Build the widget and model when initialized
    super.initState();
    _model = createModel(context, () => HomePageModel());
    _initializeFetchProjects(); // Call first set of queries as soon as main widget is built
  }

  // Initialize data and reset the build once it has been obtained
  void _initializeFetchProjects() async {
    projectsFuture = _projectsBO.getUserProjects(); // Get projects when widget is initialized
    invitationsFuture = _invitationsBO.getNumInvitations(); // Get number of invitations for current user
    setState(() {}); // Once projects have been retrieved, trigger a rebuild of the widget
  }

  @override
  void dispose() { // Cleans up widget and model when not being used
    _model.dispose();
    super.dispose();
  }

  // Widget to create project container
  Widget projectContainer(BuildContext context, String pName, String pOwnerID, String pDescription, String pDue, Color c, double pProgress, List<Member> pMembers){
    String temp = pProgress.toStringAsFixed(4);
    pProgress = double.parse(temp); // round progress to 4 places after the decimal (ex. .7333000)
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          if(pProgress < 1.0){  //If project is not done (progress bar not at 100%), the go to ProjectPage
            context.pushNamed('ProjectPage', queryParameters: {
            'projectOwnerID': pOwnerID,
            'projectName': pName,
            'projectDescription': pDescription,
            });
          }
          else{  // project is done, add all members as final members and go to rating page
             await _membersBO.addFinalMembers(pName, pOwnerID);
            context.pushNamed('RatingPage', queryParameters: {
            'projectOwnerID': pOwnerID,
            'projectName': pName,
            'projectDescription': pDescription,
            });
          }
        },
        child: Container( // Container of the project
          height: 100.0,
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
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(25.0, 6.0, 19.0, 0.0),
                  child: Row( // first row of the project container
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: c,  // color for the project
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container( // container that will hold the project name
                        width: 161.0,
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(5.0, 3.0, 0.0, 0.0),
                          child: Text(
                            pName, // project name
                            overflow: TextOverflow.ellipsis,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily:'Urbanist',
                                  fontSize: 23.0,
                                  fontWeight:FontWeight.w600,
                                  useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(4.0, 0.0,0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0,0.0),
                              child: Text(FFLocalizations.of(context).getText('uyrtxe9w' /* Due: */,),
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Urbanist',
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),
                                    ),
                              ),
                            ),
                            Container( // container to hold the due date of a project
                              width: 92.0,
                              decoration: const BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(3.0, 3.0, 0.0, 0.0),
                                child: Text( // display project due date
                                  pDue,
                                  overflow: TextOverflow.ellipsis,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Urbanist',
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        splashColor:Colors.transparent,
                        focusColor:Colors.transparent,
                        hoverColor:Colors.transparent,
                        highlightColor:Colors.transparent,
                        onTap: () async { // more options icon that will allow for leaving, deleting, or edititng of proj.
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor:Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () => _model
                                        .unfocusNode
                                        .canRequestFocus
                                    ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                    : FocusScope.of(context).unfocus(),
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: SizedBox(
                                    height: 200.0,
                                    child: OptionsProjectWidget(
                                          pOwnerId: pOwnerID,
                                          pName: pName,
                                          pDescription: pDescription,
                                          pDue: pDue),  
                                  ),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                        child: Icon( // more options icon
                          Icons.more_vert,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 23.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(  // second row of project container
                  alignment: const AlignmentDirectional(1.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 20.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(FFLocalizations.of(context).getText('msrxr7ql' /* Owner: */,),
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Urbanist',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),
                                  ),
                            ),
                            Padding(
                              padding:const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                              child: Container(
                                width: 25.0,
                                height: 25.0,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  valueOrDefault<String>( // show the profile picture of the owner of the project
                                    currentUserPhoto,    
                                    'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText('fsymek5v' /* Group Members:  */,),
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily:'Urbanist',
                                      fontSize:17.0,
                                      fontWeight:FontWeight.normal,
                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),
                                    ),
                              ),
                            ),
                            Container(
                              width: 66.0,
                              height: 25.0,
                              decoration: const BoxDecoration(),
                              child: ListView.separated( // list to show the profile pictures of all the project's members
                                padding: EdgeInsets.zero,
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: pMembers.length, // iterate through list of memebrs
                                separatorBuilder: (BuildContext context, int index) => SizedBox(width: 2.0),
                                itemBuilder: (BuildContext context, int index){
                                  return Container( // show each memebr's profile picture
                                    width: 25.0,
                                    height: 25.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        pMembers[index].profilePicture,
                                        'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 20.0, 0.0),
                  child: Row( // third row for project containers
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 2.0),
                            child: LinearPercentIndicator(
                              percent: pProgress, // show the progress of the project
                              lineHeight: 18.0,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor: FlutterFlowTheme.of(context).tertiary,
                              backgroundColor: FlutterFlowTheme.of(context).accent3,
                              center: Text( // If whole number, only show whole number with no zeros. Else, only show two places after decimal
                                '${pProgress * 100 % 1 == 0 ? (pProgress * 100).toInt() : (pProgress * 100).toStringAsFixed(2)}%',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).headlineSmall.override(
                                      fontFamily: 'Oswald',
                                      color: Colors.black,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap().containsKey('Oswald'),
                                    ),
                              ),
                              barRadius: const Radius.circular(20.0),
                              padding: EdgeInsets.zero,
                            ),
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
    );
  }

  @override
  Widget build(BuildContext context) { // Main widget that displays the page
    // List of colors
    List<Color> list_colors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple,
                                Colors.yellow, Colors.pink, Colors.deepPurple, Colors.brown, Colors.grey];
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground, // Alignments of circles in background
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
            ClipRRect(  // App Bar
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
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                  child: Text(FFLocalizations.of(context).getText('05ejm1ds' /* My Projects */,),
                                    style: FlutterFlowTheme.of(context).displayMedium.override(
                                          fontFamily: FlutterFlowTheme.of(context).displayMediumFamily,
                                          fontSize: 40.0,
                                          useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).displayMediumFamily),
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [ // Icon with badge
                                      FutureBuilder(
                                        future: invitationsFuture, // find the number of invites a user has and dispaly it
                                        builder:  (BuildContext context, AsyncSnapshot snapshot){
                                          if(snapshot.data == null || snapshot.data == '0'){
                                            return badges.Badge( // If invitations, show icon with badge
                                              showBadge: false,
                                              shape: badges.BadgeShape.circle,
                                              badgeColor: FlutterFlowTheme.of(context).primary,
                                              elevation: 4.0,
                                              padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                                              position: badges.BadgePosition.topEnd(),
                                              animationType: badges.BadgeAnimationType.scale,
                                              toAnimate: true,
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async { // If icon is pressed, go to invitations page
                                                    context.pushNamed('InvitationsPage');
                                                  },
                                                  child: Icon(
                                                    Icons.notifications_rounded,
                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                    size: 35.0,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          else { // If no invitations, show icon without badge
                                            return badges.Badge(
                                              badgeContent: Text(
                                                snapshot.data,
                                                style: FlutterFlowTheme.of(context).titleSmall.override(
                                                      fontFamily:FlutterFlowTheme.of(context).titleSmallFamily,
                                                      color: Colors.white,
                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                              FlutterFlowTheme.of(context).titleSmallFamily),
                                                    ),
                                              ),
                                              showBadge: true,
                                              shape: badges.BadgeShape.circle,
                                              badgeColor: FlutterFlowTheme.of(context).primary,
                                              elevation: 4.0,
                                              padding: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                                              position: badges.BadgePosition.topEnd(),
                                              animationType:badges.BadgeAnimationType.scale,
                                              toAnimate: true,
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async { // go to invitations page
                                                    context.pushNamed('InvitationsPage');
                                                  },
                                                  child: Icon(
                                                    Icons.notifications_rounded,
                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                    size: 35.0,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 610.0,
                            decoration: const BoxDecoration(),
                            child: FutureBuilder(  
                              future: projectsFuture, // get the projects a user is found in
                              builder: (BuildContext context, AsyncSnapshot snapshot){
                                if(snapshot.data == null){ // show loading indicator if list returned by getUserProjects() is null
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
                                else { // if list is not null
                                  return ListView.separated( // If not null, make a list of the projects
                                    padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0,),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    //----- ITERATE THROUGH PROJECT LIST RETURNED BY GETUSERPROJECTS ----
                                    itemCount: snapshot.data.length,
                                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15),
                                    itemBuilder: (BuildContext context, int index) {
                                      int colorIndex = index % list_colors.length;
                                      return projectContainer(context, snapshot.data[index].projectName,
                                              snapshot.data[index].ownerID, snapshot.data[index].projectDescription,
                                              snapshot.data[index].projectDueDate, list_colors[colorIndex],
                                              snapshot.data[index].projectProgress,
                                              snapshot.data[index].projectMembers); // make a container for each project
                                    },
                                  );
                                }
                              }
                            )
                          ),
                          Padding( // Create project Button
                            padding: const EdgeInsetsDirectional.fromSTEB(320.0, 500.0, 0.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30.0,
                              borderWidth: 1.0,
                              buttonSize: 50.0,
                              fillColor: FlutterFlowTheme.of(context).primaryBackground,
                              icon: Icon(
                                Icons.add,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              onPressed: () async { // on press go to create project page
                                context.pushNamed('CreateProjectPage');
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
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