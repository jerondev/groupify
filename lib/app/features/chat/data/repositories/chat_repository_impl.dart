// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/chat/data/database/chat_remote_database.dart';
import 'package:organizer_client/app/features/chat/domain/entities/message.dart';
import 'package:organizer_client/app/features/chat/domain/repositories/chat_repository.dart';
import 'package:organizer_client/shared/error/exception.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/network/network.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatabase remoteDatabase;
  final NetworkInfo networkInfo;
  ChatRepositoryImpl({
    required this.remoteDatabase,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> sendMessage(MessageEntity message) async {
    try {
      await networkInfo.hasInternet();
      await remoteDatabase.sendMessage(message);
      return const Right(unit);
    } on DeviceException {
      return const Left(Failure(
          "Couldn't send message \nConnect to the internet and try again"));
    }
  }

  @override
  Future<Either<Failure, Stream<List<MessageEntity>>>> getMessages(
      String groupId) async {
    try {
      await networkInfo.hasInternet();
      final messages = remoteDatabase.getMessages(groupId);
      return Right(messages);
    } on DeviceException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMessage(MessageEntity message) async {
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
