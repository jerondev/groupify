import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/chat/domain/repositories/chat_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class DeleteMessageUseCase implements Usecase<Unit, StringParams> {
  final ChatRepository repository;
  DeleteMessageUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(StringParams params) {
    return repository.deleteMessage(params.value);
  }
}
