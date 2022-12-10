// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/groups/domain/entities/social_link_entity.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/group_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class DeleteSocialLinkUseCase implements Usecase<void, DeleteSocialLinkParams> {
  final GroupRepository repository;
  DeleteSocialLinkUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(DeleteSocialLinkParams params) {
    return repository.deleteSocialLink(
      groupId: params.groupId,
      socialLink: params.socialLink,
    );
  }
}

class DeleteSocialLinkParams {
  final String groupId;
  final SocialLinkEntity socialLink;
  DeleteSocialLinkParams({
    required this.groupId,
    required this.socialLink,
  });
}
