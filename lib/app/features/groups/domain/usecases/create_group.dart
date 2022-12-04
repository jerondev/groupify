import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/groups_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class CreateGroupUseCase implements Usecase<String, GroupEntity> {
  final GroupsRepository repository;
  CreateGroupUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(GroupEntity params) {
    return repository.createGroup(params);
  }
}
