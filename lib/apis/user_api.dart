import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone_riverpod/constants/appwrite_constants.dart';
import 'package:twitter_clone_riverpod/core/failure.dart';
import 'package:twitter_clone_riverpod/core/providers.dart';

// provider
final userApiProvider = Provider(
  (ref) => UserApi(db: ref.watch(appwriteDatabaseProvider)),
);

class UserApi {
  final Databases db;
  UserApi({required this.db});

  Future<Either<Failure, Null>> saveUserData(String email, String uid) async {
    try {
      await db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersDocumentId,
        documentId: uid,
        data: {"email": email},
      );
      return right(null);
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }

  Future<Document?> getUserData(String uid) async {
    // no need to put this into try catch block.
    // bez. the future provider will take care of errors.
    return await db.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.usersDocumentId,
      documentId: uid,
    );
  }
}
