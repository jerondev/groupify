import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/groups/domain/entities/social_link_entity.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/group_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class AddSocialLinkUseCase
    implements Usecase<SocialLinkEntity, AddSocialLinkParams> {
  final GroupRepository repository;
  AddSocialLinkUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, SocialLinkEntity>> call(
      AddSocialLinkParams params) async {
    return await repository.addSocialLink(
      groupId: params.groupId,
      socialLink: params.socialLink,
    );
  }
}

class AddSocialLinkParams {
  final String groupId;
  final SocialLinkEntity socialLink;
  AddSocialLinkParams({
    required this.groupId,
    required this.socialLink,
  });
}
