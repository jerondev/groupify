import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/chat/domain/entities/group_message.dart';
import 'package:organizer_client/app/features/chat/domain/repositories/group_chat_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class SendGroupMessageUseCase implements Usecase<Unit, GroupMessageEntity> {
  final GroupChatRepository repository;
  SendGroupMessageUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(GroupMessageEntity params) {
    return repository.sendGroupMessage(params);
  }
}
