import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:task_management_app/dummy/dummy_members.dart';
import 'package:task_management_app/dummy/dummy_project.dart';
import 'package:task_management_app/models/app_color.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/screens/create_project.dart';
import 'package:task_management_app/utils/task_utils.dart';
import 'package:task_management_app/widgets/taskWidget/project_dropdown.dart';
import '../models/project_model.dart';
import '../storage/task_storage.dart';

enum TaskMode { create, edit }

class CreateTaskScreen extends StatefulWidget {
  final ProjectModel project;
  final TaskModel? task; // Optional task for editing
  final TaskMode mode; // Mode to differentiate between create and edit

  const CreateTaskScreen({
    super.key,
    required this.project,
    this.task,
    this.mode = TaskMode.create,
  });

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final List<String> _selectedMembers = []; // List of selected member IDs as String
  String _selectedPriority = "Low";
  String _selectedStatus = "Not Started";
  late ProjectModel _selectedProject;
  TimeOfDay? selectedTime;
  DateTime? dueDate;

  // Initialization based on TaskMode (create or edit)
  @override
  void initState() {
    super.initState();
    _selectedProject = widget.project; // Set the selected project

    if (widget.mode == TaskMode.edit && widget.task != null) {
      // If in edit mode, populate fields with existing task data
      _titleController.text = widget.task!.title;
      _selectedPriority = widget.task!.priority;
      _selectedStatus = widget.task!.status;
      _selectedMembers.addAll(widget.task!.assignedMembers);
      dueDate = widget.task!.dueDate;
      selectedTime = widget.task!.dueTime;
      _dateController.text = "${dueDate!.year}-${dueDate!.month}-${dueDate!.day}";
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access context-dependent properties after dependencies have changed
    if (selectedTime != null) {
      _timeController.text = selectedTime!.format(context); // Ensure this is after context is available
    }
  }


  void _navigateToCreateProject() async {
    final newProject = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateProjectScreen(
          assignedMembers: _selectedMembers.map(int.parse).toList(),
        ),
      ),
    );

    if (newProject != null) {
      // Handle new project...
    }
  }

  Future<void> _createOrUpdateTask() async {
    if (_titleController.text.isNotEmpty &&
        _dateController.text.isNotEmpty &&
        _timeController.text.isNotEmpty &&
        selectedTime != null) {
      final newTask = TaskModel(
        id: widget.mode == TaskMode.edit
            ? widget.task!.id // If editing, use existing task's ID
            : DateTime.now().millisecondsSinceEpoch.toString(), // Generate new ID for new task
        title: _titleController.text,
        dueDate: dueDate!,
        dueTime: selectedTime!,
        priority: _selectedPriority,
        status: _selectedStatus,
        assignedMembers: List.from(_selectedMembers), // Ensure this is a List<String>
        projectId: _selectedProject.projectId,
      );

      if (widget.mode == TaskMode.create) {
        // Create new task
        _selectedProject.tasks.add(newTask);
        await TaskStorage.addTask(newTask);
      } else if (widget.mode == TaskMode.edit) {
        // Edit existing task
        await TaskStorage.editTask(newTask);
      }

      // Pass the new/updated task back to TaskScreen
      Navigator.pop(context, newTask);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields')),
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
          widget.mode == TaskMode.create ? 'New To-Do' : 'Edit To-Do',
          style: AppColors.titleStyleNormal,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Dropdown
              ProjectDropdown(
                projects: dummyProjects,
                selectedProjectName: _selectedProject.projectName,
                onSelected: (ProjectModel selectedProject) {
                  setState(() {
                    _selectedProject = selectedProject;
                  });
                },
              ),
              const SizedBox(height: 30),
              // Task Title Input
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  labelStyle: AppColors.defaultStyle.copyWith(fontSize: 14),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Date Picker
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  labelStyle: AppColors.defaultStyle.copyWith(fontSize: 14),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  suffixIcon: const DecoratedIcon(
                    icon: Icon(Icons.calendar_month_rounded, color: Color(0xffFFEB6B)),
                    decoration: IconDecoration(border: IconBorder()),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                readOnly: true,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text =
                          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                      dueDate = pickedDate;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              // Time Picker
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Select Time',
                  labelStyle: AppColors.defaultStyle.copyWith(fontSize: 14),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  suffixIcon: const DecoratedIcon(
                    icon: Icon(Icons.access_time_filled, color: Color(0xffFFEB6B)),
                    decoration: IconDecoration(border: IconBorder()),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                readOnly: true,
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      selectedTime = pickedTime;
                      _timeController.text = pickedTime.format(context);
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              // Priority Dropdown
              DropdownButtonFormField<String>(
                value: _selectedPriority,
                items: ["Low", "Medium", "High"]
                    .map((priority) => DropdownMenuItem(
                          value: priority,
                          child: Row(
                            children: [
                              Icon(Icons.flag, color: TaskUtils.getPriorityColor(priority)),
                              const SizedBox(width: 10),
                              Text(priority),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPriority = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Priority',
                  labelStyle: AppColors.defaultStyleTitle,
                ),
              ),
              const SizedBox(height: 16),
              // Status Dropdown
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                items: ["Not Started", "In Progress", "Completed"]
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Row(
                            children: [
                              Icon(TaskUtils.getStatusIcon(status), color: TaskUtils.getStatusColor(status)),
                              const SizedBox(width: 10),
                              Text(status),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Status',
                  labelStyle: AppColors.defaultStyleTitle,
                ),
              ),
              const SizedBox(height: 16),
              // Assigned Members (Multi-select)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Assign To',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: dummyMembers.map((member) {
                      final isSelected = _selectedMembers.contains(member.id.toString());
                      return ChoiceChip(
                        checkmarkColor: Colors.white,
                        avatar: CircleAvatar(
                          backgroundImage: AssetImage(member.avatarUrl),
                          radius: 16,
                          child: isSelected
                              ? Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.greenAccent, width: 2),
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : null,
                        ),
                        label: Text(
                          member.name,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: Colors.green[100],
                        backgroundColor: Colors.white,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedMembers.add(member.id.toString());
                            } else {
                              _selectedMembers.remove(member.id.toString());
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _createOrUpdateTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.textSecondary,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  child: Text(widget.mode == TaskMode.create ? 'Create Task' : 'Save Changes',
                  style: AppColors.bodyStyleBold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
