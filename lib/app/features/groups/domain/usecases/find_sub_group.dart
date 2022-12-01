// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/groups/domain/entities/sub_group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/groups_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class FindSubGroupUseCase
    implements Usecase<SubGroupEntity, FindSubGroupParams> {
  final GroupsRepository repository;

  FindSubGroupUseCase({required this.repository});

  @override
  Future<Either<Failure, SubGroupEntity>> call(FindSubGroupParams params) {
    return repository.findSubGroup(
      subGroupId: params.subGroupId,
      groupId: params.groupId,
    );
  }
}

class FindSubGroupParams {
  final String groupId;
  final String subGroupId;
  FindSubGroupParams({
    required this.groupId,
    required this.subGroupId,
  });
}
