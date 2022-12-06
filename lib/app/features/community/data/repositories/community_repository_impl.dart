// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/community/data/database/community_remote_database.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/repositories/community_repository.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/shared/enums/id.dart';
import 'package:organizer_client/shared/error/exception.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/network/network.dart';

class GroupsRepositoryImpl extends CommunityRepository {
  final NetworkInfo networkInfo;
  final CommunityRemoteDatabase remoteDatabase;
  GroupsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatabase,
  });
  @override
  Future<Either<Failure, String>> createCommunity({
    required CommunityEntity community,
    required List<GroupEntity> groups,
  }) async {
    try {
      await networkInfo.hasInternet();
      final communityId = await remoteDatabase.createCommunity(
          community: community, groups: groups);
      return Right(communityId);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, CommunityEntity>> findCommunity(
      String communityId) async {
    try {
      await networkInfo.hasInternet();
      final community = await remoteDatabase.findCommunity(communityId);
      return Right(community);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, GroupEntity>> findGroup(String groupId) async {
    try {
      await networkInfo.hasInternet();
      final group = await remoteDatabase.findGroup(groupId);
      return Right(group);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> joinGroup({
    required String groupId,
    required String userId,
  }) async {
    try {
      await networkInfo.hasInternet();
      final results =
          await remoteDatabase.joinGroup(groupId: groupId, userId: userId);
      return Right(results);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, List<CommunityEntity>>> findCreatedCommunities(
      String userId) async {
    try {
      await networkInfo.hasInternet();
      final results = await remoteDatabase.findCreatedCommunities(userId);
      return Right(results);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, List<GroupEntity>>> findJoinedGroups(
    String userId,
  ) async {
    try {
      await networkInfo.hasInternet();
      final results = await remoteDatabase.findJoinedGroups(userId);
      return Right(results);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, bool>> isMember(
      {required IdType idType,
      required String id,
      required String userId}) async {
    try {
      await networkInfo.hasInternet();
      final results = await remoteDatabase.isMember(
        id: id,
        idType: idType,
        userId: userId,
      );
      return Right(results);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }
}
