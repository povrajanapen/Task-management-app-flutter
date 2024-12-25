import 'package:flutter/material.dart';
import 'package:task_management_app/models/app_color.dart';
import 'package:task_management_app/models/project_model.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/storage/task_storage.dart';
import 'package:task_management_app/widgets/assigned_members.dart';
import 'package:task_management_app/widgets/tasks_list.dart';
import '../screens/create_project.dart';
import '../screens/create_task_screen.dart';

class ProjectDetails extends StatefulWidget {
  ProjectModel project;

  ProjectDetails({super.key, required this.project});

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
          mode: TaskMode.create,
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
          task: task, 
          mode: TaskMode.edit, 
        ),
      ),
    );

    if (updatedTask != null) {
      setState(() {
        final index = widget.project.tasks.indexWhere((t) => t.id == updatedTask.id);
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

  void _toggleTaskCompletion(TaskModel task) {
    setState(() {
      int index = widget.project.tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        widget.project.tasks[index] = task;
      }
    });
  }


  void _navigateToEditProject() async {
    final updatedProject = await Navigator.push<ProjectModel>(
        context,
        MaterialPageRoute(
          builder: (context) => CreateProjectScreen(
            mode: ProjectMode.edit,
            project: widget.project,
            assignedMembers: widget.project.assignedMembers, 
            onProjectUpdated: (updatedProject) async {
              setState(() {
                widget.project = updatedProject; 
              });
              await TaskStorage.editProject(updatedProject);
            },
          ),
        ),
      );

      if (updatedProject != null) {
        setState(() {
          widget.project = updatedProject; 
        });
      }
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
          onPressed: _navigateToEditProject,
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
                  onToggleTaskCompletion: _toggleTaskCompletion,
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
