import 'package:flutter/material.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:groupify_final/sql_database_connection.dart';
import 'package:groupify_final/sql_files/members_DAO_BO/members_BO.dart';

class Members_DAO{
  // Initialize database connectiong helper
  final SQLDatabaseHelper _sqldatabaseHelper = SQLDatabaseHelper();

  // Insert owner into projectMembers table with information that was in textfield
  Future<void> insertProjectMember(TextEditingController? projectNameController,) async {
    await _sqldatabaseHelper.connectToDatabase();
    // Assign whats in the textfields to variables 
    final String? projectName = projectNameController?.text;
    final String userName = currentUserDisplayName;

    await _sqldatabaseHelper.connection.query(
        'INSERT INTO ProjectMembers (userID, projectName, ownerID) VALUES (?, ?, ?)',
        [userName, projectName, userName]);
    await _sqldatabaseHelper.closeConnection();
  }

  // Get all the members involved in the project
  Future<List<Member>> getProjectMembers(String? pOwnerID, String? pName) async {
    await _sqldatabaseHelper.connectToDatabase();
    List<Member> members = []; // List to hold instances of Members
    double rating; // Variable to hold rating member
    final results = await _sqldatabaseHelper.connection.query(
      'SELECT userID FROM projectMembers WHERE projectName = ? AND ownerID = ?;', [pName, pOwnerID]);
    for(final row in results){
       String tempUserName = row['userID'] as String;
       rating = await getRating(tempUserName); // call getRating functions to get the rating of the user
       members.add(Member(tempUserName, '', rating)); // Add member to list
    }
    await _sqldatabaseHelper.closeConnection();
    return members;
  }

  // Insert the members that were there when the project was finished into the finalProjectMembers table 
  Future<void> insertFinalMembers(String pName, String pOwnerID) async{
    await _sqldatabaseHelper.connectToDatabase();
    await _sqldatabaseHelper.connection.query('DELETE FROM finalProjectMembers WHERE projectName = ? and ownerID = ?;', [pName, pOwnerID]);
    await _sqldatabaseHelper.connection.query('INSERT INTO finalProjectMembers (userId, projectName, ownerId) SELECT userId, projectName, ownerId FROM projectMembers WHERE projectName = ? AND ownerID = ?;',
                                              [pName, pOwnerID]); 
    await _sqldatabaseHelper.closeConnection();     
  }

  // Get all the members associated with a project from the finalProjectMembers table 
  Future<List<Member>> fetchFinalMembers(String? pOwnerID, String? pName) async {
    List<Member> members = []; // List to hold instances of Members
    double rating; // Variable to hold rating member
    await _sqldatabaseHelper.connectToDatabase();
    final results = await _sqldatabaseHelper.connection.query(
      'SELECT userID FROM finalProjectMembers WHERE projectName = ? and ownerID = ?;', [pName, pOwnerID]); 
    for(final row in results){
      String tempUserName = row['userID'] as String;
      rating = await getRating(tempUserName); // call getRating functions to get the rating of the user
      members.add(Member(tempUserName, '', rating)); // Add member to the list
    }
    await _sqldatabaseHelper.closeConnection();
    return members;
  }

  // Insert ratings for each user in the project to userRating table
  Future<void> insertMemberRatings(Map<String, double> memberRatings) async {
    await _sqldatabaseHelper.connectToDatabase();
    for (var member in memberRatings.entries) { // Iterate through map of users 
      await _sqldatabaseHelper.connection.query('Insert userRating (userID, rating) Values (?, ?);',
                                                          [member.key, member.value]); 
    }
    await _sqldatabaseHelper.closeConnection();
  }

  // Get all the ratings for a user in the userRatings table and return the average
  Future<double> getRating(String username) async {
    await _sqldatabaseHelper.connectToDatabase();
    double rating = 0;
    double sum = 0;
    double temp = 0;
    final results = await _sqldatabaseHelper.connection.query('SELECT rating FROM userRating WHERE userID = ?;',
                                                        [username]); 
    if(results.length != 0){ // if the current user has results in userRating table 
      for(final row in results){
      temp = row['rating'] as double;
      sum += temp;
      }
      rating = sum/results.length; // average of user's ratings
    }  
    await _sqldatabaseHelper.closeConnection();                                                 
    return rating;
  }

    Future<List<Member>> getMembers(projectName, projectOwnerID) async {
    await _sqldatabaseHelper.connectToDatabase();
    List<Member> members = [];
    double rating;
    double sum;
    double temp;

    final results = await _sqldatabaseHelper.connection.query('SELECT userID FROM projectMembers WHERE projectName = ? and ownerID = ?;',
                                                          [projectName, projectOwnerID]); 
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
    await _sqldatabaseHelper.closeConnection(); 
    return members;
  }
}