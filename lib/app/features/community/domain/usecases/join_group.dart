// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/community/domain/repositories/community_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class JoinGroupUseCase implements Usecase<void, JoinGroupParams> {
  final GroupsRepository repository;
  JoinGroupUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(JoinGroupParams params) {
    return repository.joinGroup(
      groupId: params.groupId,
      userId: params.userId,
    );
  }
}

class JoinGroupParams {
  final String groupId;
  final String userId;
  JoinGroupParams({
    required this.groupId,
    required this.userId,
  });
}
