// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/repositories/community_repository.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class CreateCommunityUseCase implements Usecase<String, CreateCommunityParams> {
  final CommunityRepository repository;
  CreateCommunityUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(CreateCommunityParams params) {
    return repository.createCommunity(
      community: params.community,
      groups: params.groups,
    );
  }
}

class CreateCommunityParams {
  final CommunityEntity community;
  final List<GroupEntity> groups;
  CreateCommunityParams({
    required this.community,
    required this.groups,
  });
}
