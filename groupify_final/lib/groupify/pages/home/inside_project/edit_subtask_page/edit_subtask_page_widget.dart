import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'edit_subtask_page_model.dart';
export 'edit_subtask_page_model.dart';
import 'package:groupify_final/sql_database_connection.dart';

class EditSubtaskPageWidget extends StatefulWidget {
  final String? projectName;
  final String? pOwnerId;
  final String? pDescription;
  final String? tName;
  final String? stName;
  final String? stDescription;
  final String? stProgress;
  final String? stDifficulty;
  final String? stAssigned;
  final String? stDue;
  const EditSubtaskPageWidget({super.key, this.projectName, this.pOwnerId, this.pDescription, this.tName, this.stName, this.stDescription, this.stProgress, this.stDifficulty, this.stAssigned, this.stDue});

  @override
  State<EditSubtaskPageWidget> createState() => _EditSubtaskPageWidgetState();
}

class _EditSubtaskPageWidgetState extends State<EditSubtaskPageWidget> {
  late EditSubtaskPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late SQLDatabaseHelper _sqldatabaseHelper;
  Future<void> _connectToDatabase() async {
    await _sqldatabaseHelper.connectToDatabase();
  }


  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditSubtaskPageModel());

    _model.subtaskNameController ??= TextEditingController(text: widget.stName);
    _model.subtaskNameFocusNode ??= FocusNode();

    _model.subtaskDescriptionController ??= TextEditingController(text: widget.stDescription);
    _model.subtaskDescriptionFocusNode ??= FocusNode();

    _sqldatabaseHelper = SQLDatabaseHelper();
    _connectToDatabase();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }


Future<List<String>> _getMembers() async {
  List<String> mems = [];
  final results = await _sqldatabaseHelper.connection.query(
    'select userID from ProjectMembers where ownerID = ? and projectName = ?;',
    [widget.pOwnerId, widget.projectName],
  );
  for (final row in results) {
    String tempmem = row['userID'] as String;
    mems.add(tempmem);
  }
  //_sqldatabaseHelper.closeConnection();
  return mems;
}

