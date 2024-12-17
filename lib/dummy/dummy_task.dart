import '../models/task_model.dart';

List<TaskModel> dummyTasks = [
  TaskModel(
    id: 1,
    title: 'Design UI Mockups',
    projectId: 'p1',
    dueDate: DateTime(2024, 12, 15),
    dueTime: '10:30 AM',
    priority: 'High',
    status: 'To-Do',
    assignedMembers: ['1', '2'],
  ),
  TaskModel(
    id: 2,
    title: 'Implement Login Screen',
    projectId: 'p1', 
    dueDate: DateTime(2024, 12, 16),
    dueTime: '01:00 PM',
    priority: 'Medium',
    status: 'Completed',
    assignedMembers: ['3'],
  ),
  TaskModel(
    id: 3,
    title: 'Write API Documentation',
    projectId: 'p1', 
    dueDate: DateTime(2024, 12, 17),
    dueTime: '11:00 AM',
    priority: 'Low',
    status: 'To-Do',
    assignedMembers: ['4'],
  ),
];
