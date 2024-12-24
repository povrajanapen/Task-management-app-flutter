import 'package:flutter/material.dart';
import 'package:task_management_app/models/app_color.dart';
import 'package:task_management_app/widgets/project_details.dart';
import 'package:task_management_app/widgets/task_card.dart';
import '../models/task_filtering.dart';
import '../widgets/date_selector.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
   final now = DateTime.now();
   final projectsWithTodayTasks = getProjectsWithTodayTasks(now);
   final tasksDueTodayCount = getTasksDueTodayCount(projectsWithTodayTasks, now);
  

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Hello, ",
                    style: AppColors.greetingStyle,
                  ),
                  TextSpan(
                    text: "Welcome!", 
                    style: AppColors.greetingStyleBold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Project List', 
              style: AppColors.titleStyle,
            ),
          ),
          const SizedBox(height: 10),
          const DateSelector(),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              tasksDueTodayCount > 0
                  ? "You have $tasksDueTodayCount task${tasksDueTodayCount > 1 ? 's' : ''} almost due today."
                  : "No tasks due today.",
              style: TextStyle(
              // Conditionally change the text color based on tasksDueTodayCount
              color: tasksDueTodayCount > 0
                  ? Colors.red 
                  : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            ),
          ),
          const SizedBox(height: 5),
          // The project list is expanded to fill the screen space
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: projectsWithTodayTasks.length,
              itemBuilder: (context, index) {
                final project = projectsWithTodayTasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the project details screen
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => ProjectDetails(project: project))
                      );
                    },
                    child: TaskCard(
                      projectName: project.projectName,
                      tasks: project.tasks,
                      project: project,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
