import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernamecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Program 3 : Login Window")),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _usernamecontroller,
              decoration: InputDecoration(
                labelText: "Enter ur User Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            TextField(
              controller: _passwordcontroller,
              decoration: InputDecoration(
                labelText: "Enter ur Password",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {},
              child: Text("Login"),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(45)),
            ),
          ],
        ),
      ),
    );
  }
}
