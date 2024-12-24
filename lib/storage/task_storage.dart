import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/dummy/dummy_task.dart';
import 'package:task_management_app/utils/task_utils.dart'; 

class TaskStorage {
  static const String _tasksKey = 'tasks';
  static List<TaskModel> _tasks = [];

   // Initialize tasks with predefined dummy tasks and saved tasks
  static Future<void> initializeTasks() async {
    await clearTasks();
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
}