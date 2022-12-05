import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/community/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/community/domain/repositories/community_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class FindJoinedGroupsUseCase
    implements Usecase<List<GroupEntity>, StringParams> {
  final GroupsRepository repository;
  FindJoinedGroupsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<GroupEntity>>> call(StringParams params) {
    return repository.findJoinedGroups(params.value);
  }
}
