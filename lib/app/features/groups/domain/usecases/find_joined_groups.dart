import 'package:dartz/dartz.dart';
import 'package:groupify/app/features/groups/domain/entities/group_entity.dart';
import 'package:groupify/app/features/groups/domain/repositories/group_repository.dart';
import 'package:groupify/shared/error/failure.dart';
import 'package:groupify/shared/usecase/usecase.dart';

class FindJoinedGroupsUseCase
    implements UseCase<Stream<List<GroupEntity>>, StringParams> {
  final GroupRepository repository;
  FindJoinedGroupsUseCase({required this.repository});

  @override
  Future<Either<Failure, Stream<List<GroupEntity>>>> call(StringParams params) {
    return repository.findJoinedGroups(params.value);
  }
}
