import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edti_project_page_model.dart';
export 'edti_project_page_model.dart';
import 'package:groupify_final/sql_files/projects_DAO_BO/projects_BO.dart';

class EdtiProjectPageWidget extends StatefulWidget { // Class to represent the widget and calls its widgetState
  // Values passed in to edit page
  final String pName;
  final String? pDescription;
  final String? pDue; 
  const EdtiProjectPageWidget({super.key, required this.pName, this.pDescription, this.pDue});

  @override
  State<EdtiProjectPageWidget> createState() => _EdtiProjectPageWidgetState();
}

class _EdtiProjectPageWidgetState extends State<EdtiProjectPageWidget> { // Class to manage the state of the widget
  late EdtiProjectPageModel _model; // Build instance of its model
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Variables to hold new edited values
  String? newDue = ''; 
  String? newDescription = '';
  final Projects_BO _projectsBO = Projects_BO(); // ProjectBO to have access to project queries

  @override
  void initState() { // Build the widget, model, and controllers when initialized
    super.initState();
    _model = createModel(context, () => EdtiProjectPageModel());

    // Intialize textControllers from model page in order to get values inside textfields
    _model.projectNameController ??= TextEditingController(text: widget.pName); // Show the previous proj. name in textfield
    _model.projectNameFocusNode ??= FocusNode();
    _model.projectDescriptionController ??= TextEditingController(text: widget.pDescription); // Show previous descr. 
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
          children: [            // Building and aligning of background 
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
            ClipRRect( // Building of the app bar
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
                                      Padding( // Display edit project
                                        padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText('lvji7nfx' /* Edit Project */,),
                                          style: FlutterFlowTheme.of(context).displayMedium
                                              .override(
                                                fontFamily: FlutterFlowTheme.of(context).displayMediumFamily,
                                                fontSize: 40.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap().containsKey(FlutterFlowTheme.of(context).displayMediumFamily),
                                              ),
                                        ),
                                      ),
                                      Padding(  // Exit icon
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
                                                onTap: () async { // Go back to home page when pressed
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
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 3.0),
                                child: Text( // Title of fist text field
                                  FFLocalizations.of(context).getText( 
                                    'bkz5cnkc' /* Project Description */,
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 20.0),
                              child: TextFormField(
                                controller: _model.projectDescriptionController, // Use projDescController to get input
                                focusNode: _model.projectDescriptionFocusNode,
                                obscureText: false,
                                onChanged: (value){
                                  newDescription = value; // Assign to newDescription variable made at the start
                                },
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context).bodyMedium,
                                  hintText: FFLocalizations.of(context).getText( // Show text if there is nothing in textfield
                                    'hpxgbpn2' /* Enter project description... */,
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
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 3.0),
                                child: Text( // Title for duedate textfield
                                  FFLocalizations.of(context).getText(
                                    'ntwq82l4' /* Due Date */,
                                  ),
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
                                  final datePickedDate = await showDatePicker( // Show date picker when textfield is pressed
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
                                        headerTextStyle: FlutterFlowTheme.of(context).headlineLarge
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: const Color(0xFF15161E),
                                              fontSize: 32.0,
                                              fontWeight: FontWeight.w600,
                                              useGoogleFonts: GoogleFonts.asMap().containsKey('Outfit'),
                                            ),
                                        pickerBackgroundColor:Colors.white,
                                        pickerForegroundColor:const Color(0xFF15161E),
                                        selectedDateTimeBackgroundColor:const Color(0xFF6F61EF),
                                        selectedDateTimeForegroundColor:Colors.white,
                                        actionButtonForegroundColor:const Color(0xFF15161E),
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
                                      final temp = DateFormat('MM/d/yyyy').format(datePickedDate); // Reformat the date
                                      newDue = temp.toString(); // Format to a string 
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
                                      child: Text( 
                                        valueOrDefault<String>(
                                          dateTimeFormat(
                                            'MMMEd',
                                            _model.datePicked,
                                            locale: FFLocalizations.of(context).languageCode,
                                          ), // If pDue is null show 'select a date' in text field. Else show the date picked
                                          (widget.pDue == null)  ? 'Select a date' : widget.pDue.toString(), 
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
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align( // Button to submit changes
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async { 
                              _projectsBO.editProject(widget.pName, newDescription, newDue); // Update the database with new info
                              context.pushNamed('HomePage'); // Go back to the home page
                            },
                            text: FFLocalizations.of(context).getText(
                              'sd8hwamc' /* Edit Project */,
                            ),
                            options: FFButtonOptions(
                              width: 130.0,
                              height: 50.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context).titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
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
