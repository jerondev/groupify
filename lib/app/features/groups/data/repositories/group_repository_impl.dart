import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:organizer_client/app/features/groups/data/database/group_remote_database.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/social_link_entity.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/group_repository.dart';
import 'package:organizer_client/shared/enums/id.dart';
import 'package:organizer_client/shared/error/exception.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/network/network.dart';

class GroupRepositoryImpl extends GroupRepository {
  final NetworkInfo networkInfo;
  final GroupRemoteDatabase remoteDatabase;
  GroupRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatabase,
  });

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
  Future<Either<Failure, Stream<List<GroupEntity>>>> findJoinedGroups(
    String userId,
  ) async {
    try {
      await networkInfo.hasInternet();
      final results = remoteDatabase.findJoinedGroups(userId);
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

  @override
  Future<Either<Failure, List<GroupEntity>>> findGroups(
      String communityId) async {
    try {
      await networkInfo.hasInternet();
      final results = await remoteDatabase.findGroups(communityId);
      return Right(results);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, SocialLinkEntity>> addSocialLink(
      {required String groupId, required SocialLinkEntity socialLink}) async {
    try {
      await networkInfo.hasInternet();
      final results = await remoteDatabase.addSocialLink(
          groupId: groupId, socialLink: socialLink);
      return Right(results);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSocialLink(
      {required String groupId, required SocialLinkEntity socialLink}) async {
    try {
      await networkInfo.hasInternet();
      final results = await remoteDatabase.deleteSocialLink(
          groupId: groupId, socialLink: socialLink);
      return Right(results);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }
}
