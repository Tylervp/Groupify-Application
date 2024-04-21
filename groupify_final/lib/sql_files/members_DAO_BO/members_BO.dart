import 'package:flutter/material.dart';
import 'members_DAO.dart';

class Member {
  String username = '';
  String profilePicture = '';
  double? rating;

  Member(String username, String profilePicture, double rating){
    this.username = username;
    this.profilePicture = profilePicture;
    this.rating = rating;
  }
}

class Members_BO{
  final Members_DAO _projectsDAO = Members_DAO();

  // Add owner as a member for the project 
  Future<void> addOwnerAsMember(TextEditingController? projectNameController,) async {
    await _projectsDAO.insertProjectMember(projectNameController);
  }

  // Get all the members involved in the project
  Future<List<Member>> getMembers(String? pOwnerID, String? pName) async {
    List<Member> members = await _projectsDAO.getProjectMembers(pOwnerID, pName);
    return members;
  }

  // Insert the members that were there when the project was finished
  Future<void> addFinalMembers(String pName, String pOwnerID) async{
    await _projectsDAO.insertFinalMembers(pName, pOwnerID);
  }

  // Get all the members associated with a project from the finalProjectMembers table 
  Future<List<Member>> getFinalMembers(String? pOwnerID, String? pName) async {
    List<Member> members = await _projectsDAO.fetchFinalMembers(pOwnerID, pName);
    return members;
  }
  // Insert ratings for each user in the project to userRating table
  Future<void> addRatings(Map<String, double> memberRatings) async {
    await _projectsDAO.insertMemberRatings(memberRatings);
  }

  // Get the rating of the user
  Future<double> getUserRating(String username) async {
    double rating = await _projectsDAO.getRating(username);
    return rating;
  }
}