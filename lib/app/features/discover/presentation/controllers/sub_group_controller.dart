// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_member_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/sub_group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_sub_group.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/join_group.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';
import 'package:share_plus/share_plus.dart';

class SubGroupController extends GetxController {
  final FindSubGroupUseCase findSubGroupUseCase;
  final FindGroupUseCase findGroupUseCase;
  final JoinGroupUseCase joinGroupUseCase;
  final AuthenticatedUserUseCase authenticatedUserUseCase;
  final String? groupId = Get.parameters['groupId'];
  final String? subGroupId = Get.parameters['id'];
  RxBool isLoading = false.obs;
  SubGroupController({
    required this.findSubGroupUseCase,
    required this.findGroupUseCase,
    required this.joinGroupUseCase,
    required this.authenticatedUserUseCase,
  });
  late SubGroupEntity subGroupEntity;

  @override
  void onInit() {
    findSubGroup();
    super.onInit();
  }

  void findSubGroup() async {
    isLoading.value = true;
    // await checkIfUserAlreadyHasGroup();
    final results = await findSubGroupUseCase.call(StringParams(subGroupId!));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      subGroupEntity = SubGroupEntity.initial();
      isLoading.value = false;
    }, (subGroup) {
      subGroupEntity = subGroup;
      isLoading.value = false;
    });
  }

  Future joinGroupWrapper() async {
    isLoading.value = true;
    final results = await authenticatedUserUseCase.call(NoParams());
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
    }, (user) {
      joinGroup(user);
    });
  }

  void joinGroup(AppUser user) async {
    final member = GroupMemberEntity(
      id: user.id,
      name: user.fullName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      profile: user.profile,
    );
    final results = await joinGroupUseCase.call(JoinGroupParams(
      subGroupId: subGroupId!,
      member: member,
    ));

    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      isLoading.value = false;
    }, (success) {
      Get.snackbar("Success", "You have joined the group");
      findSubGroup();
    });
  }

  void shareSubGroup() {
    Share.share(
        "Join my group on Groupify App. Group ID: ${subGroupEntity.id}");
  }
}
