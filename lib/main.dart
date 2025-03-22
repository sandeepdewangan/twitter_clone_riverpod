import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_riverpod/commons/error_page.dart';
import 'package:twitter_clone_riverpod/commons/loading_page.dart';
import 'package:twitter_clone_riverpod/features/auth/controllers/auth_controller.dart';
import 'package:twitter_clone_riverpod/features/auth/views/login_view.dart';
import 'package:twitter_clone_riverpod/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: ref
          .watch(currentUserAccountProvider)
          .when(
            data: (user) {
              // if (user != null) {
              //   // user is logged in
              //   return const HomeView();
              // }
              return const LoginView();
            },
            error: (error, _) => ErrorPage(error: error.toString()),
            loading: () => const LoadingPage(),
          ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Hello")));
  }
}
