import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone_riverpod/core/failure.dart';
import 'package:twitter_clone_riverpod/core/providers.dart';

// provide this class to outside world
final authApiProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthApi(account: account);
});

class AuthApi {
  final Account _account;
  AuthApi({required account}) : _account = account;

  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userAccount = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      // if success return user account
      return right(userAccount);
    } on AppwriteException catch (e, st) {
      // if failure return failure message
      return left(Failure(message: e.message.toString(), stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }

  Future<Either<Failure, Session>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userSession = await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      // if success return user account
      return right(userSession);
    } on AppwriteException catch (e, st) {
      // if failure return failure message
      return left(Failure(message: e.message.toString(), stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }

  Future<User?> currentUserAccount() async {
    try {
      return await _account.get();
    } catch (e) {
      return null;
    }
  }
}
