import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/chat/domain/entities/community_message.dart';
import 'package:organizer_client/app/features/chat/domain/repositories/community_chat_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class GetCommunityMessagesUseCase
    implements Usecase<Stream<List<CommunityMessageEntity>>, StringParams> {
  final CommunityChatRepository repository;
  GetCommunityMessagesUseCase({required this.repository});

  @override
  Future<Either<Failure, Stream<List<CommunityMessageEntity>>>> call(
      StringParams params) {
    return repository.getCommunityMessages(params.value);
  }
}
