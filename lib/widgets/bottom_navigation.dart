import 'package:flutter/material.dart';
import '../dummy/dummy_project.dart';
import '../models/app_color.dart';
import '../models/project_model.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/project_screen.dart';

class BottomNagivation extends StatefulWidget {
  const BottomNagivation({super.key});

  @override
  _BottomNagivationState createState() => _BottomNagivationState();
}

class _BottomNagivationState extends State<BottomNagivation> {
  int _selectedIndex = 0;
  
  final ProjectModel selectedProject = dummyProjects[0]; // Choose the first project for testing

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    // ProjectDetails(project: dummyProjects[0]),
    const ProjectScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // final book = books[index];

    return Scaffold(
        body: Container(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: 'Home',
              backgroundColor: AppColors.background,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder, size: 30,),
              label: 'Project',
              backgroundColor: AppColors.background,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30),
              label: 'Profile',
              backgroundColor: AppColors.background,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.accent,
          unselectedItemColor: Colors.grey[500],
          onTap: _onItemTapped,
          type: BottomNavigationBarType.shifting,
        ));
  }
}