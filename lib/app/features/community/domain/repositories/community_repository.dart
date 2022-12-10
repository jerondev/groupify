import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/shared/error/failure.dart';

abstract class CommunityRepository {
  Future<Either<Failure, String>> createCommunity({
    required CommunityEntity community,
    required List<GroupEntity> groups,
  });
  Future<Either<Failure, CommunityEntity>> findCommunity(String communityId);
  Future<Either<Failure, List<CommunityEntity>>> findCreatedCommunities(
    String userId,
  );
  Future<Either<Failure, String>> deleteCommunity(String communityId);
  Future<Either<Failure, void>> updateCommunity(CommunityEntity community);
}
