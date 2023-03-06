// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:groupify/app/features/groups/domain/repositories/group_repository.dart';
import 'package:groupify/shared/error/failure.dart';
import 'package:groupify/shared/usecase/usecase.dart';

class JoinGroupUseCase implements UseCase<void, JoinGroupParams> {
  final GroupRepository repository;
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

class JoinGroupParams extends Equatable {
  final String groupId;
  final String userId;
  const JoinGroupParams({
    required this.groupId,
    required this.userId,
  });

  @override
  List<Object?> get props => [groupId, userId];
}
