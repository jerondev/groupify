// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:groupify/app/features/groups/domain/entities/group_entity.dart';
import 'package:groupify/app/features/groups/domain/repositories/group_repository.dart';
import 'package:groupify/shared/error/failure.dart';
import 'package:groupify/shared/usecase/usecase.dart';

class FindGroupUseCase implements UseCase<GroupEntity, StringParams> {
  final GroupRepository repository;

  FindGroupUseCase({required this.repository});

  @override
  Future<Either<Failure, GroupEntity>> call(StringParams params) {
    return repository.findGroup(params.value);
  }
}
