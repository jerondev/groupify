import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/shared/error/failure.dart';

abstract class UserRepository {
  /// Sign user in with google repository
  Future<Either<Failure, void>> signInWithGoogle();
  Future<Either<Failure, void>> register(AppUser appUser);
  Future<Either<Failure, AppUser>> authenticatedUser();
  Future<Either<Failure, void>> signOut();
}
