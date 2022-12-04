import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_created_groups.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class GroupsController extends GetxController {
  RxBool isEmpty = true.obs;
  RxBool isLoading = false.obs;
  final FindCreatedGroupsUseCase findCreatedGroupsUseCase;
  late final List<GroupEntity> groups;
  GroupsController({required this.findCreatedGroupsUseCase});

  @override
  void onInit() {
    findCreatedGroups();
    super.onInit();
  }

  Future<void> findCreatedGroups() async {
    isLoading.value = true;
    final result = await findCreatedGroupsUseCase.call(
      StringParams(FirebaseAuth.instance.currentUser!.uid),
    );
    result.fold((failure) {
      showErrorSnackbar(message: failure.message);
    }, (success) {
      groups = success;
      isEmpty.value = success.isEmpty;
    });
    isLoading.value = false;
  }
}
