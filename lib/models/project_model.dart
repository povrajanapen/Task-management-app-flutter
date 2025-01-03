import 'dart:ui';
import 'dart:convert';
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
    required this.assignedMembers,
  });

  
  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'projectName': projectName,
      'color': color.value, 
      'tasks': tasks.map((task) => task.toJsonString()).toList(),
      'assignedMembers': assignedMembers,
    };
  }

  
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectId: json['projectId'],
      projectName: json['projectName'],
      color: Color(json['color']), 
      tasks: (json['tasks'] as List<dynamic>)
          .map((taskJson) => TaskModel.fromJsonString(taskJson))
          .toList(),
      assignedMembers: List<int>.from(json['assignedMembers']),
    );
  }

  
  String toJsonString() {
    return jsonEncode(toJson());
  }

  // Create a ProjectModel from a JSON string
  factory ProjectModel.fromJsonString(String jsonString) {
    return ProjectModel.fromJson(jsonDecode(jsonString));
  }
}
