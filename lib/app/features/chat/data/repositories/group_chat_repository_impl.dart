// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:organizer_client/app/features/chat/data/database/group_chat_remote_database.dart';
import 'package:organizer_client/app/features/chat/domain/entities/group_message.dart';
import 'package:organizer_client/app/features/chat/domain/repositories/group_chat_repository.dart';
import 'package:organizer_client/shared/error/exception.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/network/network.dart';

class GroupChatRepositoryImpl implements GroupChatRepository {
  final GroupChatRemoteDatabase remoteDatabase;
  final NetworkInfo networkInfo;
  GroupChatRepositoryImpl({
    required this.remoteDatabase,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> sendGroupMessage(
      GroupMessageEntity message) async {
    try {
      // await networkInfo.hasInternet();
      await remoteDatabase.sendMessage(message);
      return const Right(unit);
    } on DeviceException {
      return const Left(Failure(
          "Couldn't send message \nConnect to the internet and try again"));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, Stream<List<GroupMessageEntity>>>> getGroupMessages(
      String groupId) async {
    try {
      // await networkInfo.hasInternet();
      final messages = remoteDatabase.getMessages(groupId);
      return Right(messages);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteGroupMessage(
      GroupMessageEntity message) async {
    try {
      await networkInfo.hasInternet();
      await remoteDatabase.deleteMessage(message);
      return const Right(unit);
    } on DeviceException {
      return const Left(Failure(
          "Couldn't delete message \nConnect to the internet and try again"));
    }
  }

  @override
  Future<Either<Failure, Unit>> editGroupMessage(
      GroupMessageEntity message) async {
    // TODO: implement editMessage
    throw UnimplementedError();
  }
}
