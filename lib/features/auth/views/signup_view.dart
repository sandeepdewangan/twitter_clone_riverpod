import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone_riverpod/features/auth/views/login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: emailControler,
                decoration: InputDecoration(hintText: "Enter email"),
              ),
              TextField(
                controller: passwordControler,
                decoration: InputDecoration(hintText: "Enter password"),
              ),
              TextButton(onPressed: () {}, child: Text("Sign up")),
              RichText(
                text: TextSpan(
                  text: "Already have account? ",
                  children: [
                    TextSpan(
                      text: "Login",
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                              );
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
