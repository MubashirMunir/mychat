import 'package:flutter/material.dart';
import 'package:mychat/chat_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController tc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: tc,
                decoration: InputDecoration(hintText: "enter your name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // Process data
                  print('Form is valid');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        name: tc.text,
                      ),
                    ),
                  );
                }
              },
              child: Text("Enter"))
        ],
      ),
    );
  }
}