Future<void> _updateSubTask(String? newstDue) async {
  final String newstName = _model.subtaskNameController.text;
  final String newstDescription = _model.subtaskDescriptionController.text;
  final double newstProgress = double.parse(widget.stProgress ?? '0.0');
  final double? newstDifficulty = _model.ratingBarValue;
  final List<String>? taskAssigned = _model.dropDownValueController?.value;
  final String newstAssigned = taskAssigned?.join(', ') ?? '';

  print('this is the newtDescription ' + newstDescription);
  print('this is the newtDifficulty ' + newstDifficulty.toString());
  print('this is the newtAssigned ' + newstAssigned);
  print('this is the newtProgress ' + newstProgress.toString());
  print('this is the newtDue ' + newstDue.toString());
  print('this is the projectName ' + widget.projectName.toString());
  print('this is the pOwnerId ' + widget.pOwnerId.toString());
  print('this is the tName ' + widget.tName.toString());

  try{
    final results = await _sqldatabaseHelper.connection.query( 
        'update Tasks set subTaskName = ?, subTaskDescription = ?, subTaskProgress = ?, subTaskDifficulty = ?, subTaskAssigned = ?, subTaskDueDate = ? where projectName = ? and ownerID = ? and taskName = ? and subTaskName = ?;',
            [newstName, newstDescription, newstProgress, newstDifficulty, newstAssigned, newstDue, widget.projectName, widget.pOwnerId, widget.tName, widget.stName]);
   
    print('TASK UPDATED  ${results.insertId}');
  } catch (e) {print('this is the error ' + e.toString());}
    _sqldatabaseHelper.closeConnection();
  }

  String? nstDue = '';
  @override
  Widget build(BuildContext context) {

    print('this is the projectName '+ widget.projectName.toString());
    print('this is the pDescription ' + widget.pDescription.toString());
    print('this is the pOwnerId ' + widget.pOwnerId.toString());
    print('this is the tName ' + widget.tName.toString());
    print('this is the stName ' + widget.stName.toString());
    print('this is the stDescription ' + widget.stDescription.toString());
    print('this is the stProgress ' + widget.stProgress.toString());
    print('this is the stDifficulty ' + widget.stDifficulty.toString());
    print('this is the stAssigned ' + widget.stAssigned.toString());
    print('this is the stDue ' + widget.stDue.toString());
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
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 40.0),
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
                                            'ij81r6kv' /* Edit Subtask */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .displayMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .displayMediumFamily,
                                                fontSize: 40.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(FlutterFlowTheme
                                                            .of(context)
                                                        .displayMediumFamily),
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 15.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 5.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context
                                                      .pushNamed('ProjectPage', queryParameters: {
                                                      'projectOwnerID': widget.pOwnerId,
                                                      'projectName': widget.projectName,
                                                      'projectDescription': widget.pDescription,
                                                    });
                                                },
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    25.0, 0.0, 0.0, 3.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    '85zns82k' /* Subtask Name */,
                                  ),
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 15.0),
                              child: TextFormField(
                                controller: _model.subtaskNameController,
                                focusNode: _model.subtaskNameFocusNode,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle:
                                      FlutterFlowTheme.of(context).bodySmall,
                                  hintText: FFLocalizations.of(context).getText(
                                    'gev50m9s' /* Enter subtask name... */,
                                  ),
                                  hintStyle:
                                      FlutterFlowTheme.of(context).bodySmall,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00E0E3E7),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor:
                                      FlutterFlowTheme.of(context).overlay,
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          20.0, 24.0, 20.0, 24.0),
                                ),
                                style: FlutterFlowTheme.of(context).bodyMedium,
                                maxLines: null,
                                validator: _model
                                    .subtaskNameControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    25.0, 0.0, 0.0, 3.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'ssi8go7o' /* Subtask Description */,
                                  ),
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 15.0),
                              child: TextFormField(
                                controller: _model.subtaskDescriptionController,
                                focusNode: _model.subtaskDescriptionFocusNode,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                  hintText: FFLocalizations.of(context).getText(
                                    'so0slm2d' /* Enter subtask description... */,
                                  ),
                                  hintStyle:
                                      FlutterFlowTheme.of(context).bodySmall,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00E0E3E7),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor:
                                      FlutterFlowTheme.of(context).overlay,
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          20.0, 24.0, 0.0, 24.0),
                                ),
                                style: FlutterFlowTheme.of(context).bodyMedium,
                                maxLines: 10,
                                validator: _model
                                    .subtaskDescriptionControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    25.0, 0.0, 0.0, 3.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'zpnsqh3k' /* Due Date */,
                                  ),
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 15.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  final datePickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: getCurrentTimestamp,
                                    firstDate: getCurrentTimestamp,
                                    lastDate: DateTime(2050),
                                    builder: (context, child) {
                                      return wrapInMaterialDatePickerTheme(
                                        context,
                                        child!,
                                        headerBackgroundColor:
                                            const Color(0xFF6F61EF),
                                        headerForegroundColor: Colors.white,
                                        headerTextStyle: FlutterFlowTheme.of(
                                                context)
                                            .headlineLarge
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: const Color(0xFF15161E),
                                              fontSize: 32.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey('Outfit'),
                                            ),
                                        pickerBackgroundColor: Colors.white,
                                        pickerForegroundColor:
                                            const Color(0xFF15161E),
                                        selectedDateTimeBackgroundColor:
                                            const Color(0xFF6F61EF),
                                        selectedDateTimeForegroundColor:
                                            Colors.white,
                                        actionButtonForegroundColor:
                                            const Color(0xFF15161E),
                                        iconSize: 24.0,
                                      );
                                    },
                                  );

                                  if (datePickedDate != null) {
                                    safeSetState(() {
                                      _model.datePicked = DateTime(
                                        datePickedDate.year,
                                        datePickedDate.month,
                                        datePickedDate.day,
                                      );
                                    });
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).overlay,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Align(
                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          dateTimeFormat(
                                            'MMMEd',
                                            _model.datePicked,
                                            locale: FFLocalizations.of(context)
                                                .languageCode,
                                          ),
                                          (widget.stDue == null)  ? 'Select a date' : widget.stDue.toString(),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Urbanist',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey('Urbanist'),
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 15.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          25.0, 0.0, 0.0, 3.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '5vuxcz6s' /* Assign:  */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                  FutureBuilder<List<String>>(
  future: _getMembers(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else {
      final List<String> options = snapshot.data ?? []; // Provide a default empty list if data is null
      return
                                  FlutterFlowDropDown<String>(
                                    multiSelectController: _model
                                            .dropDownValueController ??=
                                        FormFieldController<List<String>>(null),
                                    options: options,
                                    width: 300.0,
                                    height: 50.0,
                                    textStyle:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      '8g5l1hm9' /* Please select... */,
                                    ),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 24.0,
                                    ),
                                    fillColor:
                                        FlutterFlowTheme.of(context).overlay,
                                    elevation: 2.0,
                                    borderColor: Colors.transparent,
                                    borderWidth: 2.0,
                                    borderRadius: 8.0,
                                    margin: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 4.0, 16.0, 4.0),
                                    hidesUnderline: true,
                                    isOverButton: true,
                                    isSearchable: false,
                                    isMultiSelect: true,
                                    onMultiSelectChanged: (val) => setState(
                                        () => _model.dropDownValue = val),
                                  );
    }
  },
),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 15.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          25.0, 0.0, 0.0, 3.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'r4rscmbk' /* Difficulty:  */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                  RatingBar.builder(
                                    onRatingUpdate: (newValue) => setState(
                                        () => _model.ratingBarValue = newValue),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                    ),
                                    direction: Axis.horizontal,
                                    initialRating: double.parse(widget.stDifficulty ?? '3.0'),
                                    unratedColor:
                                        FlutterFlowTheme.of(context).accent3,
                                    itemCount: 5,
                                    itemSize: 35.0,
                                    glowColor:
                                        FlutterFlowTheme.of(context).tertiary,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        25.0, 0.0, 0.0, 3.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        '27hchqvw' /* Progress:  */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5.0, 5.0, 0.0, 2.0),
                                    child: LinearPercentIndicator(
                                      percent: double.parse(widget.stProgress ?? '0.0'),
                                      width: 280.0,
                                      lineHeight: 18.0,
                                      animation: true,
                                      animateFromLastPercent: true,
                                      progressColor:
                                          FlutterFlowTheme.of(context).tertiary,
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).accent3,
                                      center: Text(
                                        '${double.parse(widget.stProgress ?? '0.0') * 100 % 1 == 0 ? (double.parse(widget.stProgress ?? '0.0') * 100).toInt() : (double.parse(widget.stProgress ?? '0.0') * 100).toStringAsFixed(2)}%',
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .headlineSmall
                                            .override(
                                              fontFamily: 'Oswald',
                                              color: Colors.black,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey('Oswald'),
                                            ),
                                      ),
                                      barRadius: const Radius.circular(20.0),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              _updateSubTask(nstDue);
                              context.pushNamed('ProjectPage', queryParameters: {
                                                      'projectOwnerID': widget.pOwnerId,
                                                      'projectName': widget.projectName,
                                                      'projectDescription': widget.pDescription,
                                                    });
                            },
                            text: FFLocalizations.of(context).getText(
                              '4te14s09' /* Edit Subtask */,
                            ),
                            options: FFButtonOptions(
                              width: 130.0,
                              height: 50.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 16.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .titleSmallFamily),
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
