import 'package:flutter/material.dart';
import 'projects_DAO.dart';
import 'package:groupify_final/sql_files/members_DAO_BO/members_BO.dart';

class Project {
  String projectName = '';
  String ownerID = '';
  String projectDescription = '';
  double projectProgress = 0;
  String projectDueDate = '';
  List<Member> projectMembers = [];

  Project(String projectName, String ownerID, String projectDescription, double projectProgress, String projectDue, List<Member> projectMembers, /*List<double> tasksProgress*/){
    this.projectName = projectName;
    this.ownerID = ownerID;
    this.projectDescription = projectDescription;
    this.projectProgress = projectProgress;
    this.projectDueDate = projectDue;
    this.projectMembers = projectMembers;
  }
}

class Projects_BO{
  final Projects_DAO _projectsDAO = Projects_DAO();

  // Create a project using the data in textfields 
  Future<void> createProject(String? projectDueDate, TextEditingController? projectNameController, TextEditingController? projectDescriptionController) async {
    await _projectsDAO.insertProject(projectDueDate, projectNameController, projectDescriptionController);
  }

  // Update the infomration of a project
  Future<void> editProject(String? pName, String? nDescription, String? nDue) async {
    await _projectsDAO.updateProject(pName, nDescription, nDue);
  } 

  // Delete all the project as well as everything associated with it (EX. tasks/subtasks, members, and etc.)
  Future<void> removeProject(String? pOwnerID, String? pName) async {
    await _projectsDAO.deleteProject(pOwnerID, pName);
  }
  
  // If not an owner, unassign current user from any tasks/subtask they were assigned to and leave the project
  Future<void> leaveProject(String? pOwnerID, String? pName) async {
    await _projectsDAO.leaveProject(pOwnerID, pName);
  }

  // Get all the projects the user is associated with along witht he project's information
  Future<List<Project>> getUserProjects() async {
    List<Project> projects = await _projectsDAO.getProjects();
    return projects;
  }
}