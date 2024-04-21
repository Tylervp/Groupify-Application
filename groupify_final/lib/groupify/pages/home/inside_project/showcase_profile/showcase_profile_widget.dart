import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'showcase_profile_model.dart';
export 'showcase_profile_model.dart';

class ShowcaseProfileWidget extends StatefulWidget { // Class to represent the widget and calls its widgetState
  // Member information that is passed in to showcaseProfile bottomsheet
  final String username;
  final double? rating;
  final String? profilePicture;
  const ShowcaseProfileWidget({super.key, required this.username, this.rating, this.profilePicture});

  @override
  State<ShowcaseProfileWidget> createState() => _ShowcaseProfileWidgetState();
}

class _ShowcaseProfileWidgetState extends State<ShowcaseProfileWidget> { // Class to manage the state of the widget
  late ShowcaseProfileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() { // Build the widget and model when initialized
    super.initState();
    _model = createModel(context, () => ShowcaseProfileModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() { // Cleans up widget when not being used
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { // Main widget that displays the page
    double? tempRating = widget.rating; // Get the rating that was passed in and assign to tempRating
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
      child: Container(
        width: 305.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(0.0, 2.0),
            )
          ],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container( // Build container of bottomsheet
              height: 110.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
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
                    Container(
                      width: 65.0,
                      height: 65.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        valueOrDefault(
                        widget.profilePicture, // Show profile picture that was passed in
                        'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 210.0,
                                decoration: const BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(8.0, 3.0, 0.0, 0.0),
                                  child: Text(
                                    widget.username, // Show username that was passed in to the bottom sheet
                                    overflow: TextOverflow.ellipsis,
                                    style: FlutterFlowTheme.of(context).bodyMedium
                                        .override(
                                          fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                          fontSize: 23.0,
                                          fontWeight: FontWeight.w600,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                          child: RatingBar.builder(
                            onRatingUpdate: (newValue) => setState(
                                () => _model.ratingBarValue = newValue),
                            itemBuilder: (context, index) => Icon(
                              Icons.star_rounded,
                              color: FlutterFlowTheme.of(context).tertiary,
                            ),
                            direction: Axis.horizontal,
                            initialRating: (tempRating != null && !tempRating.isNaN) ? tempRating.truncate().toDouble() : 0,  // Show user rating or 0 if new user
                            unratedColor: FlutterFlowTheme.of(context).accent3,
                            itemCount: 5,
                            itemSize: 30.0,
                            glowColor: FlutterFlowTheme.of(context).tertiary,
                            ignoreGestures: true,
                          ),
                        ),
                      ].addToEnd(const SizedBox(height: 5.0)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
