import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:task_management_app/models/app_color.dart';
import 'package:task_management_app/screens/create_project.dart';
import 'package:task_management_app/widgets/task_card.dart';
import 'package:task_management_app/models/project_model.dart';
import '../dummy/dummy_project.dart';
import '../widgets/project_details.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final List<ProjectModel> _projects = dummyProjects;  // Manage the list of projects

  // Add new project to the list
  void _addProject(ProjectModel newProject) {
    setState(() {
      _projects.add(newProject); 
    });
  }

  // Navigate to CreateProjectScreen and return the new project
  void _navigateToCreateProject() async {
    final ProjectModel? newProject = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateProjectScreen(project: null, assignedMembers: [],mode: ProjectMode.create,),
      ),
    );
    if (newProject != null) {
      _addProject(newProject);  // If a new project is created, add it
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
                    icon: Icon(Icons.folder, color: Color(0xffFFEB6B), size: 50,),
                    decoration: IconDecoration(border: IconBorder()),
                  ),
                  ),
                  Text(
                    'Your Projects',
                    style: AppColors.screenTitleStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _navigateToCreateProject,
            icon: const Icon(Icons.add, color: Colors.black, size: 30),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _projects.isEmpty
            ? const Center(
                child: Text(
                  'No projects available. Tap the + button to create a new project.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
          : ListView.builder(
          itemCount: _projects.length,  // Show all projects
          itemBuilder: (context, index) {
            final project = _projects[index];  // Get project by index
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProjectDetails(
                        project: project,
                      ),
                    ),
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
    );
  }
}
