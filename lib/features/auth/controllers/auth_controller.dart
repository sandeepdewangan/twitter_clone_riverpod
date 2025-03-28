import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone_riverpod/apis/auth_api.dart';
import 'package:twitter_clone_riverpod/apis/user_api.dart';
import 'package:twitter_clone_riverpod/core/utils.dart';
import 'package:twitter_clone_riverpod/features/auth/views/login_view.dart';
import 'package:twitter_clone_riverpod/models/user_model.dart';
import 'package:twitter_clone_riverpod/views/home_view.dart';

// provide this class to world.
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authApi: ref.watch(authApiProvider),
    userApi: ref.watch(userApiProvider),
  ),
);

// Future provider
// provide the currentUser to world.
final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

// Future provider
// provide this to get details of any user by passing uid outside using family.
final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authContoller = ref.watch(authControllerProvider.notifier);
  return authContoller.getUserData(uid);
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

class AuthController extends StateNotifier<bool> {
  // state -> isLoading
  final AuthApi authApi;
  final UserApi userApi;

  AuthController({required this.authApi, required this.userApi}) : super(false);

  // get current user account
  Future<User?> currentUser() => authApi.currentUserAccount();

  // sign up
  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await authApi.signUp(email: email, password: password);
    state = false;
    res.fold((failure) => showSnackBar(context, failure.message), (user) async {
      // on success
      // create db field of user
      final saveUserResponse = await userApi.saveUserData(email, user.$id);
      saveUserResponse.fold(
        (failure) => showSnackBar(context, failure.message),
        (success) {
          // redirect to login page
          showSnackBar(context, "Account has been created successfully...");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
          );
        },
      );
    });
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await authApi.login(email: email, password: password);
    state = false;
    res.fold((failure) => showSnackBar(context, failure.message), (user) {
      // on success, redirect to home page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    });
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await userApi.getUserData(uid);
    final user = UserModel.fromMap(document!.data);
    return user;
  }
}
