import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_member_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/sub_group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/groups_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class FindJoinedGroupUseCase
    implements Usecase<List<SubGroupEntity>, GroupMemberEntity> {
  final GroupsRepository repository;
  FindJoinedGroupUseCase({required this.repository});

  @override
  Future<Either<Failure, List<SubGroupEntity>>> call(GroupMemberEntity params) {
    return repository.findJoinedGroups(params);
  }
}
