import 'package:flutter/material.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:groupify_final/sql_database_connection.dart';
import 'package:groupify_final/sql_files/projects_DAO_BO/projects_BO.dart';
import 'package:groupify_final/sql_files/members_DAO_BO/members_BO.dart';

class Projects_DAO{
  // Initialize database connectiong helper
  final SQLDatabaseHelper _sqldatabaseHelper = SQLDatabaseHelper();

  // Insert project into projects table
  Future<void> insertProject(String? projectDueDate, TextEditingController? projectNameController, TextEditingController? projectDescriptionController) async {
    await _sqldatabaseHelper.connectToDatabase();
    final String? projectName = projectNameController?.text;
    final String? projectDescription = projectDescriptionController?.text;
    final String userName = currentUserDisplayName;

    await _sqldatabaseHelper.connection.query(
        'INSERT INTO Projects (projectName, ownerID, projectDescription, projectProgress, projectDueDate) VALUES (?, ?, ?, 0, ?)',
        [projectName, userName, projectDescription, projectDueDate]);
    await _sqldatabaseHelper.closeConnection();
  }

  // Update project in projects table with new information
  Future<void> updateProject(String? pName, String? nDescription, String? nDue) async {
    await _sqldatabaseHelper.connectToDatabase();
    await _sqldatabaseHelper.connection.query( 
        'UPDATE Projects SET projectDescription = ?, projectDueDate = ? WHERE projectName = ? and ownerID = ?;',
            [nDescription, nDue, pName, currentUserDisplayName]);
    await _sqldatabaseHelper.closeConnection();
  } 

  // Delete all subtask and tasks associated with the project and delete project from projects table at the end
  Future<void> deleteProject(String? pOwnerID, String? pName) async {
    await _sqldatabaseHelper.connectToDatabase();
    await _sqldatabaseHelper.connection.query(
      'DELETE FROM inbox WHERE projectName = ? and ownerID = ?;', [pName, pOwnerID]);
    await _sqldatabaseHelper.connection.query( 
      'UPDATE Subtasks SET subTaskAssigned = ? WHERE projectName = ? and ownerID = ?;',['', pName, pOwnerID]);
    await _sqldatabaseHelper.connection.query( 
      'UPDATE Tasks SET taskAssigned = ? WHERE projectName = ? and ownerID = ?;',['', pName, pOwnerID]);
    await _sqldatabaseHelper.connection.query( 
      'DELETE FROM Subtasks WHERE projectName = ? and ownerID = ?;', [pName, pOwnerID]);
    await _sqldatabaseHelper.connection.query( 
      'DELETE FROM Tasks WHERE projectName = ? and ownerID = ?;', [pName, pOwnerID]);
    await _sqldatabaseHelper.connection.query( 
      'DELETE FROM finalProjectMembers WHERE projectName = ? and ownerID = ?;', [pName, pOwnerID]); 
    await _sqldatabaseHelper.connection.query( 
      'DELETE FROM projectMembers WHERE projectName = ? and ownerID = ?;', [pName, pOwnerID]);
    await _sqldatabaseHelper.connection.query( 
      'DELETE FROM projects WHERE projectName = ? and ownerId = ?;', [pName, pOwnerID]);
    await _sqldatabaseHelper.closeConnection();
  }

  // If not an owner, unassign current user from any tasks/subtasks and leave the project
  Future<void> leaveProject(String? pOwnerID, String? pName) async {
    await _sqldatabaseHelper.connectToDatabase();
    await _sqldatabaseHelper.connection.query(
      '''UPDATE Subtasks
      SET subtaskassigned = 
        REPLACE(
          REPLACE(
            REPLACE(
              REPLACE(subtaskassigned, ', $currentUserDisplayName,', ','),
            ', $currentUserDisplayName', ''),
          '$currentUserDisplayName, ', ''),
        '$currentUserDisplayName', '')
      WHERE projectName = ? and ownerID = ?;''',
      [pName, pOwnerID]);    
    
    await _sqldatabaseHelper.connection.query(
      '''UPDATE tasks
      SET taskassigned = 
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(taskassigned, ', $currentUserDisplayName,', ','),
                ', $currentUserDisplayName', ''),
            '$currentUserDisplayName, ', ''),
        '$currentUserDisplayName', '')
      WHERE projectname = ? and ownerID = ?;''',
      [pName, pOwnerID]);

    await _sqldatabaseHelper.connection.query( 
      'DELETE FROM projectMembers WHERE userID = ? and projectName = ? and ownerID = ?;', 
      [currentUserDisplayName, pName, pOwnerID]);
    await _sqldatabaseHelper.closeConnection();
  }

