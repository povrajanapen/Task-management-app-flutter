import 'package:flutter/material.dart';
 
class ScreenRegister extends StatefulWidget {
  @override
  _ScreenRegisterState createState() => _ScreenRegisterState();
}
 
class _ScreenRegisterState extends State<ScreenRegister> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                
              },
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Signup Screen
              },
              child: Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}