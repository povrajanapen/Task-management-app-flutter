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
    projectCategory: 'Design',
    tasks: groupedTasks['p1'] ?? [], // in case where project might not have any tasks under that id
    assignedMembers: groupedTasks['p1']
            ?.expand((task) => task.assignedMembers)
            .toSet() // remove duplicates
            .map(int.parse)
            .toList() ??
        [],
  ),
  ProjectModel(
    projectId: 'p2',
    projectName: 'Backend API',
    projectCategory: 'Development',
    tasks: groupedTasks['p2'] ?? [],
    assignedMembers: groupedTasks['p2']
            ?.expand((task) => task.assignedMembers)
            .toSet()
            .map(int.parse)
            .toList() ??
        [],
  ),
  ProjectModel(
    projectId: 'p3',
    projectName: 'Testing Suite',
    projectCategory: 'Quality Assurance',
    tasks: groupedTasks['p3'] ?? [], 
    assignedMembers: groupedTasks['p3']
            ?.expand((task) => task.assignedMembers)
            .toSet()
            .map(int.parse)
            .toList() ??
        [],
  ),
];
