import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_page_model.dart';
export 'profile_page_model.dart';
import 'package:groupify_final/sql_files/members_DAO_BO/members_BO.dart';

class ProfilePageWidget extends StatefulWidget { // Class to represent the widget and calls its widgetState
  const ProfilePageWidget({super.key});
  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> { // Class to manage the state of the widget
  late ProfilePageModel _model; // build instance of its model
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final Members_BO _membersBO = Members_BO(); // Instance of Members_BO to get access to member queries
  Future<double>? ratingFuture; // Future variable that will the rating when the query is initialized 

  @override
  void initState() { // Build the widget and model when initialized
    super.initState();
    _model = createModel(context, () => ProfilePageModel()); 
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    _initializeData(); // Initialize userRating query
  }

  @override
  void dispose() { // Cleans up widget when not being used
    _model.dispose();
    super.dispose();
  }

  void _initializeData() async {
    ratingFuture = _membersBO.getUserRating(currentUserDisplayName); // Query the rating of the user when initialized
    setState(() {}); // Trigger rebuild once data is being fetched
  }

  @override
  Widget build(BuildContext context) { // Main widget that displays the page
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold( // Build and align background of the page
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
                child: Container( // Build app bar
                  width: 558.0,
                  height: 1037.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).overlay,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
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
                                    Padding( // title of the app bar
                                      padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'cqmqqa8t' /* My Account */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .displayMedium
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(context).displayMediumFamily,
                                              fontSize: 40.0,
                                              useGoogleFonts: GoogleFonts.asMap()
                                                  .containsKey(FlutterFlowTheme.of(context).displayMediumFamily),
                                            ),
                                      ),
                                    ),
                                    Padding( // Settings icon
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
                                              highlightColor: Colors.transparent,
                                              onTap: () async { // Navigate to settings page when pressed
                                                context.pushNamed('Settings');
                                              },
                                              child: Icon(
                                                Icons.settings_rounded,
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AuthUserStreamWidget( // Show the profile picture of the current user
                                  builder: (context) => Container(
                                    width: 200.0,
                                    height: 200.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        currentUserPhoto,
                                        'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                AuthUserStreamWidget( // Show the username/ID of the current user
                                  builder: (context) => Text(
                                    currentUserDisplayName,
                                    style: FlutterFlowTheme.of(context).bodyMedium
                                        .override(
                                          fontFamily: 'Urbanist',
                                          fontSize: 35.0,
                                          useGoogleFonts: GoogleFonts.asMap().containsKey('Urbanist'),
                                        ),
                                  ),
                                ),
                                Text( // Show the email of the current user
                                  currentUserEmail, 
                                  style: FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ]
                              .divide(const SizedBox(height: 10.0))
                              .addToStart(const SizedBox(height: 20.0)),
                            ),
                          ),
                          FutureBuilder(
                            future: ratingFuture, // Get the rating for the user
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                              if(snapshot.data == null){
                                return const SizedBox();
                              }
                              else{
                                double rating = snapshot.data; // Assign the queried rating to rating variable
                                return Flexible(
                                  child: RatingBar.builder(
                                    onRatingUpdate: (newValue) => setState(
                                        () => _model.ratingBarValue = newValue),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star_rounded,
                                      color: FlutterFlowTheme.of(context).tertiary,
                                    ),
                                    direction: Axis.horizontal,
                                    initialRating: rating.truncate().toDouble(), // Display the user's rating
                                    unratedColor: FlutterFlowTheme.of(context).accent3,
                                    itemCount: 5,
                                    itemSize: 60.0,
                                    ignoreGestures: true,
                                    glowColor: FlutterFlowTheme.of(context).tertiary,
                                  ),
                                );
                              }
                            }
                          ),
                        ],
                      ),
                      Align( // Logout button
                        alignment: const AlignmentDirectional(0.0, 0.28),
                        child: FFButtonWidget(
                          onPressed: () async { // When pressed, navigate back to the login page and sign out of account
                            GoRouter.of(context).prepareAuthEvent();
                            await authManager.signOut();
                            GoRouter.of(context).clearRedirectLocation();
                            context.pushNamedAuth('LoginPage', context.mounted);
                          },
                          text: FFLocalizations.of(context).getText(
                            'oq9f1id0' /* Logout */,
                          ),
                          options: FFButtonOptions( // Button features
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
          ],
        ),
      ),
    );
  }
}
