// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:groupify/app/core/user/domain/entities/user.dart';
import 'package:groupify/app/core/user/domain/repositories/user_repository.dart';
import 'package:groupify/shared/error/failure.dart';
import 'package:groupify/shared/usecase/usecase.dart';

class UpdateUserUseCase implements UseCase<void, AppUser> {
  final UserRepository repository;
  UpdateUserUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(AppUser params) {
    return repository.update(params);
  }
}
