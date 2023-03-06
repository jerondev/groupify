// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:groupify/shared/error/failure.dart';

import '../../../../../shared/usecase/usecase.dart';
import '../entities/community.dart';
import '../repositories/community_repository.dart';

class CreateCommunity implements UseCase<String, Params<Community>> {
  final CommunityRepository repository;
  CreateCommunity({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(Params<Community> params) {
    return repository.create(params.value);
  }
}
