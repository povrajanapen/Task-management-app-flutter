import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Add Task Logic
              },
              child: const Text('Create Task'),
            ),
            // Task List Here
          ],
        ),
      ),
    );
  }
}
