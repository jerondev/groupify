import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/shared/enums/id.dart';
import 'package:organizer_client/shared/error/failure.dart';

abstract class GroupRepository {
  Future<Either<Failure, GroupEntity>> findGroup(String groupId);
  Future<Either<Failure, void>> joinGroup({
    required String groupId,
    required String userId,
  });
  Future<Either<Failure, Stream<List<GroupEntity>>>> findJoinedGroups(
      String userId);
  Future<Either<Failure, List<GroupEntity>>> findGroups(String communityId);
  Future<Either<Failure, bool>> isMember({
    required IdType idType,
    required String id,
    required String userId,
  });
}
