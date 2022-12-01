// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/groups/data/database/groups_remote_database.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_member_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/sub_group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/groups_repository.dart';
import 'package:organizer_client/shared/error/exception.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/network/network.dart';

class GroupsRepositoryImpl extends GroupsRepository {
  final NetworkInfo networkInfo;
  final GroupsRemoteDatabase remoteDatabase;
  GroupsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatabase,
  });
  @override
  Future<Either<Failure, void>> createGroup(GroupEntity group) async {
    try {
      await networkInfo.hasInternet();
      await remoteDatabase.createGroup(group);
      return const Right(null);
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
  Future<Either<Failure, SubGroupEntity>> findSubGroup(
      {required String subGroupId, required String groupId}) async {
    try {
      await networkInfo.hasInternet();
      final subGroup = await remoteDatabase.findSubGroup(
          subGroupId: subGroupId, groupId: groupId);
      return Right(subGroup);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> joinGroup({
    required String subGroupId,
    required String groupId,
    required GroupMemberEntity member,
  }) async {
    try {
      await networkInfo.hasInternet();
      final results = await remoteDatabase.joinGroup(
          subGroupId: subGroupId, groupId: groupId, member: member);
      return Right(results);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }
}
