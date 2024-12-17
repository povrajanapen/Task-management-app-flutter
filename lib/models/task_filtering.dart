import 'package:task_management_app/models/project_model.dart';
import 'package:task_management_app/models/task_model.dart';
import '../dummy/dummy_project.dart';

// created this for reuse purpose -- remove and add back to homescreen when no longer need

DateTime now = DateTime.now();

// filter tasks for today's date
List<ProjectModel> projectsWithTodayTasks = dummyProjects
      .map((project) {
          List<TaskModel> todayTasks = project.tasks
              .where((task) =>
                  task.dueDate.day == now.day &&
                  task.dueDate.month == now.month &&
                  task.dueDate.year == now.year)
              .toList();

          if (todayTasks.isNotEmpty) {
            return ProjectModel(
              projectId: project.projectId,
              projectName: project.projectName,
              projectCategory: project.projectCategory,
              tasks: todayTasks,
              assignedMembers: project.assignedMembers
            );
          }
          return null;
        })
        .whereType<ProjectModel>() // filter out null values
        .toList();
