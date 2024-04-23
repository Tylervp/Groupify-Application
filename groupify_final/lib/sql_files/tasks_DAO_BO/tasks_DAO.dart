import 'package:groupify_final/sql_database_connection.dart';
import 'package:groupify_final/sql_files/tasks_DAO_BO/tasks_BO.dart';
import 'package:groupify_final/sql_files/members_DAO_BO/members_BO.dart';

class Tasks_DAO{
  // Initialize database connectiong helper
  final SQLDatabaseHelper _sqldatabaseHelper = SQLDatabaseHelper();

  Future<List<Task>> getTasks(projectName, projectOwnerID) async {
    await _sqldatabaseHelper.connectToDatabase();
    List<Task> tasks = [];
    final results = await _sqldatabaseHelper.connection.query('select taskName, taskDescription, taskProgress, taskDifficulty, taskAssigned, taskDueDate from Tasks where projectName = ? and ownerId = ?',
                                                            [projectName, projectOwnerID]);
    print('GOT THE TASKS');
    for(final row in results){
      String temptaskName = row['taskName'] as String;
      String temptaskDescription = row['taskDescription'] as String;
      double temptaskProgress = row['taskProgress'] as double;
      double temptaskDifficulty = row['taskDifficulty'] as double;
      String temptaskAssigned = row['taskAssigned'] as String;
      String temptaskDueDate = row['taskDueDate'] as String;

      // Get rating for each member that is assigned to the task
      List<Member> tempAssign = [];
      double rating;
      double addition;
      double temp = 0;
      var splitted = temptaskAssigned.split(',');
      for(var split in splitted){
        rating = 0;
        addition = 0;
        split = split.trim();
        final assigned = await _sqldatabaseHelper.connection.query('SELECT rating FROM userRating WHERE userID = ?;',
                                                            [split.toString()]); 
        for(final row in assigned){
          temp = row['rating'] as double;
          addition += temp;
        }
        rating = addition/assigned.length;
        tempAssign.add(Member(split.toString(), '', rating));
      }

      final results2 = await _sqldatabaseHelper.connection.query('select subTaskName from Subtasks where projectName = ? and ownerId = ? and taskName =?',
                                                            [projectName, projectOwnerID, temptaskName]);
      List<String> subtasksfortask = [];
      for (final row in results2){
        String tempsubtaskintask = row['subTaskName'] as String;
        subtasksfortask.insert(0, tempsubtaskintask);
      }
      if(subtasksfortask.isEmpty){
        bool tempsubtaskflag = false;
        double finalProgress = temptaskProgress;
        tasks.insert(0, Task(temptaskName, temptaskDescription, finalProgress, temptaskDifficulty, temptaskAssigned, temptaskDueDate, tempsubtaskflag, tempAssign));
      }
      else {
        double sum = 0;
        bool tempsubtaskflag = true;
        List<double> subtaskprogressfortask = [];
        double averagedtaskProgress;
        final results3 = await _sqldatabaseHelper.connection.query('select subTaskProgress from Subtasks where projectName = ? and ownerId = ? and taskName =?',
                                                            [projectName, projectOwnerID, temptaskName]);
        for (final row in results3){
        double tempsubtaskprogressintask = row['subTaskProgress'] as double;
        sum += tempsubtaskprogressintask;
        subtaskprogressfortask.add(tempsubtaskprogressintask);
        }
        averagedtaskProgress = sum/subtaskprogressfortask.length;
        await _sqldatabaseHelper.connection.query( 
          'UPDATE Tasks SET taskProgress = ? WHERE projectName = ? and ownerID = ? and taskName = ?;',
              [averagedtaskProgress, projectName, projectOwnerID, temptaskName]);
        tasks.insert(0, Task(temptaskName, temptaskDescription, averagedtaskProgress, temptaskDifficulty, temptaskAssigned, temptaskDueDate, tempsubtaskflag, tempAssign));
      }
    }
    //await _sqldatabaseHelper.closeConnection(); 
    return tasks;
  }

}