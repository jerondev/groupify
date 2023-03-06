import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:groupify/app/features/groups/domain/repositories/group_repository.dart';
import 'package:groupify/shared/enums/id.dart';
import 'package:groupify/shared/error/failure.dart';
import 'package:groupify/shared/usecase/usecase.dart';

class IsMemberUseCase implements UseCase<bool, IsMemberParams> {
  final GroupRepository repository;

  IsMemberUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(IsMemberParams params) {
    return repository.isMember(
      idType: params.idType,
      id: params.id,
      userId: params.userId,
    );
  }
}

class IsMemberParams extends Equatable {
  final IdType idType;
  final String id;
  final String userId;

  const IsMemberParams({
    required this.idType,
    required this.id,
    required this.userId,
  });

  @override
  List<Object?> get props => [idType, id, userId];
}
