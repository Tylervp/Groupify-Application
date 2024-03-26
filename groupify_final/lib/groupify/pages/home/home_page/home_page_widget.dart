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
import 'package:groupify_final/sql_database_connection.dart';


// Project class to make list of project instances
class Project {
  String projectName = '';
  String ownerID = '';
  String projectDescription = '';
  double projectProgress = 0.0;


  Project(String projectName, String ownerID, String projectDescription, double projectProgress){
    this.projectName = projectName;
    this.ownerID = ownerID;
    this.projectDescription = projectDescription;
    this.projectProgress = projectProgress;
  }
}


class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});
  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}


class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  // Connect to DB
  late SQLDatabaseHelper _sqldatabaseHelper;
  Future<void> _connectToDatabase() async {
    await _sqldatabaseHelper.connectToDatabase();
  }


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    _sqldatabaseHelper = SQLDatabaseHelper();
    _connectToDatabase();
    //_getProjects();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState((){}));
  }


  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }


  // Method to query projects a user is involved in and populate project list
  Future<List<Project>> _getProjects() async {
    List<Project> projects = [];
    //try {
      final results = await _sqldatabaseHelper.connection.query('select Projects.ownerID, Projects.projectName, Projects.projectDescription, Projects.projectProgress from ProjectMembers JOIN Projects ON ProjectMembers.projectName = Projects.projectName and ProjectMembers.ownerID = Projects.ownerID where ProjectMembers.userID = ?;',
    [currentUserDisplayName]);
        print('GOT THE PROJECTS');
        for(final row in results){
          String tempName = row['projectName'] as String;
          String tempOwnerID = row['ownerID'] as String;
          String tempDescription = row['projectDescription'] as String;
          projects.insert(0, Project(tempName, tempOwnerID, tempDescription, 0.0));
        }
    //}catch(e){
      //print("IN CATCH ========================");
    //}
    return projects;
  }


  // Widget to create project container
  Widget projectContainer(BuildContext context, String pName, String pOwnerID, String pDescription, String pDue, Color c, double pProgress){
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
          15.0, 0.0, 15.0, 0.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          context.pushNamed('ProjectPage');
        },
        child: Container(
          height: 100.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context)
                .overlay,
            borderRadius:
                BorderRadius.circular(20.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Colors.transparent,
              width: 0.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                0.0, 0.0, 0.0, 5.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment:
                  MainAxisAlignment.start,
              crossAxisAlignment:
                  CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional
                      .fromSTEB(
                          25.0, 6.0, 19.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 161.0,
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional
                                  .fromSTEB(
                                      5.0,
                                      3.0,
                                      0.0,
                                      0.0),
                          child: Text(
                            pName, //////////////
                            overflow: TextOverflow.ellipsis, ////////////
                            style: FlutterFlowTheme
                                    .of(context)
                                .bodyMedium
                                .override(
                                  fontFamily:
                                      'Urbanist',
                                  fontSize: 23.0,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                  useGoogleFonts: GoogleFonts
                                          .asMap()
                                      .containsKey(
                                          'Urbanist'),
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional
                                .fromSTEB(4.0, 0.0,
                                    0.0, 0.0),
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional
                                      .fromSTEB(
                                          0.0,
                                          3.0,
                                          0.0,
                                          0.0),
                              child: Text(
                                FFLocalizations.of(
                                        context)
                                    .getText(
                                  'uyrtxe9w' /* Due: */,
                                ),
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
                            Container(
                              width: 87.0,
                              decoration:
                                  const BoxDecoration(),
                              child: Padding(
                                padding:
                                    const EdgeInsetsDirectional
                                        .fromSTEB(
                                            3.0,
                                            3.0,
                                            0.0,
                                            0.0),
                                child: Text(
                                  pDue,  /////////////////////////////
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
                          ],
                        ),
                      ),
                      InkWell(
                        splashColor:
                            Colors.transparent,
                        focusColor:
                            Colors.transparent,
                        hoverColor:
                            Colors.transparent,
                        highlightColor:
                            Colors.transparent,
                        onTap: () async {
                          await showModalBottomSheet(
                            isScrollControlled:
                                true,
                            backgroundColor:
                                Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () => _model
                                        .unfocusNode
                                        .canRequestFocus
                                    ? FocusScope.of(
                                            context)
                                        .requestFocus(
                                            _model
                                                .unfocusNode)
                                    : FocusScope.of(
                                            context)
                                        .unfocus(),
                                child: Padding(
                                  padding: MediaQuery
                                      .viewInsetsOf(
                                          context),
                                  child: const SizedBox(
                                    height: 200.0,
                                    child:
                                        OptionsProjectWidget(),
                                        //OptionsProjectWidget(ProjectID);
                                  ),
                                ),
                              );
                            },
                          ).then((value) =>
                              safeSetState(() {}));
                        },
                        child: Icon(
                          Icons.more_vert,
                          color:
                              FlutterFlowTheme.of(
                                      context)
                                  .primaryText,
                          size: 23.0,
                        ),
                      ),
                    ],
                  ),
                ),


                Align(
                  alignment: const AlignmentDirectional(
                      1.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional
                        .fromSTEB(
                            30.0, 0.0, 20.0, 0.0),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.max,
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceEvenly,
                      children: [
                        Row(
                          mainAxisSize:
                              MainAxisSize.max,
                          children: [
                            Text(
                              FFLocalizations.of(
                                      context)
                                  .getText(
                                'msrxr7ql' /* Owner: */,
                              ),
                              style: FlutterFlowTheme
                                      .of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily:
                                        'Urbanist',
                                    fontSize: 17.0,
                                    fontWeight:
                                        FontWeight
                                            .normal,
                                    useGoogleFonts: GoogleFonts
                                            .asMap()
                                        .containsKey(
                                            'Urbanist'),
                                  ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional
                                      .fromSTEB(
                                          5.0,
                                          0.0,
                                          0.0,
                                          0.0),
                              child: Container(
                                width: 25.0,
                                height: 25.0,
                                clipBehavior:
                                    Clip.antiAlias,
                                decoration:
                                    const BoxDecoration(
                                  shape: BoxShape
                                      .circle,
                                ),
                                child: Image.network(  /////////////////////////////
                                  valueOrDefault<String>(
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
                          mainAxisSize:
                              MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional
                                      .fromSTEB(
                                          25.0,
                                          0.0,
                                          0.0,
                                          0.0),
                              child: Text(
                                FFLocalizations.of(
                                        context)
                                    .getText(
                                  'fsymek5v' /* Group Members:  */,
                                ),
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
                            Container(
                              width: 66.0,
                              height: 25.0,
                              decoration:
                                  const BoxDecoration(),
                              child: ListView(
                                padding:
                                    EdgeInsets.zero,
                                primary: false,
                                scrollDirection:
                                    Axis.horizontal,
                                children: [
                                  Container(
                                    width: 25.0,
                                    height: 25.0,
                                    clipBehavior: Clip
                                        .antiAlias,
                                    decoration:
                                        const BoxDecoration(
                                      shape: BoxShape
                                          .circle,
                                    ),
                                    child: Image
                                        .network(
                                      'https://picsum.photos/seed/939/600',
                                      fit: BoxFit
                                          .cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional
                      .fromSTEB(
                          25.0, 0.0, 20.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment:
                              const AlignmentDirectional(
                                  0.0, 0.0),
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional
                                    .fromSTEB(
                                        0.0,
                                        5.0,
                                        0.0,
                                        2.0),
                            child:
                                LinearPercentIndicator(
                              percent: 0.5,
                              lineHeight: 18.0,
                              animation: true,
                              animateFromLastPercent:
                                  true,
                              progressColor:
                                  FlutterFlowTheme.of(
                                          context)
                                      .tertiary,
                              backgroundColor:
                                  FlutterFlowTheme.of(
                                          context)
                                      .accent3,
                              center: Text(
                                FFLocalizations.of(
                                        context)
                                    .getText(
                                  'h45glb7m' /* 50% */,
                                ),
                                textAlign:
                                    TextAlign.start,
                                style: FlutterFlowTheme
                                        .of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily:
                                          'Oswald',
                                      color: Colors
                                          .black,
                                      fontSize:
                                          13.0,
                                      fontWeight:
                                          FontWeight
                                              .w600,
                                      useGoogleFonts: GoogleFonts
                                              .asMap()
                                          .containsKey(
                                              'Oswald'),
                                    ),
                              ),
                              barRadius:
                                  const Radius.circular(
                                      20.0),
                              padding:
                                  EdgeInsets.zero,
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


  //List<Project> projects = [];
  @override
  Widget build(BuildContext context) {
    List<Color> list_colors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple,
                                Colors.yellow, Colors.pink, Colors.deepPurple, Colors.brown, Colors.grey];
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            15.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            '05ejm1ds' /* My Projects */,
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
                                            badges.Badge(       //////////////////////////////// badge
                                              badgeContent: Text(
                                                FFLocalizations.of(context).getText(
                                                  'r6ph4rke' /* 1 */,
                                                ),
                                                style: FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(context)
                                                              .titleSmallFamily,
                                                      color: Colors.white,
                                                      useGoogleFonts: GoogleFonts
                                                              .asMap()
                                                          .containsKey(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmallFamily),
                                                    ),
                                              ),
                                              showBadge: true,
                                              shape: badges.BadgeShape.circle,
                                              badgeColor: FlutterFlowTheme.of(context)
                                                  .primary,
                                              elevation: 4.0,
                                              padding: const EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 8.0, 8.0, 8.0),
                                              position: badges.BadgePosition.topEnd(),
                                              animationType:
                                                  badges.BadgeAnimationType.scale,
                                              toAnimate: true,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                        0.0, 0.0, 0.0, 5.0),
                                                child: InkWell(
                                                  splashColor: Colors.transparent,
                                                  focusColor: Colors.transparent,
                                                  hoverColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () async {
                                                    context
                                                        .pushNamed('InvitationsPage');
                                                  },
                                                  child: Icon(
                                                    Icons.notifications_rounded,
                                                    color:
                                                        FlutterFlowTheme.of(context)
                                                            .primaryText,
                                                    size: 35.0,
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
                            Stack(
                              children: [
                                Container(
                                  height: 610.0,
                                  decoration: const BoxDecoration(),
                                  child: FutureBuilder(  /////
                                    future: _getProjects(),
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
                                      else{
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
                                            int colorIndex = index % list_colors.length;
                                            /*return projectContainer(context, projects[index].projectName,
                                                    projects[index].ownerID, projects[index].projectDescription,
                                                    '12/30/2024', list_colors[colorIndex], 0.0); */
                                            return projectContainer(context, snapshot.data[index].projectName,
                                                    snapshot.data[index].ownerID, snapshot.data[index].projectDescription,
                                                    '12/30/2024', list_colors[colorIndex], 0.0);
                                           
                                          },
                                        );
                                      }
                                    }
                                  )
                                ),
                                Padding( //Button
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      320.0, 500.0, 0.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30.0,
                                    borderWidth: 1.0,
                                    buttonSize: 50.0,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    icon: Icon(
                                      Icons.add,
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
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
      //}
  }
}

