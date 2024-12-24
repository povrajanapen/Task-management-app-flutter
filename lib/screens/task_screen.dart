import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:task_management_app/models/project_model.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/screens/create_task_screen.dart';
import 'package:task_management_app/widgets/tasks_list.dart';
import '../models/app_color.dart';
import '../storage/task_storage.dart';

class TaskScreen extends StatefulWidget {
  final ProjectModel project;

  const TaskScreen({super.key, required this.project});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late final ProjectModel _selectedProject;
  List<TaskModel> _tasks = []; // Initialize as an empty list

  @override
  void initState() {
    super.initState();
    _selectedProject = widget.project;
    _initializeTasks(); // Load predefined and user-created tasks
  }

  // Initialize tasks with predefined dummy tasks and saved tasks
  Future<void> _initializeTasks() async {
    await TaskStorage.initializeTasks(); // Use the TaskStorage's method
    setState(() {
      _tasks = TaskStorage.getAllTasks();
    });
  }

  // Add a new task
  void _addTask(TaskModel newTask) {
    TaskStorage.addTask(newTask).then((_) {
      setState(() {
        _tasks = TaskStorage.getAllTasks();
      });
    });
  }

  // Edit an existing task
  // Edit an existing task
void _editTask(TaskModel task) async {
  final TaskModel? updatedTask = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateTaskScreen(
        project: _selectedProject, // Pass selected project
        task: task, // Pass the task to edit
        mode: TaskMode.edit, // Indicate that it's an edit mode
      ),
    ),
  );

  if (updatedTask != null) {
    TaskStorage.editTask(updatedTask).then((_) {
      setState(() {
        _tasks = TaskStorage.getAllTasks(); // Refresh tasks
      });
    });
  }
}


 void _deleteTask(TaskModel task) async {
  final bool confirm = await showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing the dialog by tapping outside
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: 50,
              ),
              const SizedBox(height: 16),
              const Text(
                'Delete Task',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Are you sure you want to delete this task?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  if (confirm) {
    TaskStorage.deleteTask(task.id).then((_) {
      setState(() {
        _tasks = TaskStorage.getAllTasks(); // Refresh tasks
      });
    });
  }
}


  // Navigate to the create task screen
  void _navigateToCreateTask() async {
    final TaskModel? newTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTaskScreen(project: _selectedProject),
      ),
    );

    if (newTask != null) {
      _addTask(newTask); // Add the new task if returned
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: DecoratedIcon(
                      icon: Icon(
                        Icons.assignment,
                        color: Color(0xffFFEB6B),
                        size: 50,
                      ),
                      decoration: IconDecoration(border: IconBorder()),
                    ),
                  ),
                  Text(
                    'Tasks',
                    style: AppColors.screenTitleStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _navigateToCreateTask,
            icon: const Icon(Icons.add, color: Colors.black, size: 30),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TasksList(
          tasks: _tasks,
          onEditTask: _editTask,
          onDeleteTask: _deleteTask,
        ),
      ),
    );
  }
}
