import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/chat/domain/entities/group_message.dart';
import 'package:organizer_client/shared/error/failure.dart';

abstract class GroupChatRepository {
  // Future<Either<Failure, List<MessageEntity>>> getMessages(String groupId);
  Future<Either<Failure, Stream<List<GroupMessageEntity>>>> getGroupMessages(
      String groupId);
  Future<Either<Failure, Unit>> sendGroupMessage(GroupMessageEntity message);
  Future<Either<Failure, Unit>> deleteGroupMessage(GroupMessageEntity message);
  Future<Either<Failure, Unit>> editGroupMessage(GroupMessageEntity message);
}
