// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/repositories/user_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class UpdateUserUseCase implements Usecase<void, AppUser> {
  final UserRepository repository;
  UpdateUserUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(AppUser params) {
    return repository.update(params);
  }
}
