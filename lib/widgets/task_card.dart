import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/utils/task_utils.dart';
import '../models/app_color.dart';
import '../models/project_model.dart';
import 'assigned_members.dart';

class TaskCard extends StatelessWidget {
  final ProjectModel project;
  final String projectName;
  final List<TaskModel> tasks;

  const TaskCard({
    required this.projectName,
    required this.tasks,
    required this.project,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: project.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.black, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Name
            Text(
              projectName,
              style: AppColors.bodyStyleBold,
            ),
            const SizedBox(height: 10),

            // Task Details
            tasks.isNotEmpty
                ? Column(
                    children: tasks.map((task) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Task Title
                            Text(
                              task.title,
                              style: AppColors.bodyStyle.copyWith(
                                color: TaskUtils.getTaskStatusColor(task),
                              ),
                              overflow: TextOverflow.ellipsis, // Avoid overflow
                              maxLines: 1,
                            ),

                            // Deadline Info
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Deadline: ",
                                    style: AppColors.captionStyleBold,
                                  ),
                                  TextSpan(
                                    text:
                                        "${DateFormat('dd MMMM yyyy').format(task.dueDate)} at ${task.dueTime.format(context)}",
                                    style: AppColors.captionStyle,
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )
                : const Column(
                    children: [
                      Text(
                        "No tasks available for this project yet.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

            // Divider
            const Divider(),

            // Assigned Members Section (Show message if no members assigned)
            project.assignedMembers.isNotEmpty
                ? AssignedMembers(assignedMemberIds: project.assignedMembers)
                : const Text(
                    "No members assigned to this project yet.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
          ],
        ),
      ),
    );
  }
}
