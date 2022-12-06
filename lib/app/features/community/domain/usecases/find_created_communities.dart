import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/repositories/community_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class FindCreatedCommunitiesUseCase
    implements Usecase<List<CommunityEntity>, StringParams> {
  final CommunityRepository repository;
  FindCreatedCommunitiesUseCase({required this.repository});
  @override
  Future<Either<Failure, List<CommunityEntity>>> call(StringParams params) {
    return repository.findCreatedCommunities(params.value);
  }
}
