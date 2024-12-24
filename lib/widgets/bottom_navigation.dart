import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:task_management_app/screens/task_screen.dart';
import '../dummy/dummy_project.dart';
import '../models/app_color.dart';
import '../models/project_model.dart';
import '../screens/home_screen.dart';
import '../screens/project_screen.dart';

class BottomNagivation extends StatefulWidget {
  const BottomNagivation({super.key});

  @override
  _BottomNagivationState createState() => _BottomNagivationState();
}

class _BottomNagivationState extends State<BottomNagivation> {
  int _selectedIndex = 0;
  late final ProjectModel selectedProject;  // Declare it as late

  // Declare widget options without initializing them directly
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    
    selectedProject = dummyProjects[0]; // Choose the first project for testing

   
    _widgetOptions = <Widget>[
      const HomeScreen(),
      const ProjectScreen(), 
      TaskScreen(project: selectedProject),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: DecoratedIcon(
                icon: Icon(
                  Icons.home, 
                  color: _selectedIndex == 0 ? AppColors.accent: Colors.transparent,
                  size: 30,),
                decoration: const IconDecoration(border: IconBorder()),
              ),
              label: 'Home',
              backgroundColor: AppColors.background,
            ),
            BottomNavigationBarItem(
              icon: DecoratedIcon(
                icon: Icon(
                  Icons.folder,
                  color: _selectedIndex == 1 ? AppColors.accent: Colors.transparent,
                  size: 30,),
                decoration: const IconDecoration(border: IconBorder()),
              ),
              label: 'Project',
              backgroundColor: AppColors.background,
            ),
            BottomNavigationBarItem(
              icon: DecoratedIcon(
                icon: Icon(
                  Icons.task_alt_rounded,
                  color: _selectedIndex == 2 ? AppColors.accent: Colors.transparent,
                  size: 30,),
                decoration: const IconDecoration(border: IconBorder()),
              ),
              label: 'To-Dos',
              backgroundColor: AppColors.background,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.primary,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: Colors.transparent,
        ));
  }
}