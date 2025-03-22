import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone_riverpod/constants/appwrite_constants.dart';
import 'package:twitter_clone_riverpod/core/failure.dart';
import 'package:twitter_clone_riverpod/core/providers.dart';
import 'package:twitter_clone_riverpod/models/user_model.dart';

// provider
final userApiProvider = Provider(
  (ref) => UserApi(db: ref.watch(appwriteDatabaseProvider)),
);

class UserApi {
  final Databases db;
  UserApi({required this.db});

  Future<Either<Failure, Null>> saveUserData(String email) async {
    try {
      await db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersDocumentId,
        documentId: ID.unique(),
        data: {"email": email},
      );
      return right(null);
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }
}
