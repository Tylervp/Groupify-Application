import 'tasks_DAO.dart';
import 'package:groupify_final/sql_files/members_DAO_BO/members_BO.dart';

class Task {
  String taskName = '';
  String taskDescription = '';
  double taskProgress = 0.0;
  double taskDifficulty = 0.0;
  String taskAssigned = '';
  String taskDueDate = '';
  bool subtaskflag = false;
  List<Member> tAssign = [];
  

  Task(String taskName, String taskDescription, double taskProgress, double taskDifficulty, String taskAssigned, String taskDueDate, bool subtaskflag,  List<Member> tAssign){
    this.taskName = taskName;
    this.taskDescription = taskDescription;
    this.taskProgress = taskProgress;
    this.taskDifficulty = taskDifficulty;
    this.taskAssigned = taskAssigned;
    this.taskDueDate = taskDueDate;
    this.subtaskflag = subtaskflag;
    this.tAssign = tAssign;
  }
}

class Tasks_BO{
  final Tasks_DAO _tasksDAO = Tasks_DAO();

    Future<List<Task>> getTasks(projectName, projectOwnerID) async {
    List<Task> tasks = await _tasksDAO.getTasks(projectName, projectOwnerID);
    return tasks;
  }

}