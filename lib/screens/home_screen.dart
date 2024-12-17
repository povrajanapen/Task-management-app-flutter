import 'package:flutter/material.dart';
import 'package:task_management_app/models/app_color.dart';
import 'package:task_management_app/screens/project_details.dart';
import 'package:task_management_app/widgets/task_card.dart';
import '../models/task_filtering.dart';
import '../widgets/date_selector.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
   
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Hello, ",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  TextSpan(
                    text: "Jana",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.notifications_active_rounded, color: Colors.black,),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Project List', 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ),
        const SizedBox(height: 10,),
        const DateSelector(),
        const SizedBox(height: 20,),
        const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text("Today's Tasks", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        ],
        ),
        const SizedBox(height: 10,),
        Expanded(
          child: 
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: projectsWithTodayTasks.length,
            itemBuilder: (context, index){
              final project = projectsWithTodayTasks[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProjectDetails(project: project)));
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.purple[100],
        child: const Icon(Icons.add),
      ),

    );
  }
}
