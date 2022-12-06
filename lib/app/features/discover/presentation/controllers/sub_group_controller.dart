// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/join_group.dart';
import 'package:share_plus/share_plus.dart';

class SubGroupController extends GetxController {
  final JoinGroupUseCase joinGroupUseCase;
  final AuthenticatedUserUseCase authenticatedUserUseCase;
  final String? groupId = Get.parameters['groupId'];
  final String? subGroupId = Get.parameters['id'];
  RxBool isLoading = false.obs;
  SubGroupController({
    required this.joinGroupUseCase,
    required this.authenticatedUserUseCase,
  });
  late GroupEntity subGroupEntity;

  void shareSubGroup() {
    Share.share(
        "Join my group on Groupify App. Group ID: ${subGroupEntity.id}");
  }
}
