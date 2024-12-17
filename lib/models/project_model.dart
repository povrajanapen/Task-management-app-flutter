import 'task_model.dart';
import 'package:collection/collection.dart';

class ProjectModel {
  final String projectId;
  final String projectName;
  final String projectCategory;
  final List<TaskModel> tasks;
  final List<int> assignedMembers;

  ProjectModel({
    required this.projectId,
    required this.projectName,
    required this.projectCategory,
    required this.tasks,
    required this.assignedMembers
  });

  // group projects by Category
  static Map<String, List<ProjectModel>> groupProjectsByCategory(List<ProjectModel> projects) {
    return groupBy(projects, (project) => project.projectCategory);
  }
}