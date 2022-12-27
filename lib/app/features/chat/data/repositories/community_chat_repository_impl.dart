// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:organizer_client/app/features/chat/data/database/community_chat_remote_database.dart';
import 'package:organizer_client/app/features/chat/domain/entities/community_message.dart';
import 'package:organizer_client/app/features/chat/domain/repositories/community_chat_repository.dart';
import 'package:organizer_client/shared/error/exception.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/network/network.dart';

class CommunityChatRepositoryImpl implements CommunityChatRepository {
  final CommunityChatRemoteDatabase remoteDatabase;
  final NetworkInfo networkInfo;
  CommunityChatRepositoryImpl({
    required this.remoteDatabase,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> sendCommunityMessage(
      CommunityMessageEntity message) async {
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
  Future<Either<Failure, Stream<List<CommunityMessageEntity>>>>
      getCommunityMessages(String groupId) async {
    try {
      final messages = remoteDatabase.getMessages(groupId);
      return Right(messages);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    } on FirebaseException catch (e) {
      return Left(Failure(e.message!));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCommunityMessage(
      CommunityMessageEntity message) async {
    try {
      await networkInfo.hasInternet();
      await remoteDatabase.deleteMessage(message);
      return const Right(unit);
    } on DeviceException {
      return const Left(Failure(
          "Couldn't delete message \nConnect to the internet and try again"));
    }
  }
}
