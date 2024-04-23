import 'package:groupify_final/sql_database_connection.dart';
import 'package:groupify_final/sql_files/subtasks_DAO_BO/subtasks_BO.dart';
import 'package:groupify_final/sql_files/members_DAO_BO/members_BO.dart';

class Subtasks_DAO{
  // Initialize database connectiong helper
  final SQLDatabaseHelper _sqldatabaseHelper = SQLDatabaseHelper();

  Future<List<SubTask>> getSubTasks(projectName, projectOwnerID, taskName) async {
    await _sqldatabaseHelper.connectToDatabase();
    List<SubTask> subtasks = [];
    try{
    final results = await _sqldatabaseHelper.connection.query('select taskName, subTaskName, subTaskDescription, subTaskProgress, subTaskDifficulty, subTaskAssigned, subTaskDueDate from Subtasks where projectName = ? and ownerID = ? and taskName = ?;',
                                                            [projectName, projectOwnerID, taskName]);
    print('GOT THE SUBTASKS');
    for(final row in results){
      String temptaskName = row['taskName'] as String;
      String tempsubTaskName = row['subTaskName'] as String;
      String tempsubTaskDescription = row['subTaskDescription'] as String;
      double tempsubTaskProgress = row['subTaskProgress'] as double;
      double tempsubTaskDifficulty = row['subTaskDifficulty'] as double;
      String tempsubTaskAssigned = row['subTaskAssigned'] as String;
      String tempsubTaskDueDate = row['subTaskDueDate'] as String;

      // Get rating for each member that is assigned to a subtask
      List<Member> tempAssign = [];
      double rating;
      double sum;
      double temp;
      var splitted = tempsubTaskAssigned.split(',');
      for(var split in splitted){
        rating = 0;
        sum = 0;
        split = split.trim();
        final results2 = await _sqldatabaseHelper.connection.query('SELECT rating FROM userRating WHERE userID = ?;',
                                                            [split.toString()]); 
        for(final row in results2){
          temp = row['rating'] as double;
          sum += temp;
        }
        rating = sum/results2.length;
        tempAssign.add(Member(split.toString(), '', rating));
      }
      subtasks.insert(0, SubTask(temptaskName, tempsubTaskName, tempsubTaskDescription, tempsubTaskProgress, tempsubTaskDifficulty, tempsubTaskAssigned, tempsubTaskDueDate, tempAssign));
    }} catch (e)
    { print('Error fetching subtasks: $e');};
    //await _sqldatabaseHelper.closeConnection(); 
    return subtasks;
  }

}