import 'subtasks_DAO.dart';
import 'package:groupify_final/sql_files/members_DAO_BO/members_BO.dart';


class SubTask {
  String taskName = '';
  String subTaskName = '';
  String subTaskDescription = '';
  double subTaskProgress = 0.0;
  double subTaskDifficulty = 0.0;
  String subTaskAssigned = '';
  String subTaskDueDate = '';
  List<Member> subtAssign = [];

  SubTask(String taskName, String subTaskName, String subTaskDescription, double subTaskProgress, double subTaskDifficulty, String subTaskAssigned, String subTaskDueDate, List<Member> subtAssign){
    this.taskName = taskName;
    this.subTaskName = subTaskName;
    this.subTaskDescription = subTaskDescription;
    this.subTaskProgress = subTaskProgress;
    this.subTaskDifficulty = subTaskDifficulty;
    this.subTaskAssigned = subTaskAssigned;
    this.subTaskDueDate = subTaskDueDate;
    this.subtAssign = subtAssign;
  }
}

class Subtasks_BO{
  final Subtasks_DAO _subtasksDAO = Subtasks_DAO();

    Future<List<SubTask>> getSubTasks(projectName, projectOwnerID, taskName) async {
    List<SubTask> subtasks = await _subtasksDAO.getSubTasks(projectName, projectOwnerID, taskName);
    return subtasks;
  }

}