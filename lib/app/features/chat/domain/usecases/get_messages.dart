import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/chat/domain/entities/message.dart';
import 'package:organizer_client/app/features/chat/domain/repositories/chat_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class GetMessagesUseCase
    implements Usecase<Stream<List<MessageEntity>>, StringParams> {
  final ChatRepository repository;
  GetMessagesUseCase({required this.repository});

  @override
  Future<Either<Failure, Stream<List<MessageEntity>>>> call(
      StringParams params) {
    return repository.getMessages(params.value);
  }
}
