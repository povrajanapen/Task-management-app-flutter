class TaskModel {
  int? id;
  final String title;
  final String projectId;
  final DateTime dueDate;
  final String dueTime;
  final String priority;
  final String status;
  final List<String> assignedMembers;

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
}