// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:organizer_client/app/core/user/data/database/user_local_database.dart';
import 'package:organizer_client/app/core/user/data/database/user_remote_database.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/repositories/user_repository.dart';
import 'package:organizer_client/shared/error/exception.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/network/network.dart';

class UserRepositoryImpl extends UserRepository {
  final NetworkInfo networkInfo;
  final UserRemoteDatabase userRemoteDatabase;
  final UserLocalDatabase userLocalDatabase;
  UserRepositoryImpl({
    required this.networkInfo,
    required this.userRemoteDatabase,
    required this.userLocalDatabase,
  });

  @override
  Future<Either<Failure, void>> signInWithGoogle() async {
    try {
      await networkInfo.hasInternet();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        return const Right(null);
      } else {
        throw DeviceException("Authentication aborted by user");
      }
    } on DeviceException catch (error) {
      return Left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await networkInfo.hasInternet();
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      await userLocalDatabase.delete();
      return const Right(null);
    } on DeviceException catch (error) {
      return Left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, AppUser>> authenticatedUser() async {
    try {
      final user = await userLocalDatabase.get();
      return Right(user);
    } on DeviceException catch (error) {
      return Left(Failure(error.message));
    }
  }

  @override
  Future<Either<Failure, void>> register(AppUser appUser) async {
    try {
      await networkInfo.hasInternet();
      await userRemoteDatabase.save(appUser);
      await userLocalDatabase.save(appUser);
      return const Right(null);
    } on DeviceException catch (error) {
      return Left(Failure(error.message));
    }
  }
}
