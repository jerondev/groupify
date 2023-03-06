import 'package:dartz/dartz.dart';
import 'package:groupify/app/features/community/domain/entities/community.dart';
import 'package:groupify/shared/error/failure.dart';

abstract class CommunityRepository {
  Future<Either<Failure, String>> create(Community community);
  Future<Either<Failure, Community>> get(String id);
  Future<Either<Failure, Stream<List<Community>>>> list(String userId);
  Future<Either<Failure, String>> delete(String communityId);
  Future<Either<Failure, String>> update(Community community);
}
