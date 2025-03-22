import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone_riverpod/features/auth/views/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Enter email"),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(hintText: "Enter password"),
              ),
              TextButton(onPressed: () {}, child: Text("Login")),
              RichText(
                text: TextSpan(
                  text: "Dont have account? ",
                  children: [
                    TextSpan(
                      text: "Sign up",
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpView(),
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
