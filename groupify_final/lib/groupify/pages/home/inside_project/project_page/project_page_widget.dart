import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/groupify/pages/home/inside_project/options_subtask/options_subtask_widget.dart';
import '/groupify/pages/home/inside_project/options_task/options_task_widget.dart';
import '/groupify/pages/home/inside_project/project_description/project_description_widget.dart';
import '/groupify/pages/home/inside_project/showcase_profile/showcase_profile_widget.dart';
import '/groupify/pages/home/inside_project/task_subtask_description/task_subtask_description_widget.dart';
import '/groupify/pages/home/home_page/home_page_widget.dart';
import 'dart:ui';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'project_page_model.dart';
export 'project_page_model.dart';
import 'package:groupify_final/sql_database_connection.dart';


class Task {
  String taskName = '';
  String taskDescription = '';
  double taskProgress = 0.0;
  double taskDifficulty = 0.0;
  String taskAssigned = '';
  String taskDueDate = '';
  bool subtaskflag = false;

  Task(String taskName, String taskDescription, double taskProgress, double taskDifficulty, String taskAssigned, String taskDueDate, bool subtaskflag){
    this.taskName = taskName;
    this.taskDescription = taskDescription;
    this.taskProgress = taskProgress;
    this.taskDifficulty = taskDifficulty;
    this.taskAssigned = taskAssigned;
    this.taskDueDate = taskDueDate;
    this.subtaskflag = subtaskflag;
  }
}

class SubTask {
  String taskName = '';
  String subTaskName = '';
  String subTaskDescription = '';
  double subTaskProgress = 0.0;
  double subTaskDifficulty = 0.0;
  String subTaskAssigned = '';
  String subTaskDueDate = '';

  SubTask(String taskName, String subTaskName, String subTaskDescription, double subTaskProgress, double subTaskDifficulty, String subTaskAssigned, String subTaskDueDate){
    this.taskName = taskName;
    this.subTaskName = subTaskName;
    this.subTaskDescription = subTaskDescription;
    this.subTaskProgress = subTaskProgress;
    this.subTaskDifficulty = subTaskDifficulty;
    this.subTaskAssigned = subTaskAssigned;
    this.subTaskDueDate = subTaskDueDate;
  }
}

class Member {
  String username = '';
  String profilePicture = '';
  double rating = 0.0;

  Member(String username, String profilePicture, double rating){
    this.username = username;
    this.profilePicture = profilePicture;
    this.rating = rating;
  }
}

class ProjectPageWidget extends StatefulWidget {
  final String projectOwnerID;
  final String projectName;
  final String projectDescription;

  const ProjectPageWidget({super.key, required this.projectOwnerID,required this.projectName, required this.projectDescription});

  @override
  State<ProjectPageWidget> createState() => _ProjectPageWidgetState();
}

class _ProjectPageWidgetState extends State<ProjectPageWidget> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();  // Define the scaffoldKey
  late ProjectPageModel _model;
  late SQLDatabaseHelper _sqldatabaseHelper;
  Future<List<Member>>? membersFuture;
  Future<List<Task>>? tasksFuture;


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProjectPageModel());
    _sqldatabaseHelper = SQLDatabaseHelper();
    _initializeData();
  }

