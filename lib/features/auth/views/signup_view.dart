import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_riverpod/commons/loading_page.dart';
import 'package:twitter_clone_riverpod/features/auth/controllers/auth_controller.dart';
import 'package:twitter_clone_riverpod/features/auth/views/login_view.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onSignUp() {
    ref
        .read(authControllerProvider.notifier)
        .signUp(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    // watch the state change
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
                      TextButton(onPressed: onSignUp, child: Text("Sign up")),
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
                                          builder:
                                              (context) => const LoginView(),
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
