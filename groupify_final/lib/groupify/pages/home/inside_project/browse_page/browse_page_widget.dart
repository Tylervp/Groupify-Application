import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'browse_page_model.dart';
import 'package:groupify_final/sql_database_connection.dart';
import 'dart:async';
import '/auth/firebase_auth/auth_util.dart';

class BrowsePageWidget extends StatefulWidget {
  final String projectOwnerID;
  final String projectName;

  const BrowsePageWidget({
    super.key,
    required this.projectOwnerID,
    required this.projectName,
  });

  @override
  State<BrowsePageWidget> createState() => _BrowsePageWidgetState();
}

class _BrowsePageWidgetState extends State<BrowsePageWidget> {
  late BrowsePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  late SQLDatabaseHelper _sqldatabaseHelper;
  List<User> _users = [];
  Timer? _debounce;

  void _debounceSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _searchUsers(query);
    });
  }

  void _inviteUser(String userID) async {
    try {
      await _sqldatabaseHelper.connection.query(
        "DELETE FROM Inbox WHERE UserID = ? AND ProjectName = ? AND OwnerID = ?",
        [userID, widget.projectName, widget.projectOwnerID],
      );
      await _sqldatabaseHelper.connection.query(
        "INSERT INTO Inbox (UserID, ProjectName, OwnerID) VALUES (?, ?, ?)",
        [userID, widget.projectName, widget.projectOwnerID],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invitation Sent"),
            content: Text("$userID invited!"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to invite $userID: ${e.toString()}"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _fetchAllUsers() async {
    final results = await _sqldatabaseHelper.connection.query(
      '''
      SELECT UserClasses.UserID, GROUP_CONCAT(DISTINCT Courses.CourseTitle ORDER BY Courses.CourseTitle ASC SEPARATOR ', ') AS CourseTitles, COALESCE(AVG(UserRating.Rating), 0) AS AvgRating
      FROM UserClasses
      JOIN Courses ON UserClasses.CourseNumber = Courses.CourseNumber
      LEFT JOIN UserRating ON UserClasses.UserID = UserRating.UserID
      GROUP BY UserClasses.UserID;
      ''',
    );

    final List<User> users = results.map((map) {
      final String userID = map['UserID'] as String;
      final String courseTitles = map['CourseTitles'] as String;
      final double rating = (map['AvgRating'] ?? 0).toDouble();
      return User(userID, courseTitles, rating);
    }).toList();

    setState(() {
      _users = users;
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BrowsePageModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _sqldatabaseHelper = SQLDatabaseHelper();
    _connectToDatabase();
    _fetchAllUsers(); // Fetch all users initially
  }

  Future<void> _connectToDatabase() async {
    await _sqldatabaseHelper.connectToDatabase();
  }

  Future<void> _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        _users = [];
      });
      return;
    }

    final results = await _sqldatabaseHelper.connection.query(
      '''
      SELECT UserClasses.UserID, GROUP_CONCAT(DISTINCT Courses.CourseTitle ORDER BY Courses.CourseTitle ASC SEPARATOR ', ') AS CourseTitles, COALESCE(AVG(UserRating.Rating), 0) AS AvgRating
      FROM UserClasses
      JOIN Courses ON UserClasses.CourseNumber = Courses.CourseNumber
      LEFT JOIN UserRating ON UserClasses.UserID = UserRating.UserID
      WHERE UserClasses.UserID LIKE ?
      GROUP BY UserClasses.UserID;
      ''',
      ['%$query%'],
    );

    final List<User> users = results.map((map) {
      final String userID = map['UserID'] as String;
      final String courseTitles = map['CourseTitles'] as String;
      final double rating = map['AvgRating'] as double;
      return User(userID, courseTitles, rating);
    }).toList();

    setState(() {
      _users = users;
    });
  }

  @override
  void dispose() {
    _model.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
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
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).overlay,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(15.0, 30.0, 15.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Browse Members',
                              style: FlutterFlowTheme.of(context).displayMedium.override(
                                    fontFamily: FlutterFlowTheme.of(context).displayMediumFamily,
                                    fontSize: 40.0,
                                    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).displayMediumFamily),
                                  ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.close_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 35.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          controller: _searchController,
                          autofocus: true,
                          decoration: const InputDecoration(),
                          onChanged: (text) => _debounceSearch(text),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final String query = _searchController.text;
                          if (query.isEmpty) {
                            _fetchAllUsers();
                          } else {
                            _searchUsers(query);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(FlutterFlowTheme.of(context).primary),
                        ),
                        child: Text('Search'),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            itemCount: _users.length,
                            itemBuilder: (context, index) {
                              final user = _users[index];
                              return buildUserWidget(context, user.userID, user.courseTitles, user.rating);
                            },
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

  Widget buildUserWidget(BuildContext context, String userID, String courseTitles, double rating) {
  List<String> courses = courseTitles.split(', ');
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Color.fromARGB(92, 62, 59, 59),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: ExpansionTile(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://picsum.photos/seed/picsum/200/300'),
            radius: 30,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userID, style: Theme.of(context).textTheme.subtitle1),
                RatingBarIndicator(
                  rating: rating,
                  itemBuilder: (context, index) => Icon(Icons.star, color: FlutterFlowTheme.of(context).tertiary),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.person_add, color: Colors.blue),
            onPressed: () => _inviteUser(userID),
          ),
          Icon(Icons.arrow_drop_down, color: Colors.grey),
        ],
      ),
      children: courses.map((course) => ListTile(
        title: Text(course),
        visualDensity: VisualDensity.compact,
      )).toList(),
      onExpansionChanged: (bool expanded) {
        // Optionally handle expansion state changes
      },
    ),
  );
}
}
class User {
  final String userID;
  final String courseTitles;
  final double rating;

  User(this.userID, this.courseTitles, this.rating);
}