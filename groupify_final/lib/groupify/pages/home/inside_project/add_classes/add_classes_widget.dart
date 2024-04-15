import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_classes_model.dart';
export 'add_classes_model.dart';
import 'package:groupify_final/sql_database_connection.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

class AddClassesWidget extends StatefulWidget {
  const AddClassesWidget({super.key});

  @override
  State<AddClassesWidget> createState() => _AddClassesWidgetState();
}

class _AddClassesWidgetState extends State<AddClassesWidget> {
  late AddClassesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddClassesModel());
    _sqldatabaseHelper = SQLDatabaseHelper();
    _connectToDatabase();

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

   // Connect to DB
  late SQLDatabaseHelper _sqldatabaseHelper;
  Future<void> _connectToDatabase() async {
    await _sqldatabaseHelper.connectToDatabase();
  }
  
  List<String> selectedClasses = [];

  Future<void> _updateSelectedClasses(List<String>? selectedClasses) async {

   // Delete any previously selected classes for this user
  await _sqldatabaseHelper.connection.query(
    'DELETE FROM userClasses WHERE userID = ?;',
    [currentUserDisplayName],
  );

  if(selectedClasses == null) return;
  for (String className in selectedClasses) {
    String courseNumber = className.split(' - ')[0]; // Extract course number
    await _sqldatabaseHelper.connection.query('INSERT INTO userClasses (userID, courseNumber) VALUES (?,?);',
  [currentUserDisplayName, courseNumber],);
  }
   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Classes updated successfully!'),
      duration: Duration(seconds: 3),
    )
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 399.0,
            height: 129.0,
            decoration: const BoxDecoration(
              color: Color.fromARGB(0, 255, 255, 255),
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
                        'Change Classes',
                        style: FlutterFlowTheme.of(context)
                            .displayMedium
                            .override(
                              fontFamily: FlutterFlowTheme.of(context)
                                  .displayMediumFamily,
                              fontSize: 40.0,
                              useGoogleFonts: GoogleFonts
                                      .asMap()
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 5.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed('Settings');
                              },
                              child: Icon(
                                Icons.settings_rounded,
                                color: FlutterFlowTheme.of(context)
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
                            height: 600.0,
                            decoration: const BoxDecoration(),
                            child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              scrollDirection: Axis.vertical,
                              children: [
                                FlutterFlowDropDown<String>(
                                  multiSelectController: _model.dropDownValueController ??= FormFieldController<List<String>>(null),
                                 options: const [
                                  'COSC 1436 - Programming Fundamentals I',
                                  'COSC 1437 - Programming Fundamentals II',
                                  'COSC 2327 - Introduction to Computer Networks',
                                  'COSC 2329 - Computer Organization & Machine Language',
                                  'COSC 2340 - Special Topics in Computer Science',
                                  'COSC 2347 - Special Topics/Programming',
                                  'COSC 3312 - Numerical Methods',
                                  'COSC 3318 - Data Base Management Systems',
                                  'COSC 3319 - Data Structures and Algorithms',
                                  'COSC 3321 - Digital System Design',
                                  'COSC 3327 - Computer Architecture',
                                  'COSC 3331 - Human-Computer Interaction',
                                  'COSC 3332 - Game Programming and Design',
                                  'COSC 3337 - Information Systems Design & Management',
                                  'COSC 4050 - Independent Study',
                                  'COSC 4149 - Seminar in Computer Science',
                                  'COSC 4314 - Data Mining',
                                  'COSC 4316 - Compiler Design & Construction',
                                  'COSC 4318 - Advanced Language Concepts',
                                  'COSC 4319 - Software Engineering',
                                  'COSC 4320 - System Modeling and Simulation',
                                  'COSC 4326 - Network Theory',
                                  'COSC 4327 - Computer Operating Systems',
                                  'COSC 4332 - Computer Graphics',
                                  'COSC 4337 - Digital Signal Processing',
                                  'COSC 4340 - Special Topics in Computer Science',
                                  'COSC 4349 - Professionalism and Ethics',
                                ],

                                  width: 257.0,
                                  height: 56.0,
                                  searchHintTextStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                                            FlutterFlowTheme.of(context).labelMediumFamily),
                                      ),
                                  searchTextStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                  hintText: FFLocalizations.of(context).getText(
                                    't3x01gda' /* Please select... */,
                                  ),
                                  searchHintText:
                                      FFLocalizations.of(context).getText(
                                    'yxfv1aqx' /* Search for an item... */,
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  fillColor: Color.fromARGB(149, 0, 0, 0),
                                  elevation: 2.0,
                                  borderColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  borderWidth: 2.0,
                                  borderRadius: 8.0,
                                  margin: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 4.0, 16.0, 4.0),
                                  hidesUnderline: true,
                                  isOverButton: true,
                                  isSearchable: true,
                                  isMultiSelect: true,
                                  onMultiSelectChanged: (val) => setState(
                                      () => _model.dropDownValue = val),
                                ),
                                FFButtonWidget( // Start of button widget
                                  onPressed: () async {
                                    await _updateSelectedClasses(_model.dropDownValue); // Call the function to update classes
                                    // Optionally, navigate to another page or show a confirmation message
                                  },
                                  text: 'Update Classes', // Replace with FFLocalizations if using localized text
                                  options: FFButtonOptions(
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                    ),
                                    elevation: 3,
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(0, 0, 0, 0),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ), // End of button widget
                              ].divide(const SizedBox(height: 10.0)),
                            ),
                          ),
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
