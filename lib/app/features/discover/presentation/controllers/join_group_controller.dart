// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/join_group.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class JoinGroupController extends GetxController {
  final FindGroupUseCase findGroupUseCase;
  final JoinGroupUseCase joinGroupUseCase;
  final String? groupId = Get.parameters['id'];
  late final GroupEntity groupEntity;
  RxBool isLoading = false.obs;
  RxBool isJoining = false.obs;
  RxBool errorOccurred = false.obs;
  JoinGroupController({
    required this.findGroupUseCase,
    required this.joinGroupUseCase,
  });
  @override
  void onInit() {
    findGroup();
    super.onInit();
  }

  void findGroup() async {
    isLoading.value = true;
    final results = await findGroupUseCase.call(StringParams(groupId!));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      errorOccurred.value = true;
      isLoading.value = false;
    }, (group) {
      groupEntity = group;
      isLoading.value = false;
    });
  }

  void joinGroup() async {
    isJoining.value = true;
    final results = await joinGroupUseCase.call(JoinGroupParams(
        groupId: groupId!, userId: FirebaseAuth.instance.currentUser!.uid));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      isJoining.value = false;
    }, (_) {
      isJoining.value = false;
      Get.snackbar('Success', 'You have joined the group');
      Get.offNamedUntil(
        AppRoutes.GROUP_DETAILS,
        (route) => route.isFirst,
        arguments: groupEntity,
      );
    });
  }
}
