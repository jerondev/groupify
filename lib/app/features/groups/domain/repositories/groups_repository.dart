import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_member_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/sub_group_entity.dart';
import 'package:organizer_client/shared/error/failure.dart';

abstract class GroupsRepository {
  Future<Either<Failure, void>> createGroup(GroupEntity group);
  Future<Either<Failure, GroupEntity>> findGroup(String groupId);
  Future<Either<Failure, SubGroupEntity>> findSubGroup(String subGroupId);
  Future<Either<Failure, void>> joinGroup({
    required String subGroupId,
    required GroupMemberEntity member,
  });
  Future<Either<Failure, List<GroupEntity>>> findCreatedGroups(String userId);
  Future<Either<Failure, List<SubGroupEntity>>> findJoinedGroups(
      GroupMemberEntity member);
}
