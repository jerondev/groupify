// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/community/domain/repositories/community_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class DeleteCommunityUseCase implements Usecase<String, StringParams> {
  final CommunityRepository repository;
  DeleteCommunityUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(StringParams params) {
    return repository.deleteCommunity(params.value);
  }
}
