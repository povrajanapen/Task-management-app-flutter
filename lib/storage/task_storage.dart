import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/dummy/dummy_task.dart';

import '../dummy/dummy_project.dart';
import '../models/project_model.dart';

class TaskStorage {
  static const String _tasksKey = 'tasks';
  static List<TaskModel> _tasks = [];

   // Initialize tasks with predefined dummy tasks and saved tasks
  static Future<void> initializeTasks() async {
    await _loadTasks();
    // Add predefined dummy tasks only if they don't already exist
    for (final dummy in dummyTasks) {
      if (!_tasks.any((task) => task.id == dummy.id)) {
        _tasks.add(dummy);
      }
    }
    _saveTasks(); // Save the combined list back to SharedPreferences
  }

  // Save tasks to SharedPreferences
  static Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskJsonList = _tasks.map((task) => task.toJsonString()).toList();
    await prefs.setStringList(_tasksKey, taskJsonList);
    print('Tasks saved successfully: $taskJsonList');
  }

  // Load tasks from SharedPreferences
  static Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskJsonList = prefs.getStringList(_tasksKey) ?? [];
    print('Raw data from SharedPreferences: $taskJsonList');

    try {
      final loadedTasks = taskJsonList
          .map((taskJson) => TaskModel.fromJsonString(taskJson))
          .toList();
      _tasks = loadedTasks; // Update the task list
      print('Tasks loaded successfully: $loadedTasks');
    } catch (e) {
      print('Error loading tasks from SharedPreferences: $e');
    }
  }

  // Fetch all tasks (no filtering by project)
  static List<TaskModel> getAllTasks() {
    return _tasks; // Return all tasks
  }

  // Fetch tasks for a specific project
  static List<TaskModel> getTasksForProject(String projectId) {
    return _tasks.where((task) => task.projectId == projectId).toList();
  }

  // Add a task only if it does not already exist
  static Future<void> addTask(TaskModel newTask) async {
  // Check if the task with the same ID already exists in the list
  bool taskExists = _tasks.any((task) => task.id == newTask.id);

  if (!taskExists) {  // Only add the task if it doesn't already exist
    _tasks.add(newTask);
    await _saveTasks(); // Save the updated list
  } 
}

// edit task
  static Future<void> editTask(TaskModel updatedTask) async {
  // Find the task index
  int index = _tasks.indexWhere((task) => task.id == updatedTask.id);

  if (index != -1) {
    // Update the task
    _tasks[index] = updatedTask;
    await _saveTasks(); // Save the updated task list
  } 
}


// delete task
static Future<void> deleteTask(String taskId) async {
  // Remove the task by ID
  _tasks.removeWhere((task) => task.id == taskId);
  await _saveTasks(); // Save the updated task list
  print('Task deleted successfully: $taskId');
}

// Mark task as completed
static Future<void> markTaskAsCompleted(String taskId) async {
  // Find the task and update its status
  int index = _tasks.indexWhere((task) => task.id == taskId);
  if (index != -1) {
    _tasks[index].status = 'Completed'; // Mark the task as completed
    await _saveTasks(); // Save the updated task list
  }
}


  // Clear all tasks (optional)
  static Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tasksKey);
    _tasks.clear();
  }


// project

  static const String _projectsKey = 'projects';
  static List<ProjectModel> _projects = [];

  // Save projects to SharedPreferences
  static Future<void> _saveProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final projectJsonList = _projects.map((project) => project.toJsonString()).toList();
    await prefs.setStringList(_projectsKey, projectJsonList);
    print('Projects saved successfully: $projectJsonList');
  }

  // Load projects from SharedPreferences
  static Future<void> _loadProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final projectJsonList = prefs.getStringList(_projectsKey) ?? [];
    print('Raw project data from SharedPreferences: $projectJsonList');

    try {
      final loadedProjects = projectJsonList
          .map((projectJson) => ProjectModel.fromJsonString(projectJson))
          .toList();
      _projects = loadedProjects; // Update the project list
      print('Projects loaded successfully: $loadedProjects');
    } catch (e) {
      print('Error loading projects from SharedPreferences: $e');
    }
  }

  // Fetch all projects
  static List<ProjectModel> getAllProjects() {
    return _projects;
  }

  // Add a project
  static Future<void> addProject(ProjectModel newProject) async {
    _projects.add(newProject);
    await _saveProjects();
  }

  // Edit a project
  static Future<void> editProject(ProjectModel updatedProject) async {
    final index = _projects.indexWhere((project) => project.projectId == updatedProject.projectId);

    if (index != -1) {
      _projects[index] = updatedProject;
      await _saveProjects();
    }
  }

  // Initialize projects (load from storage or set default)
  static Future<void> initializeProjects() async {
    await _loadProjects();
    if (_projects.isEmpty) {
      _projects = dummyProjects;
      await _saveProjects();
    }
  }

}



