import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:task_management_app/models/app_color.dart';
import 'package:task_management_app/models/project_model.dart';
import 'package:task_management_app/models/task_model.dart';

class CreateProjectScreen extends StatefulWidget {
  final List<int> assignedMembers;
  const CreateProjectScreen({super.key, required this.assignedMembers});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final TextEditingController _nameController = TextEditingController();
  Color _selectedColor = Colors.pink[50]!;
  final List <TaskModel> _tasks = [];
  // List of color options to choose from
  final List<Color> _colorChoices = [
    Colors.pink[50]!,
    Colors.purple[50]!,
    Colors.grey[200]!,
    Colors.orange[50]!,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'New Project',
          style: AppColors.titleStyleNormal,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display selected color preview as an Icon
            if (_selectedColor != null) ...[
              const SizedBox(height: 10),
              Center(
                child: DecoratedIcon(
                  icon: Icon(
                    Icons.folder, // Example icon for the color preview
                    size: 150,
                    color: _selectedColor, // Set the icon color to white
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
                onPressed: (){
                  if(_nameController.text.isNotEmpty){
                    final newProject = ProjectModel(
                      projectId: DateTime.now().toString(),
                      projectName: _nameController.text,
                      color: _selectedColor,
                      tasks: _tasks,
                      assignedMembers: widget.assignedMembers,
                    );
              
                    Navigator.pop(context, newProject);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a project name')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textSecondary,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Colors.black, width: 0.5),
                  ),
                ),
                child: Text('Create New Project',
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