// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/repositories/user_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class AuthenticatedUserUseCase implements Usecase<AppUser, NoParams> {
  final UserRepository userRepository;
  AuthenticatedUserUseCase({
    required this.userRepository,
  });

  @override
  Future<Either<Failure, AppUser>> call(NoParams params) {
    return userRepository.authenticatedUser();
  }
}