  // Query projects a user is involved in, populate project list, and return it
  Future<List<Project>> getProjects() async {
    await _sqldatabaseHelper.connectToDatabase();
    final Members_BO _membersBO = Members_BO(); // MembersBO to gain access to members queries
    // Variables to hold information of a project
    List<Project> projects = [];
    List<Member> members = [];
    String tempName;
    String tempOwnerID; 
    String tempDescription;
    String tempDueDate;
    double tempProgress;

    // Variables used to calculate the new progress of a project
    List<double> tasksProgress;
    double progress;
    double projectProgress;
    double sum ;
    String temp;
    
    // Get Name, ownerID and Decription of a projects
    final results = await _sqldatabaseHelper.connection.query('select Projects.ownerID, Projects.projectName, Projects.projectDescription,Projects.projectProgress, Projects.projectDueDate from ProjectMembers JOIN Projects ON ProjectMembers.projectName = Projects.projectName and ProjectMembers.ownerID = Projects.ownerID where ProjectMembers.userID = ?;',
                                                            [currentUserDisplayName]);
    print('GOT THE PROJECTS');
    for(final row in results){ // Iterate through projects
      tempName = row['projectName'] as String;
      tempOwnerID = row['ownerID'] as String;
      tempDescription = row['projectDescription'] as String;
      tempProgress = row['projectProgress'] as double;
      tempDueDate = row['projectDueDate'] as String;
      
      // Update project's progression based on the progression of its tasks and fetch it
      sum = 0;
      tasksProgress = [];
      final results2 = await _sqldatabaseHelper.connection.query('SELECT taskProgress FROM tasks WHERE projectName = ? and ownerID = ?;',
                                                              [tempName, tempOwnerID]); // query for all task progress for a project                                             
      for(final row in results2){  // Add all the task's progress belonging to a project to a list and find the sum
        temp = row['taskProgress'].toStringAsFixed(2);
        progress = double.parse(temp);
        tasksProgress.add(progress);
        sum += progress;
      }

      if(tasksProgress.length != 0){ // If the project did have tasks
        projectProgress = sum/tasksProgress.length; // Find the average progress from tasks
        await _sqldatabaseHelper.connection.query( 
          'UPDATE projects SET projectProgress = ? WHERE projectName = ? and ownerID = ?;', 
              [projectProgress, tempName, tempOwnerID]); // Update project's progress with newly found average
        final results3 = await _sqldatabaseHelper.connection.query('select Projects.projectProgress, Projects.projectName, Projects.ownerID from ProjectMembers JOIN Projects ON ProjectMembers.projectName = Projects.projectName and ProjectMembers.ownerID = Projects.ownerID where ProjectMembers.userID = ? and ProjectMembers.ProjectName = ? and ProjectMembers.ownerID = ?;',
                                                          [currentUserDisplayName, tempName, tempOwnerID]); // Fetch new updated project progress
        tempProgress = results3.first['projectProgress'] as double;
      }
      else { // Project has no tasks
        projectProgress = 0; // project progress is zero since there is no tasks
        await _sqldatabaseHelper.connection.query( 
          'UPDATE projects SET projectProgress = ? WHERE projectName = ? and ownerID = ?;', 
              [projectProgress, tempName, tempOwnerID]); // Update project's progress with newly found average
        final results3 = await _sqldatabaseHelper.connection.query('select Projects.projectProgress, Projects.projectName, Projects.ownerID from ProjectMembers JOIN Projects ON ProjectMembers.projectName = Projects.projectName and ProjectMembers.ownerID = Projects.ownerID where ProjectMembers.userID = ? and ProjectMembers.ProjectName = ? and ProjectMembers.ownerID = ?;',
                                                          [currentUserDisplayName, tempName, tempOwnerID]); // Fetch new updated project progress
        tempProgress = results3.first['projectProgress'] as double;
      }

      // Make a list of all the members associated with the project
      members = await _membersBO.getMembers(tempOwnerID, tempName);

      // Create a project instance with values and insert it into the project list
      projects.insert(0, Project(tempName, tempOwnerID, tempDescription, tempProgress, tempDueDate, members)); 
    }
    await _sqldatabaseHelper.closeConnection();
    return projects;
  }
}