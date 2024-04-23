import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/groupify/pages/home/inside_project/options_subtask/options_subtask_widget.dart';
import '/groupify/pages/home/inside_project/options_task/options_task_widget.dart';
import '/groupify/pages/home/inside_project/project_description/project_description_widget.dart';
import '/groupify/pages/home/inside_project/showcase_profile/showcase_profile_widget.dart';
import '/groupify/pages/home/inside_project/task_subtask_description/task_subtask_description_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'project_page_model.dart';
export 'project_page_model.dart';
import 'package:groupify_final/sql_database_connection.dart';
import 'package:groupify_final/sql_files/tasks_DAO_BO/tasks_BO.dart';
import 'package:groupify_final/sql_files/members_DAO_BO/members_BO.dart';
import 'package:groupify_final/sql_files/subtasks_DAO_BO/subtasks_BO.dart';

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

  final Tasks_BO _tasksBO = Tasks_BO();
  final Subtasks_BO _subtasksBO = Subtasks_BO();
  final Members_BO _membersBO = Members_BO();

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
    membersFuture = _membersBO.getMembersProjectPage(widget.projectName, widget.projectOwnerID); // Fetch members
    tasksFuture = _tasksBO.getTasks(widget.projectName, widget.projectOwnerID); // Fetch tasks
    setState(() {}); // Trigger rebuild once data is being fetched
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  // Widget to create project container
Widget taskContainer(BuildContext context, String tName, String tDescription, double tProgress, double tDifficulty, String tAssigned, String tDue, bool subtaskflag, List<Member> tAssign){ 
    print('this is the tAssigned ' + tAssigned);
    return Padding( padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
  child: InkWell(splashColor: Colors.transparent, focusColor: Colors.transparent, hoverColor: Colors.transparent, highlightColor: Colors.transparent,
    onTap: () async {await showModalBottomSheet(isScrollControlled: true,backgroundColor: Colors.transparent,enableDrag: false,context: context,builder: (context) {
          return GestureDetector(onTap: () => _model.unfocusNode.canRequestFocus
                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                : FocusScope.of(context).unfocus(),
            child: Padding(padding: MediaQuery.viewInsetsOf(context),
              child: Container(height: 350,
                child: TaskSubtaskDescriptionWidget(tDescription: tDescription),
              ),
            ),
          );
        },
      ).then((value) => safeSetState(() {}));
    },
    child: Container(height: 75,
      decoration: BoxDecoration(color: FlutterFlowTheme.of(context).overlay,borderRadius: BorderRadius.circular(20),shape: BoxShape.rectangle,border: Border.all(color: Colors.transparent,width: 0,),),
      child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
        child: Column(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsetsDirectional.fromSTEB(15, 5, 10, 0),
              child: Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 145,decoration: BoxDecoration(),
                    child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                      child: Text(tName,overflow:TextOverflow.ellipsis,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Urbanist',fontSize: 23,letterSpacing: 0,fontWeight: FontWeight.w600,useGoogleFonts:GoogleFonts.asMap().containsKey('Urbanist'),
                            ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsetsDirectional.fromSTEB(5, 3, 10, 0),
                    child: Row(mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 3),
                          child: Text(FFLocalizations.of(context).getText('y58t59f4' /* Due: */,),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Urbanist',fontSize: 17,letterSpacing: 0,fontWeight: FontWeight.normal,useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),),
                          ),
                        ),
                        Container(width: 92, decoration: BoxDecoration(),
                          child: Padding(padding:EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                            child: Text(tDue,style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Urbanist',fontSize: 17,letterSpacing: 0,
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
                      Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                        child: InkWell(splashColor: Colors.transparent,focusColor: Colors.transparent,hoverColor: Colors.transparent,highlightColor: Colors.transparent,
                          onTap: () async {
                            await showModalBottomSheet(isScrollControlled: true,backgroundColor: Colors.transparent,enableDrag: false,
                              context: context,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () => _model
                                          .unfocusNode.canRequestFocus
                                      ? FocusScope.of(context)
                                          .requestFocus(_model.unfocusNode)
                                      : FocusScope.of(context).unfocus(),
                                  child: Padding(padding: MediaQuery.viewInsetsOf(context),
                                    child: Container(height: 200,
                                      child: OptionsTaskWidget(
                                          projectName: widget.projectName,
                                          pOwnerId: widget.projectOwnerID,
                                          pDescription: widget.projectDescription, 
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
                          child: Icon(Icons.more_vert,color: FlutterFlowTheme.of(context).primaryText,size: 24,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 2),
                        child: FlutterFlowIconButton(borderColor: Colors.transparent,borderRadius: 30,borderWidth: 1,buttonSize: 25,
                          fillColor:FlutterFlowTheme.of(context).primaryBackground,
                          icon: Icon(Icons.add,color: FlutterFlowTheme.of(context).primaryText,size: 10,),
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
            Align(alignment: AlignmentDirectional(0, 0),
              child: Padding(padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
                child: Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(FFLocalizations.of(context).getText('xlgpir3u' /* Assigned:  */,),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Urbanist',fontSize: 17,letterSpacing: 0,fontWeight: FontWeight.normal,useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),),),
                        Container(width: 60,height: 25,decoration: BoxDecoration(),
                          child : ListView.separated( 
                            padding: EdgeInsets.zero,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: tAssign.length,
                            separatorBuilder: (BuildContext context, int index) => SizedBox(width: 2.0),
                            itemBuilder: (BuildContext context, int index){
                              return InkWell(splashColor: Colors.transparent,focusColor: Colors.transparent,hoverColor: Colors.transparent,highlightColor: Colors.transparent,
                                onTap: () async {
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
                                            ? FocusScope.of(context)
                                                .requestFocus(_model
                                                    .unfocusNode)
                                            : FocusScope.of(context)
                                                .unfocus(),
                                        child: Padding(
                                          padding: MediaQuery.viewInsetsOf(context),
                                          child: SizedBox(height: 150.0,
                                            child:
                                                ShowcaseProfileWidget(
                                                  username: tAssign[index].username,
                                                  rating: tAssign[index].rating, 
                                                  profilePicture : tAssign[index].profilePicture,                                                 
                                                ), 
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) =>
                                      safeSetState(() {}));
                                },
                                child: Container(width: 25.0,height: 25.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(shape: BoxShape.circle,),
                                  child: Image.network(valueOrDefault(tAssign[index].profilePicture,
                                    'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
                                    ),
                                  ),
                                ),
                              );
                            }
                          )
                        ),
                      ],
                    ),
                    Container(width: 60,decoration: BoxDecoration(),
                      child: Padding(padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                        child: Row(mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(width: 28,decoration: BoxDecoration(),
                              child: Text('${tDifficulty.toString()[0]}/5',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,fontSize: 18,letterSpacing: 0,useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                    ),
                              ),
                            ),
                            Icon(Icons.star_rounded,color: FlutterFlowTheme.of(context).tertiary,size: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(alignment: AlignmentDirectional(0, 0),
                      child: Padding(padding: EdgeInsetsDirectional.fromSTEB(2, 0, 2, 0),
                        child: Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LinearPercentIndicator(percent: tProgress,width: 120,lineHeight: 18,animation: true,animateFromLastPercent: true,progressColor:FlutterFlowTheme.of(context).tertiary,backgroundColor:FlutterFlowTheme.of(context).accent3,
                              center: Text('${tProgress * 100 % 1 == 0 ? (tProgress * 100).toInt() : (tProgress * 100).toStringAsFixed(2)}%',
                                style: FlutterFlowTheme.of(context).headlineSmall.override(fontFamily: 'Oswald',color: Colors.black,fontSize: 13,letterSpacing: 0,fontWeight: FontWeight.w600,useGoogleFonts: GoogleFonts.asMap().containsKey('Oswald'),),),
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

Widget subTaskContainer(BuildContext context, String tName, String stName, String stDescription, double stProgress, double stDifficulty, String stAssigned, String stDue, List<Member> stAssign){ 
  return Padding(padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
  child: Row(mainAxisSize: MainAxisSize.max,
    children: [
      Padding(padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
        child: Icon(Icons.subdirectory_arrow_right,color: FlutterFlowTheme.of(context).secondaryText,size: 25,),),
      Expanded(
        child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
          child: InkWell(splashColor: Colors.transparent,focusColor: Colors.transparent,hoverColor: Colors.transparent,highlightColor: Colors.transparent,
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
                      child: Container(height: 350,
                        child: TaskSubtaskDescriptionWidget(tDescription: stDescription),
                      ),
                    ),
                  );
                },
              ).then((value) => safeSetState(() {}));
            },
            child: Container(height: 75,decoration: BoxDecoration(color: FlutterFlowTheme.of(context).overlay,borderRadius: BorderRadius.circular(20),),
              child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                child: Column(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsetsDirectional.fromSTEB(15, 5, 4, 0),
                      child: Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(width: 155,decoration: BoxDecoration(),
                            child: Padding(padding:EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                              child: Text(stName,
                                overflow: TextOverflow.ellipsis,style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Urbanist',fontSize: 23,letterSpacing: 0,fontWeight: FontWeight.w600,useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),),
                              ),
                            ),
                          ),
                          Padding(padding:EdgeInsetsDirectional.fromSTEB(4, 3, 3, 0),
                            child: Row(mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 3, 3, 0),
                                  child: Text(FFLocalizations.of(context).getText('611wb6zh' /* Due: */,),
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Urbanist',fontSize: 17,letterSpacing: 0,fontWeight: FontWeight.normal,useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),),
                                  ),
                                ),
                                Container(width: 92,decoration: BoxDecoration(),
                                  child: Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                                    child: Text(stDue,
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Urbanist',fontSize: 17,letterSpacing: 0,fontWeight: FontWeight.normal,useGoogleFonts:GoogleFonts.asMap().containsKey('Urbanist'),),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(splashColor: Colors.transparent,focusColor: Colors.transparent,hoverColor: Colors.transparent,highlightColor: Colors.transparent,
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
                                    child: Padding(padding:MediaQuery.viewInsetsOf(context),
                                      child: Container(height: 200,
                                        child: OptionsSubtaskWidget(
                                          projectName: widget.projectName,
                                          pOwnerId: widget.projectOwnerID,
                                          pDescription: widget.projectDescription,
                                          tName: tName, 
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
                            child: Icon(Icons.more_vert,color: FlutterFlowTheme.of(context).primaryText,size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsetsDirectional.fromSTEB(15, 0, 7, 0),
                      child: Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(FFLocalizations.of(context).getText('zemnchb3' /* Assigned:  */,),
                                style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Urbanist',fontSize: 17,letterSpacing: 0,fontWeight: FontWeight.normal,useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),),
                              ),
                              Container(width: 45,height: 25,decoration: BoxDecoration(),
                                child : ListView.separated(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: stAssign.length,
                                  separatorBuilder: (BuildContext context, int index) => SizedBox(width: 2.0),
                                  itemBuilder: (BuildContext context, int index){
                                    return InkWell(splashColor: Colors.transparent,focusColor: Colors.transparent,hoverColor: Colors.transparent,highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await showModalBottomSheet(    
                                          isScrollControlled: true,
                                          backgroundColor:Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () => _model.unfocusNode.canRequestFocus
                                                  ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                  : FocusScope.of(context).unfocus(),
                                              child: Padding(padding: MediaQuery.viewInsetsOf(context),
                                                child: SizedBox(height: 150.0,
                                                  child:
                                                      ShowcaseProfileWidget(
                                                        username: stAssign[index].username,
                                                        rating: stAssign[index].rating,
                                                        profilePicture: stAssign[index].profilePicture,
                                                      ), 
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) =>safeSetState(() {}));
                                      },
                                      child: Container(width: 25.0,height: 25.0,clipBehavior: Clip.antiAlias,decoration: const BoxDecoration(shape: BoxShape.circle,),
                                        child: Image.network(valueOrDefault(stAssign[index].profilePicture,
                                          'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                )
                              ),
                            ],
                          ),
                          Container(width: 60,decoration: BoxDecoration(),
                            child: Padding(padding:EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                              child: Row(mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(width: 28,decoration: BoxDecoration(),
                                    child: Text('${stDifficulty.toString()[0]}/5',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily:FlutterFlowTheme.of(context).bodyMediumFamily,fontSize: 18,letterSpacing: 0,useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),),
                                    ),
                                  ),
                                  Icon(Icons.star_rounded,color:FlutterFlowTheme.of(context).tertiary,size: 24,),
                                ],
                              ),
                            ),
                          ),
                          Padding(padding:EdgeInsetsDirectional.fromSTEB(0, 0, 2, 0),
                            child: Row(mainAxisSize: MainAxisSize.max,
                              children: [
                                LinearPercentIndicator(
                                  percent: stProgress,
                                  width: 105,
                                  lineHeight: 18,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  progressColor:FlutterFlowTheme.of(context).tertiary,
                                  backgroundColor:FlutterFlowTheme.of(context).accent3,
                                  center: Text('${stProgress * 100 % 1 == 0 ? (stProgress * 100).toInt() : (stProgress * 100).toStringAsFixed(2)}%',
                                    style: FlutterFlowTheme.of(context).headlineSmall.override(fontFamily: 'Oswald',color: Colors.black,fontSize: 13,letterSpacing: 0,fontWeight: FontWeight.w600,useGoogleFonts: GoogleFonts.asMap().containsKey('Oswald'),),
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

  @override
Widget build(BuildContext context) {
    return GestureDetector(onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(key: scaffoldKey,backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          alignment: const AlignmentDirectional(1.0, 1.0),
          children: [
            Align(alignment: const AlignmentDirectional(1.0, -1.4),
              child: Container(width: 500.0,height: 500.0,
              decoration: BoxDecoration(color: FlutterFlowTheme.of(context).tertiary,shape: BoxShape.circle,),
              ),
            ),
            if (responsiveVisibility(context: context,tabletLandscape: false,desktop: false,))
              Align(alignment: const AlignmentDirectional(-2.0, -1.5),
                child: Container(width: 350.0,height: 350.0,
                  decoration: BoxDecoration(color: FlutterFlowTheme.of(context).primary,shape: BoxShape.circle,),
                ),
              ),
            if (responsiveVisibility(context: context,tabletLandscape: false,desktop: false,
            ))
              Align(alignment: const AlignmentDirectional(3.49, -1.05),
                child: Container(width: 300.0,height: 300.0,
                  decoration: BoxDecoration(color: FlutterFlowTheme.of(context).secondary,shape: BoxShape.circle,),
                ),
              ),
            Align(alignment: const AlignmentDirectional(0.0, 1.4),
              child: Container(width: 500.0,height: 500.0,
                decoration: BoxDecoration(color: FlutterFlowTheme.of(context).tertiary,shape: BoxShape.circle,),
              ),
            ),
            if (responsiveVisibility(context: context,tabletLandscape: false,desktop: false,
            ))
              Align(alignment: const AlignmentDirectional(7.98, 0.81),
                child: Container(width: 350.0,height: 350.0,
                  decoration: BoxDecoration(color: FlutterFlowTheme.of(context).primary,shape: BoxShape.circle,
                  ),
                ),
              ),
            if (responsiveVisibility(context: context,tabletLandscape: false,desktop: false,
            ))
              Align(alignment: const AlignmentDirectional(-3.41, 0.58),
                child: Container(width: 300.0,height: 300.0,
                  decoration: BoxDecoration(color: FlutterFlowTheme.of(context).secondary,shape: BoxShape.circle,),
                ),
              ),
            ClipRRect(borderRadius: BorderRadius.circular(0.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40.0,sigmaY: 40.0,),
                child: Container(width: 558.0,height: 1037.0,
                  decoration: BoxDecoration(color: FlutterFlowTheme.of(context).overlay,),
                  child: Column(mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(width: 399.0,height: 129.0,
                        decoration: const BoxDecoration(color: Colors.transparent,),
                        alignment: const AlignmentDirectional(0.0, 1.0),
                        child: Align(alignment: const AlignmentDirectional(0.0, 1.0),
                          child: Padding(padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 13.0),
                            child: Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Padding(padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      widget.projectName,
                                      overflow: TextOverflow.ellipsis, 
                                      style: FlutterFlowTheme.of(context).displayMedium.override(fontFamily:FlutterFlowTheme.of(context).displayMediumFamily,fontSize: 40.0,useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).displayMediumFamily),),
                                    ),
                                  ),
                                ),
                                Padding(padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 11.0, 0.0),
                                  child: Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(splashColor: Colors.transparent,focusColor: Colors.transparent,hoverColor: Colors.transparent,highlightColor: Colors.transparent,
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
                                                child: Padding(padding:MediaQuery.viewInsetsOf(context),
                                                  child: SizedBox(height: 350.0,
                                                    child:ProjectDescriptionWidget(pDescription: widget.projectDescription),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) => safeSetState(() {}));
                                        },
                                        child: Icon(
                                          Icons.info,color: FlutterFlowTheme.of(context).primaryText,size: 35.0,
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
                      Align(alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Padding(padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                          child: Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                child: Row(mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 2.0, 0.0),
                                      child: Text(FFLocalizations.of(context).getText('r0y5lwb6' /* Members:  */,),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily:FlutterFlowTheme.of(context).bodyMediumFamily,fontSize: 17.0,useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),),
                                      ),
                                    ),
                                    Container(width: 180.0,height: 40.0,
                                      child : FutureBuilder(
                                          future: _membersBO.getMembersProjectPage(widget.projectName, widget.projectOwnerID), 
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
                                                  return InkWell(splashColor: Colors.transparent,focusColor: Colors.transparent,hoverColor: Colors.transparent,highlightColor: Colors.transparent,
                                                    onTap: () async {
                                                      await showModalBottomSheet(    
                                                        isScrollControlled: true,
                                                        backgroundColor:Colors.transparent,
                                                        enableDrag: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                : FocusScope.of(context).unfocus(),
                                                            child: Padding(padding: MediaQuery.viewInsetsOf(context),
                                                              child: SizedBox(height: 150.0,
                                                                child:
                                                                    ShowcaseProfileWidget(
                                                                      username: snapshot.data[index].username,
                                                                      rating: snapshot.data[index].rating,
                                                                      profilePicture: snapshot.data[index].profilePicture,
                                                                    ), 
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>safeSetState(() {}));
                                                    },
                                                    child: Container(width: 30.0,height: 30.0,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: const BoxDecoration(shape: BoxShape.circle,),
                                                      child: Image.network(valueOrDefault(snapshot.data[index].profilePicture,
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
                              Padding(padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                                child: Row(mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWell(splashColor: Colors.transparent,focusColor: Colors.transparent,hoverColor: Colors.transparent,highlightColor: Colors.transparent,
                                      onTap: () async {
                                      context.pushNamed('BrowsePage', queryParameters: {
                                        'projectOwnerID': widget.projectOwnerID,
                                        'projectName': widget.projectName
                                      });
                                      },
                                      child: Icon(Icons.person_add_alt_1,color: FlutterFlowTheme.of(context).primaryText,size: 35.0,
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
                              future: _tasksBO.getTasks(widget.projectName, widget.projectOwnerID),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(color: Color.fromARGB(99, 120, 227, 215),backgroundColor: Color.fromARGB(30, 57, 210, 192),strokeWidth: 4,),
                                  );
                                }
                                else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error.toString()}'),
                                  );} 
                                else if (snapshot.hasData && snapshot.data!.isNotEmpty){
                                    return ListView.separated(
                                      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data!.length,
                                      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 15),
                                      itemBuilder: (BuildContext context, int index) {
                                        Task task = snapshot.data![index];
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Task widget
                                            taskContainer(
                                              context,
                                              task.taskName,
                                              task.taskDescription,
                                              task.taskProgress,
                                              task.taskDifficulty,
                                              task.taskAssigned,
                                              task.taskDueDate,
                                              task.subtaskflag,
                                              task.tAssign,
                                            ),
                                            FutureBuilder<List<SubTask>>(
                                            future: _subtasksBO.getSubTasks(widget.projectName, widget.projectOwnerID ,task.taskName),
                                            builder: (context, subTaskSnapshot) {
                                              if (subTaskSnapshot.connectionState == ConnectionState.waiting) {
                                                return Center(child: CircularProgressIndicator());
                                              } else if (subTaskSnapshot.hasError) {
                                                return Text('Error: ${subTaskSnapshot.error}');
                                              } else if (subTaskSnapshot.hasData && subTaskSnapshot.data!.isNotEmpty) {
                                                return ListView.builder(
                                                  padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
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
                                                      subTask.subtAssign
                                                    );
                                                  },
                                                );
                                              } else {
                                                return Text('');
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
                          Padding(padding: const EdgeInsetsDirectional.fromSTEB(312.0, 435.0, 0.0, 0.0),
                            child: FlutterFlowIconButton(borderColor: Colors.transparent,borderRadius: 30.0,borderWidth: 1.0,buttonSize: 50.0,fillColor: FlutterFlowTheme.of(context).primaryBackground,
                              icon: Icon(Icons.add,color: FlutterFlowTheme.of(context).primaryText,size: 24.0,),
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