import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:task_management_app/models/app_color.dart';
import 'package:task_management_app/models/project_model.dart';


class ProjectDropdown extends StatefulWidget {
  final List<ProjectModel> projects;
  final Function(ProjectModel) onSelected;
  final String? selectedProjectName;

  const ProjectDropdown({
    Key? key,
    required this.projects,
    required this.onSelected,
    required this.selectedProjectName,
  }) : super(key: key);

  @override
  _ProjectDropdownState createState() => _ProjectDropdownState();
}

class _ProjectDropdownState extends State<ProjectDropdown> {
  String? _selectedProjectName;

  @override
  void initState() {
    super.initState();
    _selectedProjectName = widget.selectedProjectName;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedProjectName,
      decoration: InputDecoration(
        labelText: "Project",
        labelStyle: AppColors.defaultStyleTitle,
        suffixIcon: const DecoratedIcon(
          icon: Icon(Icons.category, color: Color(0xffFFEB6B), size: 30,),
          decoration: IconDecoration(border: IconBorder()),
        ),
      ),
      items: widget.projects.map((project) {
        return DropdownMenuItem<String>(
          value: project.projectName, 
          child: Row(
            children: [
              // Display project color as an indicator
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: project.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(project.projectName),
            ],
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedProjectName = newValue;
        });
        if (newValue != null) {
          final selectedProject = widget.projects.firstWhere(
            (project) => project.projectName == newValue,
          );
          widget.onSelected(selectedProject);
        }
      },
    );
  }
}
