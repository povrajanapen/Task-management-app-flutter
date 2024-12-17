import 'package:flutter/material.dart';
import 'package:task_management_app/widgets/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: '/home',
      // routes: {
      //   // '/login': (context) => LoginScreen(),
      //   '/home': (context) => HomeScreen(),
      //   // '/signup': (context) => SignupScreen(),
      // },
      home: Scaffold(
        body: BottomNagivation(),
      ),
    );
  }
}

