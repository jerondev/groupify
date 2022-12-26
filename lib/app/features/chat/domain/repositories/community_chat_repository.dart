import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/chat/domain/entities/community_message.dart';
import 'package:organizer_client/shared/error/failure.dart';

abstract class CommunityChatRepository {
  Future<Either<Failure, Stream<List<CommunityMessageEntity>>>>
      getCommunityMessages(String groupId);
  Future<Either<Failure, Unit>> sendCommunityMessage(
    CommunityMessageEntity message,
  );
  Future<Either<Failure, Unit>> deleteCommunityMessage(
    CommunityMessageEntity message,
  );
}
