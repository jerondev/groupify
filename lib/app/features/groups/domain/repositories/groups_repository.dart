import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_member_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/sub_group_entity.dart';
import 'package:organizer_client/shared/error/failure.dart';

abstract class GroupsRepository {
  Future<Either<Failure, void>> createGroup(GroupEntity group);
  Future<Either<Failure, GroupEntity>> findGroup(String groupId);
  Future<Either<Failure, SubGroupEntity>> findSubGroup({
    required String subGroupId,
    required String groupId,
  });
  Future<Either<Failure, void>> joinGroup({
    required String subGroupId,
    required String groupId,
    required GroupMemberEntity member,
  });
}
