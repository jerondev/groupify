// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/core/user/domain/repositories/user_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class SignOutUseCase implements Usecase<void, NoParams> {
  final UserRepository repository;
  SignOutUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.signOut();
  }
}
