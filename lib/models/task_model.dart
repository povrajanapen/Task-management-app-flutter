import 'dart:convert';
import 'package:flutter/material.dart';

class TaskModel {
  final String id;
  final String title;
  final String projectId;
  final DateTime dueDate;
  final TimeOfDay dueTime;
  final String priority;
  String status;
  final List<int> assignedMembers;

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


  String toJsonString() {
    return jsonEncode({
      'id': id,
      'title': title,
      'projectId': projectId,
      'dueDate': dueDate.toIso8601String(), 
      'dueTime': '${dueTime.hour}:${dueTime.minute}', 
      'priority': priority,
      'status': status,
      'assignedMembers': assignedMembers,
    });
  }

  
  factory TaskModel.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return TaskModel(
      id: json['id'],
      title: json['title'],
      projectId: json['projectId'],
      dueDate: DateTime.parse(json['dueDate']), 
      dueTime: TimeOfDay(
        hour: int.parse(json['dueTime'].split(':')[0]), 
        minute: int.parse(json['dueTime'].split(':')[1]), 
      ),
      priority: json['priority'],
      status: json['status'],
      assignedMembers: List<int>.from(json['assignedMembers']),
    );
  }
}
