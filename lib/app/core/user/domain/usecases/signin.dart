// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:groupify/app/core/user/domain/repositories/user_repository.dart';
import 'package:groupify/shared/error/failure.dart';
import 'package:groupify/shared/usecase/usecase.dart';

class SignInUseCase implements UseCase<bool, NoParams> {
  final UserRepository repository;
  SignInUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.signInWithGoogle();
  }
}
