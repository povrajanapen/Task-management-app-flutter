import 'dart:ui';
import 'task_model.dart';

class ProjectModel {
  final String projectId;
  final String projectName;
  final Color color;
  final List<TaskModel> tasks;
  List<int> assignedMembers;

  ProjectModel({
    required this.projectId,
    required this.projectName,
    required this.color,
    required this.tasks,
    required this.assignedMembers
  });

}
  