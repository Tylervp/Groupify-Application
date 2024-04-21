import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_project_page_model.dart';
export 'create_project_page_model.dart';
import 'package:groupify_final/sql_files/projects_DAO_BO/projects_BO.dart';
import 'package:groupify_final/sql_files/members_DAO_BO/members_BO.dart';

class CreateProjectPageWidget extends StatefulWidget { // Class to represent the widget and calls its widgetState
  const CreateProjectPageWidget({super.key});

  @override
  State<CreateProjectPageWidget> createState() =>
      _CreateProjectPageWidgetState();
}

class _CreateProjectPageWidgetState extends State<CreateProjectPageWidget> { // Class to manage the state of the widget
  late CreateProjectPageModel _model; // Build instance of its model
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // BO instances to access database for project and member informatoin
  final Projects_BO _projectsBO = Projects_BO();
  final Members_BO _membersBO = Members_BO();
  String? pDue = ''; // variable to hold due date

  @override
  void initState() { // Build the widget, model, and controllers when initialized
    super.initState();
    _model = createModel(context, () => CreateProjectPageModel());

    // Intialize textControllers from model page in order to get values inside textfields
    _model.projectNameController ??= TextEditingController();
    _model.projectNameFocusNode ??= FocusNode();
    _model.projectDescriptionController ??= TextEditingController();
    _model.projectDescriptionFocusNode ??= FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() { // Cleans up widget when not being used
    _model.dispose();
    super.dispose();
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
        body: Stack(
          alignment: const AlignmentDirectional(1.0, 1.0),
          children: [ // Building and aligning of background
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
                child: Container( // Buidling of app bar
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: Text( // Display create project
                                          FFLocalizations.of(context).getText(
                                            'mj6ztqcc' /* Create Project */,
                                          ),
                                          style: FlutterFlowTheme.of(context).displayMedium.override(
                                                fontFamily: FlutterFlowTheme.of(context).displayMediumFamily,
                                                fontSize: 40.0,
                                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                  FlutterFlowTheme.of(context).displayMediumFamily),
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
                                                highlightColor:Colors.transparent,
                                                onTap: () async { // Go back to homepage when pressed
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
                            Align( // Title for project name textfield
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 3.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'q5re9w8p' /* Project Name */,
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 20.0),
                              child: TextFormField(
                                controller: _model.projectNameController, //ProjName controller to hold input
                                focusNode: _model.projectNameFocusNode,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context).bodySmall,
                                  hintText: FFLocalizations.of(context).getText( // Show text when nothing in textfield
                                    'v0qyv2ak' /* Enter project name... */,
                                  ),
                                  hintStyle: FlutterFlowTheme.of(context).bodySmall,
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
                                      color: FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).overlay,
                                  contentPadding: const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 24.0),
                                ),
                                style: FlutterFlowTheme.of(context).bodyMedium,
                                maxLines: null,
                                validator: _model.projectNameControllerValidator.asValidator(context),
                              ),
                            ),
                            Align( // Show title of project desscription textfield
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 3.0),
                                child: Text(
                                  FFLocalizations.of(context).getText('jvn4olit' /* Project Description */,),
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 20.0),
                              child: TextFormField(
                                controller: _model.projectDescriptionController, // ProjectDescriptionCOntroller to hold input
                                focusNode: _model.projectDescriptionFocusNode,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context).bodyMedium,
                                  hintText: FFLocalizations.of(context).getText( // If nothing in textfield show text
                                    'k7o9qywf' /* Enter project description... */,
                                  ),
                                  hintStyle: FlutterFlowTheme.of(context).bodySmall,
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
                                      color: FlutterFlowTheme.of(context).secondary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).secondary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).overlay,
                                  contentPadding: const EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 24.0),
                                ),
                                style: FlutterFlowTheme.of(context).bodyMedium,
                                maxLines: 10,
                                validator: _model.projectDescriptionControllerValidator.asValidator(context),
                              ),
                            ),
                            Align( // Show title for duedate textfield
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 3.0),
                                child: Text(
                                  FFLocalizations.of(context).getText('d102u3jx' /* Due Date */,),
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  final datePickedDate = await showDatePicker( // Show date picker when pressed
                                    context: context,
                                    initialDate: getCurrentTimestamp,
                                    firstDate: getCurrentTimestamp,
                                    lastDate: DateTime(2050),
                                    builder: (context, child) {
                                      return wrapInMaterialDatePickerTheme(
                                        context,
                                        child!,
                                        headerBackgroundColor:const Color(0xFF6F61EF),
                                        headerForegroundColor: Colors.white,
                                        headerTextStyle: FlutterFlowTheme.of(context).headlineLarge.override(
                                              fontFamily: 'Outfit',
                                              color: const Color(0xFF15161E),
                                              fontSize: 32.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts: GoogleFonts.asMap().containsKey('Outfit'),
                                            ),
                                        pickerBackgroundColor: Colors.white,
                                        pickerForegroundColor:const Color(0xFF15161E),
                                        selectedDateTimeBackgroundColor:const Color(0xFF6F61EF),
                                        selectedDateTimeForegroundColor:Colors.white,
                                        actionButtonForegroundColor:const Color(0xFF15161E),
                                        iconSize: 24.0,
                                      );
                                    },
                                  );
                                  if (datePickedDate != null) { // If date is chosen , reformat
                                    safeSetState(() {
                                      _model.datePicked = DateTime(
                                        datePickedDate.year,
                                        datePickedDate.month,
                                        datePickedDate.day,
                                      );
                                      final temp = DateFormat('MM/d/yyyy').format(datePickedDate); //Reformat date
                                      pDue = temp.toString(); // Convert to string
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
                                      padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                      child: Text(  // If no date is chosen yet, display 'Select a Date'
                                        valueOrDefault<String>(
                                          dateTimeFormat(
                                            'MMMEd',
                                            _model.datePicked,
                                            locale: FFLocalizations.of(context).languageCode,
                                          ),
                                          'Select a date',
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Urbanist',
                                              color: FlutterFlowTheme.of(context).primaryText,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align( // Create project button
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async { // Create project in db and add user as member when pressed
                              await _projectsBO.createProject(pDue, _model.projectNameController, _model.projectDescriptionController);
                              await _membersBO.addOwnerAsMember(_model.projectNameController);
                              context.pushNamed('HomePage');
                            },
                            text: FFLocalizations.of(context).getText('rtrwsvel' /* Create Project */,),
                            options: FFButtonOptions(
                              width: 130.0,
                              height: 50.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                                            FlutterFlowTheme.of(context).titleSmallFamily),
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
