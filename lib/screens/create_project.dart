import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:task_management_app/models/app_color.dart';
import 'package:task_management_app/models/project_model.dart';
import 'package:task_management_app/models/task_model.dart';

import '../storage/task_storage.dart';

enum ProjectMode{ create, edit}

class CreateProjectScreen extends StatefulWidget {
  final ProjectMode mode;
  final List<int> assignedMembers;
  final void Function(ProjectModel updatedProject)? onProjectUpdated;
  final ProjectModel? project;
  const CreateProjectScreen({super.key, required this.assignedMembers, this.mode = ProjectMode.create, this.onProjectUpdated, required this.project});  

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final TextEditingController _nameController = TextEditingController();
  Color _selectedColor = Colors.pink[50]!;
  List <TaskModel> _tasks = [];
  late List<int> _assignedMembers;
  
  // List of color options to choose from
  final List<Color> _colorChoices = [
    Colors.pink[50]!,
    Colors.purple[50]!,
    Colors.grey[200]!,
    Colors.orange[50]!,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.mode == ProjectMode.edit && widget.project != null) {
      _nameController.text = widget.project!.projectName;
      _selectedColor = widget.project!.color;
      _tasks = List.from(widget.project!.tasks);
      _assignedMembers = List.from(widget.project!.assignedMembers);
    } else {
      _selectedColor = Colors.pink[50]!;
      _tasks = [];
      _assignedMembers = [];
    }
  }

  void _saveProject() async {
    if (_nameController.text.isNotEmpty) {
      final newProject = ProjectModel(
        projectId: widget.project?.projectId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        projectName: _nameController.text,
        color: _selectedColor,
        tasks: _tasks,
        assignedMembers: _assignedMembers,
      );

      if (widget.mode == ProjectMode.create) {
        await TaskStorage.addProject(newProject);
      } else if (widget.mode == ProjectMode.edit) {
        await TaskStorage.editProject(newProject);
      }

      Navigator.pop(context, newProject); // Pass the new/updated project back
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a project name')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.mode == ProjectMode.edit ? 'Edit Project' : 'New Project',
          style: AppColors.titleStyleNormal,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon and title
            if (_selectedColor != null) ...[
              const SizedBox(height: 10),
              Center(
                child: DecoratedIcon(
                  icon: Icon(
                    Icons.folder, 
                    size: 150,
                    color: _selectedColor, 
                  ),
                  decoration: const IconDecoration(
                    border: IconBorder(width: 2),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 20),
            // project name input
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Title',
                  labelStyle: AppColors.defaultStyle.copyWith(fontSize: 14),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5), 
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0), 
                  ),
                  filled: true,
                  fillColor: Colors.white
              ),
            ),

            //color picker
            const SizedBox(height: 16,),
             Padding(
               padding: const EdgeInsets.all(4.0),
               child: Text(
                  'Color',
                  style: AppColors.bodyStyle.copyWith(fontSize: 14),
                ),
             ),
              const SizedBox(height: 10),
            // Color Circles 
            Wrap(
              spacing: 16.0, // Space between the color circles
              runSpacing: 16.0, // Space between rows
              children: _colorChoices.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  child: CircleAvatar(
                    radius: 20, 
                    backgroundColor: color,
                    child: _selectedColor == color
                        ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black, // Border color when selected
                                width: 1, // Border width
                              ),
                            ),
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 40),
            // create project button
            Center(
              child: ElevatedButton(
                onPressed: _saveProject,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textSecondary,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.black, width: 0.5),
                  ),
                ),
                child: Text(
                  widget.mode == ProjectMode.edit ? 'Update Project' : 'Create New Project',
                  style: AppColors.bodyStyleBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}