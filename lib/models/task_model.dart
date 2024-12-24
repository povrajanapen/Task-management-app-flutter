import 'dart:convert';
import 'package:flutter/material.dart';

class TaskModel {
  String id;
  String title;
  String projectId;
  DateTime dueDate;
  TimeOfDay dueTime;
  String priority;
  String status;
  List<String> assignedMembers;

  TaskModel({
    required this.id,
    required this.title,
    required this.projectId,
    required this.dueDate,
    required this.dueTime,
    required this.priority,
    required this.status,
    required this.assignedMembers,
  });

  // Serialize DateTime and TimeOfDay into a JSON-compatible format
  String toJsonString() {
    return jsonEncode({
      'id': id,
      'title': title,
      'projectId': projectId,
      'dueDate': dueDate.toIso8601String(), // Convert DateTime to ISO string
      'dueTime': '${dueTime.hour}:${dueTime.minute}', // Convert TimeOfDay to string
      'priority': priority,
      'status': status,
      'assignedMembers': assignedMembers,
    });
  }

  // Deserialize JSON string back into a TaskModel object
  factory TaskModel.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return TaskModel(
      id: json['id'],
      title: json['title'],
      projectId: json['projectId'],
      dueDate: DateTime.parse(json['dueDate']), // Parse ISO string back to DateTime
      dueTime: TimeOfDay(
        hour: int.parse(json['dueTime'].split(':')[0]), // Extract hour from string
        minute: int.parse(json['dueTime'].split(':')[1]), // Extract minute from string
      ),
      priority: json['priority'],
      status: json['status'],
      assignedMembers: List<String>.from(json['assignedMembers']),
    );
  }
}
