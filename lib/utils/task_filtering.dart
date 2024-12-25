import 'package:flutter/material.dart';
import 'package:task_management_app/models/project_model.dart';
import '../dummy/dummy_project.dart';

List<ProjectModel> getProjectsWithTodayTasks(DateTime now) {
  return dummyProjects
      .map((project) {
        final todayTasks = project.tasks.where((task) {
          return isSameDayWithTimeCheck(task.dueDate, task.dueTime, now);
        }).toList();

        if (todayTasks.isNotEmpty) {
          return ProjectModel(
            projectId: project.projectId,
            projectName: project.projectName,
            color: project.color,
            tasks: todayTasks,
            assignedMembers: project.assignedMembers,
          );
        }
        return null;
      })
      .whereType<ProjectModel>() 
      .toList();
}

int getTasksDueTodayCount(List<ProjectModel> projects, DateTime currentDateTime) {
  return projects
      .expand((project) => project.tasks)
      .where((task) => isSameDayWithTimeCheck(task.dueDate, task.dueTime, currentDateTime))
      .length;
}

bool isSameDayWithTimeCheck(DateTime dueDate, TimeOfDay taskDueTime, DateTime currentDateTime) {
  final taskDueDateTime = DateTime(
    dueDate.year,
    dueDate.month,
    dueDate.day,
    taskDueTime.hour,
    taskDueTime.minute,
  );

  return dueDate.year == currentDateTime.year &&
      dueDate.month == currentDateTime.month &&
      dueDate.day == currentDateTime.day &&
      taskDueDateTime.isAfter(currentDateTime);
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
