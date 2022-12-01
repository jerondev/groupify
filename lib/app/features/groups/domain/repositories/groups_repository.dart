import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/shared/error/failure.dart';

abstract class GroupsRepository {
  Future<Either<Failure, void>> createGroup(GroupEntity group);
}
