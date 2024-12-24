import 'package:flutter/material.dart';
import 'package:task_management_app/models/task_model.dart';

class TaskUtils {
  static Color getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return Colors.red[200]!;
      case "Medium":
        return Colors.deepOrange[100]!;
      case "Low":
        return Colors.green[200]!;
      default:
        return Colors.grey[300]!;
    }
  }
  

  static IconData getStatusIcon(String status) {
    switch (status) {
      case "Not Started":
        return Icons.hourglass_empty;
      case "In Progress":
        return Icons.loop;
      case "Completed":
        return Icons.check_circle;
      default:
        return Icons.help_outline;
    }
  }

  static Color getStatusColor(String status) {
    switch (status) {
      case "Not Started":
        return Colors.blue[200]!;
      case "In Progress":
        return Colors.orange[200]!;
      case "Completed":
        return Colors.green[300]!;
      default:
        return Colors.grey[100]!;
    }
  }
}

Color getTaskStatusColor(TaskModel task) {
  final currentDateTime = DateTime.now();
  final taskDueDateTime = DateTime(
    task.dueDate.year,
    task.dueDate.month,
    task.dueDate.day,
    task.dueTime.hour,
    task.dueTime.minute,
  );

  // Check if task is overdue and return color
  return (taskDueDateTime.isBefore(currentDateTime) || taskDueDateTime.isAtSameMomentAs(currentDateTime))
      ? Colors.red
      : Colors.black;
}
