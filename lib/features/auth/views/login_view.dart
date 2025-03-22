import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_riverpod/commons/loading_page.dart';
import 'package:twitter_clone_riverpod/features/auth/controllers/auth_controller.dart';
import 'package:twitter_clone_riverpod/features/auth/views/signup_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onLogin() {
    ref
        .watch(authControllerProvider.notifier)
        .login(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body:
          isLoading
              ? LoadingPage()
              : Center(
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
                      TextButton(onPressed: onLogin, child: Text("Login")),
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
                                          builder:
                                              (context) => const SignUpView(),
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
