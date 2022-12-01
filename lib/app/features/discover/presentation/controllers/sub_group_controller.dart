// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/domain/entities/sub_group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_sub_group.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class SubGroupController extends GetxController {
  final FindSubGroupUseCase findSubGroupUseCase;
  final String? groupId = Get.parameters['groupId'];
  final String? subGroupId = Get.parameters['id'];
  RxBool isLoading = false.obs;
  SubGroupController({
    required this.findSubGroupUseCase,
    required this.findGroupUseCase,
  });
  late final SubGroupEntity subGroupEntity;
  final FindGroupUseCase findGroupUseCase;

  @override
  void onInit() {
    findSubGroup();
    super.onInit();
  }

  void findSubGroup() async {
    isLoading.value = true;
    checkIfUserAlreadyHasGroup();
    final results = await findSubGroupUseCase
        .call(FindSubGroupParams(groupId: groupId!, subGroupId: subGroupId!));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      subGroupEntity = SubGroupEntity.initial();
      isLoading.value = false;
    }, (subGroup) {
      subGroupEntity = subGroup;
      isLoading.value = false;
    });
  }

  Future<bool> checkIfUserAlreadyHasGroup() async {
    bool isMember = false;
    final results = await findGroupUseCase.call(StringParams(groupId!));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
    }, (group) {
      String subGroupId = '';
      outerLoop:
      for (var subGroup in group.subGroups) {
        subGroupId = subGroup.id;
        for (var member in subGroup.members) {
          if (member.id == FirebaseAuth.instance.currentUser!.uid) {
            isMember = true;
            break outerLoop;
          }
        }
      }

      if (isMember) {
        Get.toNamed('/sub_group/$subGroupId');
        Get.snackbar("Already has a group", "Taking you to your group");
      }
    });
    return isMember;
  }
}
