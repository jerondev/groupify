// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/groups/data/database/groups_remote_database.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
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
}
