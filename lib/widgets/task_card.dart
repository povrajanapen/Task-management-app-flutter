import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/models/task_model.dart';
import '../dummy/dummy_members.dart';
import '../models/member_model.dart';
import '../models/project_model.dart';

class TaskCard extends StatefulWidget {
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
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late List<MemberModel> assignedMembers;

  @override
  void initState() {
    super.initState();
    // Filter assigned members based on project data
    assignedMembers = dummyMembers
        .where((member) => widget.project.assignedMembers.contains(member.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Name
            Text(
              widget.projectName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),

            // Task Details
            ...widget.tasks.map((task) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Task Title
                    Text(
                      task.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis, // Avoid overflow
                      maxLines: 1, // Ensure single-line truncation
                    ),

                    // Deadline Info
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: "Deadline: ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text:
                                "${DateFormat('dd MMMM yyyy').format(task.dueDate)} at ${task.dueTime}",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            }),

            // Divider
            const Divider(),

            // Assigned Members Section
            const Text(
              'Assigned to',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Assigned Members List
            SizedBox(
              height: 60, // Constrain the height of the list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: assignedMembers.length,
                itemBuilder: (context, index) {
                  final member = assignedMembers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(member.avatarUrl),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: 50, // Constrain name width
                          child: Text(
                            member.name,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center, // Align name to center
                          ),
                        ),
                      ],
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
