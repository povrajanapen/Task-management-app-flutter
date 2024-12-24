import 'package:flutter/material.dart';
import 'package:task_management_app/models/app_color.dart';
import 'package:task_management_app/models/project_model.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/widgets/assigned_members.dart';
import 'package:task_management_app/widgets/tasks_list.dart';
import '../screens/create_task_screen.dart';

class ProjectDetails extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetails({super.key, required this.project});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  DateTime now = DateTime.now();

  bool isTaskPastDue(DateTime dueDate) {
    return dueDate.isBefore(now);
  }

  bool isTaskOnTime(DateTime dueDate) {
    return dueDate.isAfter(now);
  }

  void _navigateToCreateTask() async {
    final task = await Navigator.push<TaskModel>(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTaskScreen(
          project: widget.project,
          mode: TaskMode.create, // Ensure this is in create mode
        ),
      ),
    );

    setState(() {
      
    });
  }

  void _editTask(TaskModel task) async {
    final updatedTask = await Navigator.push<TaskModel>(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTaskScreen(
          project: widget.project,
          task: task, // Pass the task to edit
          mode: TaskMode.edit, // Set mode to edit
        ),
      ),
    );

    if (updatedTask != null) {
      // Task has been updated, find the task and update it
      setState(() {
        final index = widget.project.tasks.indexWhere((t) => t.id == task.id);
        if (index != -1) {
          widget.project.tasks[index] = updatedTask;
        }
      });
    }
  }

  void _deleteTask(TaskModel task) {
    setState(() {
      widget.project.tasks.removeWhere((t) => t.id == task.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.project.projectName,
          style: AppColors.titleStyleNormal,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Edit Project Logic (optional)
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.project.tasks.isEmpty && widget.project.assignedMembers.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Text(
                    'This project is empty. Add tasks to get started.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            if (widget.project.assignedMembers.isNotEmpty)
              AssignedMembers(assignedMemberIds: widget.project.assignedMembers),
            if (widget.project.tasks.isNotEmpty)
              Flexible(
                child: TasksList(
                  tasks: widget.project.tasks,
                  onEditTask: _editTask,
                  onDeleteTask: _deleteTask,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreateTask,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
