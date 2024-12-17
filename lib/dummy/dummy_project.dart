import '../models/project_model.dart';
import 'dummy_task.dart';

final List<ProjectModel> dummyProjects = [
  ProjectModel(
    projectId: 'p1',
    projectName: 'UI Redesign',
    projectCategory: 'Design',
    tasks: dummyTasks.where((task) => task.projectId == 'p1').toList(),
    assignedMembers: [1, 2, 3], 
  ),
  ProjectModel(
    projectId: 'p2',
    projectName: 'Backend API',
    projectCategory: 'Development',
    tasks: dummyTasks.where((task) => task.projectId == 'p2').toList(),
    assignedMembers: [2, 4], 
  ),
  ProjectModel(
    projectId: 'p3',
    projectName: 'Testing Suite',
    projectCategory: 'Quality Assurance',
    tasks: dummyTasks.where((task) => task.projectId == 'p3').toList(),
    assignedMembers: [3, 5],
  ),
];
