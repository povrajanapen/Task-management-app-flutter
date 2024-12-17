import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/app_color.dart';
import '../models/project_model.dart';
import '../models/task_filtering.dart';
import '../widgets/task_card.dart';

class ProjectDetails extends StatefulWidget {
  final ProjectModel project;
  const ProjectDetails({super.key, required this.project});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  int? _selectedTaskIndex; // Track selected task index

  // Get priority color for tasks
  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red[200]!;
      case 'Medium':
        return Colors.yellow[200]!;
      case 'Low':
        return Colors.green[200]!;
      default:
        return Colors.grey[300]!;
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
        title: const Text(
          'Project Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Edit Project Logic
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project details with TaskCards
            SizedBox(
              height: 300,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                itemCount: projectsWithTodayTasks.length,
                itemBuilder: (context, index) {
                  final project = projectsWithTodayTasks[index];
                  return TaskCard(
                    projectName: project.projectName,
                    tasks: project.tasks,
                    project: project,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // To-do Tasks Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'To-do',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Add Task Logic
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Task'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.project.tasks.length,
                itemBuilder: (context, index) {
                  final task = widget.project.tasks[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedTaskIndex == index
                            ? Colors.green
                            : Colors.black,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      title: Text(
                        task.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Due: ${DateFormat('dd MMMM yyyy').format(task.dueDate)} at ${task.dueTime}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Chip(
                            label: Text(
                              task.priority,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: _getPriorityColor(task.priority),
                          ),
                          const SizedBox(width: 8),
                          Radio<int>(
                            value: index,
                            groupValue: _selectedTaskIndex,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedTaskIndex = value;
                              });
                            },
                            activeColor: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
