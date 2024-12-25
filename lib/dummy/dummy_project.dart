import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../models/task_model.dart';
import 'dummy_task.dart';
import 'package:collection/collection.dart';

// group tasks by project id
final Map<String, List<TaskModel>> groupedTasks = groupBy (dummyTasks, (TaskModel task) => task.projectId);

final List<ProjectModel> dummyProjects = [
  ProjectModel(
    projectId: 'p1',
    projectName: 'UI Redesign',
    // projectCategory: 'Design',
    color: const Color(0xffFFFDEC),
    tasks: groupedTasks['p1'] ?? [], // in case where project might not have any tasks under that id
    assignedMembers: groupedTasks['p1']
            ?.expand((task) => task.assignedMembers)
            .toSet() // remove duplicates
            .toList() ?? [],
  ),
  ProjectModel(
    projectId: 'p2',
    projectName: 'Backend API',
    // projectCategory: 'Development',
    color: const Color(0xffD1E9F6),
    tasks: groupedTasks['p2'] ?? [],
    assignedMembers: groupedTasks['p2']
            ?.expand((task) => task.assignedMembers)
            .toSet()
            .toList() ?? [],
  ),
  ProjectModel(
    projectId: 'p3',
    projectName: 'Testing Suite',
    color: const Color(0xffD3F1DF),
    tasks: groupedTasks['p3'] ?? [], 
    assignedMembers: groupedTasks['p3']
            ?.expand((task) => task.assignedMembers)
            .toSet()
            .toList() ?? [],
  ),
];
