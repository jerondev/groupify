import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/chat/domain/entities/group_message.dart';
import 'package:organizer_client/app/features/chat/domain/repositories/group_chat_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class GetGroupMessagesUseCase
    implements Usecase<Stream<List<GroupMessageEntity>>, StringParams> {
  final GroupChatRepository repository;
  GetGroupMessagesUseCase({required this.repository});

  @override
  Future<Either<Failure, Stream<List<GroupMessageEntity>>>> call(
      StringParams params) {
    return repository.getGroupMessages(params.value);
  }
}
