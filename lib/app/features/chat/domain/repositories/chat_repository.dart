import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/chat/domain/entities/message.dart';
import 'package:organizer_client/shared/error/failure.dart';

abstract class ChatRepository {
  // Future<Either<Failure, List<MessageEntity>>> getMessages(String groupId);
  Future<Either<Failure, Stream<List<MessageEntity>>>> getMessages(
      String groupId);
  Future<Either<Failure, Unit>> sendMessage(MessageEntity message);
  Future<Either<Failure, Unit>> deleteMessage(String messageId);
}