void _initializeData() async {
    await _sqldatabaseHelper.connectToDatabase();
    membersFuture = _getMembers(); // Fetch members
    tasksFuture = _getTasks(); // Fetch tasks
    setState(() {}); // Trigger rebuild once data is being fetched
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  // Method to get members of the project
  Future<List<Member>> _getMembers() async {
    List<Member> members = [];
    double rating;
    double sum;
    double temp;

    final results = await _sqldatabaseHelper.connection.query('SELECT userID FROM projectMembers WHERE projectName = ? and ownerID = ?;',
                                                          [widget.projectName, widget.projectOwnerID]); 
    print('GOT PROJECT MEMBERS');
    for(final row in results){
      String tempUserName = row['userID'] as String;
      rating = 0;
      sum = 0;
      temp = 0;
      final results2 = await _sqldatabaseHelper.connection.query('SELECT rating FROM userRating WHERE userID = ?;',
                                                          [tempUserName]); 
      for(final row in results2){
        temp = row['rating'] as double;
        sum += temp;
      }
      rating = sum/results2.length;
      members.add(Member(tempUserName, '', rating));
    }
    return members;
  }

  // Method to query projects a user is involved in and populate project list
  Future<List<Task>> _getTasks() async {
    List<Task> tasks = [];
    final results = await _sqldatabaseHelper.connection.query('select taskName, taskDescription, taskProgress, taskDifficulty, taskAssigned, taskDueDate from Tasks where projectName = ? and ownerId = ?',
                                                            [widget.projectName, widget.projectOwnerID]);
    print('GOT THE TASKS');
    for(final row in results){
      
      String temptaskName = row['taskName'] as String;
      String temptaskDescription = row['taskDescription'] as String;
      double temptaskProgress = row['taskProgress'] as double;
      double temptaskDifficulty = row['taskDifficulty'] as double;
      String temptaskAssigned = row['taskAssigned'] as String;
      String temptaskDueDate = row['taskDueDate'] as String;

      final results2 = await _sqldatabaseHelper.connection.query('select subTaskName from Subtasks where projectName = ? and ownerId = ? and taskName =?',
                                                            [widget.projectName, widget.projectOwnerID, temptaskName]);
      List<String> subtasksfortask = [];
      for (final row in results2){
        String tempsubtaskintask = row['subTaskName'] as String;
        subtasksfortask.insert(0, tempsubtaskintask);
      }
      if(subtasksfortask.isEmpty){
        bool tempsubtaskflag = false;
        double finalProgress = temptaskProgress;
        tasks.insert(0, Task(temptaskName, temptaskDescription, finalProgress, temptaskDifficulty, temptaskAssigned, temptaskDueDate, tempsubtaskflag));
      }
      else {
        double sum = 0;
        bool tempsubtaskflag = true;
        List<double> subtaskprogressfortask = [];
        double averagedtaskProgress;
        final results3 = await _sqldatabaseHelper.connection.query('select subTaskProgress from Subtasks where projectName = ? and ownerId = ? and taskName =?',
                                                            [widget.projectName, widget.projectOwnerID, temptaskName]);
        for (final row in results3){
        double tempsubtaskprogressintask = row['subTaskProgress'] as double;
        sum += tempsubtaskprogressintask;
        subtaskprogressfortask.add(tempsubtaskprogressintask);
        }
        averagedtaskProgress = sum/subtaskprogressfortask.length;
        await _sqldatabaseHelper.connection.query( 
          'UPDATE Tasks SET taskProgress = ? WHERE projectName = ? and ownerID = ? and taskName = ?;',
              [averagedtaskProgress, widget.projectName, widget.projectOwnerID, temptaskName]);
        tasks.insert(0, Task(temptaskName, temptaskDescription, averagedtaskProgress, temptaskDifficulty, temptaskAssigned, temptaskDueDate, tempsubtaskflag));
      }
    }
    //_sqldatabaseHelper.closeConnection();
    return tasks;
  }

  Future<List<SubTask>> _getSubTasks(taskName) async {
    List<SubTask> subtasks = [];
    try{
    final results = await _sqldatabaseHelper.connection.query('select taskName, subTaskName, subTaskDescription, subTaskProgress, subTaskDifficulty, subTaskAssigned, subTaskDueDate from Subtasks where projectName = ? and ownerID = ? and taskName = ?;',
                                                            [widget.projectName, widget.projectOwnerID, taskName]);
    print('GOT THE SUBTASKS');
    for(final row in results){
      String temptaskName = row['taskName'] as String;
      String tempsubTaskName = row['subTaskName'] as String;
      String tempsubTaskDescription = row['subTaskDescription'] as String;
      double tempsubTaskProgress = row['subTaskProgress'] as double;
      double tempsubTaskDifficulty = row['subTaskDifficulty'] as double;
      String tempsubTaskAssigned = row['subTaskAssigned'] as String;
      String tempsubTaskDueDate = row['subTaskDueDate'] as String;

      subtasks.insert(0, SubTask(temptaskName, tempsubTaskName, tempsubTaskDescription, tempsubTaskProgress, tempsubTaskDifficulty, tempsubTaskAssigned, tempsubTaskDueDate));
    }} catch (e)
    { print('Error fetching subtasks: $e');};
    //_sqldatabaseHelper.closeConnection();
    return subtasks;
  }

  // Widget to create project container
  Widget taskContainer(BuildContext context, String tName, String tDescription, double tProgress, double tDifficulty, String tAssigned, String tDue, bool subtaskflag){ 
    print('this is the tAssigned ' + tAssigned);
    return Padding(
  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
  child: InkWell(
    splashColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () async {
      await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () => _model.unfocusNode.canRequestFocus
                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                : FocusScope.of(context).unfocus(),
            child: Padding(
              padding: MediaQuery.viewInsetsOf(context),
              child: Container(
                height: 350,
                child: TaskSubtaskDescriptionWidget(tDescription: tDescription),
              ),
            ),
          );
        },
      ).then((value) => safeSetState(() {}));
    },
    child: Container(
      height: 75,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).overlay,
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Colors.transparent,
          width: 0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 5, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 145,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                      child: Text(
                        tName,
                        overflow:TextOverflow.ellipsis,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily: 'Urbanist',
                              fontSize: 23,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts:
                                  GoogleFonts.asMap().containsKey('Urbanist'),
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 3, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 3),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'y58t59f4' /* Due: */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Urbanist',
                                  fontSize: 17,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey('Urbanist'),
                                ),
                          ),
                        ),
                        Container(
                          width: 87,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                            child: Text(
                              tDue,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Urbanist',
                                    fontSize: 17,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey('Urbanist'),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              enableDrag: false,
                              context: context,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () => _model
                                          .unfocusNode.canRequestFocus
                                      ? FocusScope.of(context)
                                          .requestFocus(_model.unfocusNode)
                                      : FocusScope.of(context).unfocus(),
                                  child: Padding(
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: Container(
                                      height: 200,
                                      child: OptionsTaskWidget(
                                          projectName: widget.projectName,
                                          pOwnerId: widget.projectOwnerID,
                                          pDescription: widget.projectDescription,    //////////////
                                          tName: tName, 
                                          tDescription: tDescription,
                                          tProgress: tProgress, 
                                          tDifficulty: tDifficulty,
                                          tAssigned: tAssigned,
                                          tDue: tDue,
                                          subtaskflag: subtaskflag),
                                    ),
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                          child: Icon(
                            Icons.more_vert,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 2),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 25,
                          fillColor:
                              FlutterFlowTheme.of(context).primaryBackground,
                          icon: Icon(
                            Icons.add,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 10,
                          ),
                          onPressed: () async {
                            context.pushNamed('SubtaskCreationPage', queryParameters: {
                                  'taskName': tName,
                                  'projectOwnerID': widget.projectOwnerID,
                                  'projectName': widget.projectName,
                                  'projectDescription': widget.projectDescription,
            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'xlgpir3u' /* Assigned:  */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Urbanist',
                                fontSize: 17,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                                useGoogleFonts: GoogleFonts.asMap()
                                    .containsKey('Urbanist'),
                              ),
                        ),
                        Container(
                          width: 60,
                          height: 25,
                          decoration: BoxDecoration(),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  'https://picsum.photos/seed/939/600',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ].divide(SizedBox(width: 2)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 60,
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 28,
                              decoration: BoxDecoration(),
                              child: Text(
                                '${tDifficulty.toString()[0]}/5',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      fontSize: 18,
                                      letterSpacing: 0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                    ),
                              ),
                            ),
                            Icon(
                              Icons.star_rounded,
                              color: FlutterFlowTheme.of(context).tertiary,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(2, 0, 2, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LinearPercentIndicator(
                              percent: tProgress,
                              width: 120,
                              lineHeight: 18,
                              animation: true,
                              animateFromLastPercent: true,
                              progressColor:
                                  FlutterFlowTheme.of(context).tertiary,
                              backgroundColor:
                                  FlutterFlowTheme.of(context).accent3,
                              center: Text(
                                '${tProgress * 100 % 1 == 0 ? (tProgress * 100).toInt() : (tProgress * 100).toStringAsFixed(2)}%',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                      fontFamily: 'Oswald',
                                      color: Colors.black,
                                      fontSize: 13,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Oswald'),
                                    ),
                              ),
                              barRadius: Radius.circular(20),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);

  }

  Widget subTaskContainer(BuildContext context, String tName, String stName, String stDescription, double stProgress, double stDifficulty, String stAssigned, String stDue){ 
    return Padding(
  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
  child: Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Padding(
        padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
        child: Icon(
          Icons.subdirectory_arrow_right,
          color: FlutterFlowTheme.of(context).secondaryText,
          size: 25,
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                enableDrag: false,
                context: context,
                builder: (context) {
                  return GestureDetector(
                    onTap: () => _model.unfocusNode.canRequestFocus
                        ? FocusScope.of(context)
                            .requestFocus(_model.unfocusNode)
                        : FocusScope.of(context).unfocus(),
                    child: Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: Container(
                        height: 350,
                        child: TaskSubtaskDescriptionWidget(tDescription: stDescription),
                      ),
                    ),
                  );
                },
              ).then((value) => safeSetState(() {}));
            },
            child: Container(
              height: 75,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).overlay,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 5, 4, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 155,
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                              child: Text(
                                stName,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Urbanist',
                                      fontSize: 23,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Urbanist'),
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(4, 3, 3, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 3, 3, 0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '611wb6zh' /* Due: */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Urbanist',
                                          fontSize: 17,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Urbanist'),
                                        ),
                                  ),
                                ),
                                Container(
                                  width: 87,
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 3, 0, 0),
                                    child: Text(
                                      stDue,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            fontSize: 17,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
                                            useGoogleFonts:
                                                GoogleFonts.asMap()
                                                    .containsKey('Urbanist'),
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () => _model
                                            .unfocusNode.canRequestFocus
                                        ? FocusScope.of(context)
                                            .requestFocus(_model.unfocusNode)
                                        : FocusScope.of(context).unfocus(),
                                    child: Padding(
                                      padding:
                                          MediaQuery.viewInsetsOf(context),
                                      child: Container(
                                        height: 200,
                                        child: OptionsSubtaskWidget(
                                          projectName: widget.projectName,
                                          pOwnerId: widget.projectOwnerID,
                                          pDescription: widget.projectDescription,
                                          tName: tName,    //////////////
                                          stName: stName, 
                                          stDescription: stDescription,
                                          stProgress: stProgress, 
                                          stDifficulty: stDifficulty,
                                          stAssigned: stAssigned,
                                          stDue: stDue),
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            child: Icon(
                              Icons.more_vert,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 7, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                FFLocalizations.of(context).getText(
                                  'zemnchb3' /* Assigned:  */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Urbanist',
                                      fontSize: 17,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Urbanist'),
                                    ),
                              ),
                              Container(
                                width: 45,
                                height: 25,
                                decoration: BoxDecoration(),
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/409/600',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 2)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 60,
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 28,
                                    decoration: BoxDecoration(),
                                    child: Text(
                                      '${stDifficulty.toString()[0]}/5',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            fontSize: 18,
                                            letterSpacing: 0,
                                            useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMediumFamily),
                                          ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.star_rounded,
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 2, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                LinearPercentIndicator(
                                  percent: stProgress,
                                  width: 105,
                                  lineHeight: 18,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  progressColor:
                                      FlutterFlowTheme.of(context).tertiary,
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).accent3,
                                  center: Text(
                                    '${stProgress * 100 % 1 == 0 ? (stProgress * 100).toInt() : (stProgress * 100).toStringAsFixed(2)}%',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          fontFamily: 'Oswald',
                                          color: Colors.black,
                                          fontSize: 13,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Oswald'),
                                        ),
                                  ),
                                  barRadius: Radius.circular(20),
                                  padding: EdgeInsets.zero,
                                ),
                              ],
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
        ),
      ),
    ],
  ),
);


}

  String? taskName2 = 'issueissue';
  @override
  Widget build(BuildContext context) {
    // Check if info from homepage is correct (CAN DELETE v)
    final projectName = widget.projectName;
    final projectOwnerID = widget.projectOwnerID;
    final projectDescription = widget.projectDescription;
    print(widget.projectName + ' oooooooooooooooooooooooooooooooooooooooooo');
    print(widget.projectOwnerID + ' oooooooooooooooooooooooooooooooooooooooooo');
    print(widget.projectDescription + ' oooooooooooooooooooooooooooooooooooooooooo');
    //_updateProgress(projectName, projectOwnerID);
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
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      widget.projectName,
                                      overflow: TextOverflow.ellipsis, 
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
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 15.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      badges.Badge(
                                        badgeContent: Text(
                                          FFLocalizations.of(context).getText(
                                            'hos8rg9o' /* 1 */,
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
                                                  .pushNamed('RatingPage', queryParameters: {
                                                    'projectOwnerID': widget.projectOwnerID,
                                                    'projectName': widget.projectName,
                                                    'projectDescription': widget.projectDescription,
                                                  });
                                            },
                                            child: Icon(
                                              Icons.message_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 35.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () => _model.unfocusNode
                                                        .canRequestFocus
                                                    ? FocusScope.of(context)
                                                        .requestFocus(
                                                            _model.unfocusNode)
                                                    : FocusScope.of(context)
                                                        .unfocus(),
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child: SizedBox(
                                                    height: 350.0,
                                                    child:
                                                        ProjectDescriptionWidget(pDescription: widget.projectDescription),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then(
                                              (value) => safeSetState(() {}));
                                        },
                                        child: Icon(
                                          Icons.info,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 35.0,
                                        ),
                                      ),
                                    ].divide(const SizedBox(width: 10.0)),
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 2.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'r0y5lwb6' /* Members:  */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily,
                                              fontSize: 17.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily),
                                            ),
                                      ),
                                    ),
                                    Container(
                                      width: 180.0,
                                      height: 40.0,
                                      child : FutureBuilder(
                                          future: _getMembers(), 
                                          builder: (BuildContext context, AsyncSnapshot snapshot){
                                            if(snapshot.data == null){
                                              return SizedBox();
                                            }
                                            else{
                                              return ListView.separated(
                                                padding: EdgeInsets.zero,
                                                primary: false,
                                                scrollDirection: Axis.horizontal,
                                                itemCount: snapshot.data.length,
                                                separatorBuilder: (BuildContext context, int index) => SizedBox(width: 9.0),
                                                itemBuilder: (BuildContext context, int index){
                                                  return InkWell(
                                                    splashColor: Colors.transparent,
                                                    focusColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: () async {
                                                      await showModalBottomSheet(    
                                                        isScrollControlled: true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        enableDrag: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () => _model
                                                                    .unfocusNode
                                                                    .canRequestFocus
                                                                ? FocusScope.of(context)
                                                                    .requestFocus(_model
                                                                        .unfocusNode)
                                                                : FocusScope.of(context)
                                                                    .unfocus(),
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child: SizedBox(
                                                                height: 150.0,
                                                                child:
                                                                    ShowcaseProfileWidget(
                                                                      username: snapshot.data[index].username,
                                                                      rating: snapshot.data[index].rating,
                                                                    ), 
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                    },
                                                    child: Container(
                                                      width: 30.0,
                                                      height: 30.0,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        valueOrDefault(
                                                        snapshot.data[index].profilePicture,
                                                        'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              );
                                            }
                                          }      
                                      )
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 15.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                      context.pushNamed('BrowsePage', queryParameters: {
                                        'projectOwnerID': widget.projectOwnerID,
                                        'projectName': widget.projectName
                                      });
                                      },
                                      child: Icon(
                                        Icons.person_add_alt_1,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 35.0,
                                      ),
                                    ),
                                  ].divide(const SizedBox(width: 10.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 565.0,
                            decoration: const BoxDecoration(),
                            child: FutureBuilder<List<Task>>(
                              future: _getTasks(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Color.fromARGB(99, 120, 227, 215),
                                      backgroundColor: Color.fromARGB(30, 57, 210, 192),
                                      strokeWidth: 4,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error.toString()}'),
                                  );
                                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                  return ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data!.length,
                                    separatorBuilder: (context, index) => SizedBox(height: 15),
                                    itemBuilder: (context, index) {
                                      Task task = snapshot.data![index];
                                      return Column(
                                        children: [
                                          taskContainer(
                                            context,
                                            task.taskName,
                                            task.taskDescription,
                                            task.taskProgress,
                                            task.taskDifficulty,
                                            task.taskAssigned,
                                            task.taskDueDate,
                                            task.subtaskflag,
                                          ),
                                          FutureBuilder<List<SubTask>>(
                                            future: _getSubTasks(task.taskName),
                                            builder: (context, subTaskSnapshot) {
                                              if (subTaskSnapshot.connectionState == ConnectionState.waiting) {
                                                return Center(child: CircularProgressIndicator());
                                              } else if (subTaskSnapshot.hasError) {
                                                return Text('Error: ${subTaskSnapshot.error}');
                                              } else if (subTaskSnapshot.hasData && subTaskSnapshot.data!.isNotEmpty) {
                                                return ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(), // To avoid nested scrolling issues
                                                  itemCount: subTaskSnapshot.data!.length,
                                                  itemBuilder: (context, subIndex) {
                                                    SubTask subTask = subTaskSnapshot.data![subIndex];
                                                    return subTaskContainer(
                                                      context,
                                                      subTask.taskName,
                                                      subTask.subTaskName,
                                                      subTask.subTaskDescription,
                                                      subTask.subTaskProgress,
                                                      subTask.subTaskDifficulty,
                                                      subTask.subTaskAssigned,
                                                      subTask.subTaskDueDate,
                                                    );
                                                  },
                                                );
                                              } else {
                                                return Text('No sub-tasks found');
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return Center(child: Text('No tasks found'));
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(312.0, 435.0, 0.0, 0.0),
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
                              onPressed: () async {
                                context.pushNamed('TaskCreationPage', queryParameters: {
                                  'projectOwnerID': widget.projectOwnerID,
                                  'projectName': widget.projectName,
                                  'projectDescription': widget.projectDescription,
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      ])
                ))
              )]
            )
        ));}}