import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/utils/task_utils.dart';
import '../models/app_color.dart';
import '../storage/task_storage.dart';

class TasksList extends StatefulWidget {
  final List<TaskModel> tasks;
  final Function(TaskModel) onEditTask;
  final Function(TaskModel) onDeleteTask;
  final Function(TaskModel) onToggleTaskCompletion;

  const TasksList({
    super.key,
    required this.tasks,
    required this.onEditTask,
    required this.onDeleteTask,
    required this.onToggleTaskCompletion,
  });

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<bool> selectedTask = [];

  @override
  void initState() {
    super.initState();
    _initializeSelectedTasks();
  }

  @override
  void didUpdateWidget(covariant TasksList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tasks.length != oldWidget.tasks.length) {
      _initializeSelectedTasks();
    }
  }

  void _initializeSelectedTasks() {
    setState(() {
      selectedTask = widget.tasks.map((task) => task.status == 'Completed').toList();
    });
  }

    void _toggleTaskCompletion(int index, bool? value) {
    setState(() {
      selectedTask[index] = value ?? false;
    });

    final task = widget.tasks[index];

    
    if (selectedTask[index]) {
      task.status = "Completed";
    } else {
      task.status = "Not Started"; 
    }
    TaskStorage.editTask(task);
    widget.onToggleTaskCompletion(task);
  }
  void _editTask(TaskModel task) {
    widget.onEditTask(task);
  }

  void _deleteTask(TaskModel task) {
    widget.onDeleteTask(task);
  }

  @override
  Widget build(BuildContext context) {
    List<TaskModel> sortedTasksByDate = List.from(widget.tasks)
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

    if (selectedTask.length != sortedTasksByDate.length) {
      _initializeSelectedTasks();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'To-do',
            style: AppColors.bodyStyleBold,
          ),
        ),
        const SizedBox(height: 8),
      Expanded(
        child: ListView.builder(
          itemCount: widget.tasks.length, 
          itemBuilder: (context, index) {
            final task = widget.tasks[index]; 

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedTask[index] ? Colors.green : Colors.black,
                  width: 1,
                ),
              ),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      decoration: selectedTask[index] ? TextDecoration.lineThrough : TextDecoration.none, 
                      color: selectedTask[index] ? Colors.grey : TaskUtils.getTaskStatusColor(task),
                    ),
                  ),
                  subtitle: Text(
                    'Due: ${DateFormat('dd MMMM yyyy').format(task.dueDate)} at ${task.dueTime.format(context)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Priority
                      Icon(
                        Icons.flag,
                        color: TaskUtils.getPriorityColor(task.priority),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      // Status
                      Icon(
                        TaskUtils.getStatusIcon(task.status),
                        color: TaskUtils.getStatusColor(task.status),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      // Actions Menu
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            _editTask(task);
                          } else if (value == 'delete') {
                            _deleteTask(task);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.black),
                                SizedBox(width: 8),
                                Text('Edit', style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Delete', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                        icon: const Icon(Icons.more_vert),
                        tooltip: 'Options',
                      ),
                      const SizedBox(width: 8),
                      // Completion Checkbox
                      Checkbox(
                        value: selectedTask[index],
                        onChanged: (value) => _toggleTaskCompletion(index, value),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
      );
    }
    }