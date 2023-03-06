// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:groupify/app/features/community/data/database/community_remote_database.dart';
import 'package:groupify/app/features/community/domain/entities/community.dart';
import 'package:groupify/app/features/community/domain/repositories/community_repository.dart';
import 'package:groupify/shared/error/exception.dart';
import 'package:groupify/shared/error/failure.dart';
import 'package:groupify/shared/network/network.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final NetworkInfo networkInfo;
  final CommunityRemoteDatabase remoteDatabase;
  CommunityRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatabase,
  });
  @override
  Future<Either<Failure, String>> create(Community community) async {
    try {
      await networkInfo.hasInternet();
      return Right(await remoteDatabase.create(community));
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, Community>> get(String id) async {
    try {
      await networkInfo.hasInternet();
      return Right(await remoteDatabase.get(id));
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, Stream<List<Community>>>> list(String userId) async {
    try {
      await networkInfo.hasInternet();
      final results = remoteDatabase.list(userId);
      return Right(results);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> delete(String communityId) async {
    try {
      await networkInfo.hasInternet();
      return Right(await remoteDatabase.delete(communityId));
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> update(Community community) async {
    try {
      await networkInfo.hasInternet();
      return Right(await remoteDatabase.update(community));
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }
}
