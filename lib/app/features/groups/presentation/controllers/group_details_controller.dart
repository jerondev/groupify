// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';
import 'package:organizer_client/shared/utils/copy_to_clipboard.dart';

class GroupDetailsController extends GetxController {
  final String groupId = Get.arguments['groupId'];
  final String groupName = Get.arguments['groupName'];
  RxBool isLoading = false.obs;
  RxBool errorOccurred = false.obs;

  late GroupEntity group;
  final FindGroupUseCase findGroupUseCase;
  GroupDetailsController({
    required this.findGroupUseCase,
  });

  @override
  void onInit() {
    findGroup();
    super.onInit();
  }

  void copyGroupId() {
    copyToClipboard(groupId);
    Get.snackbar("Success", "Group Id copied to clipboard");
  }

  void findGroup() async {
    isLoading.value = true;
    final results = await findGroupUseCase.call(StringParams(groupId));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      errorOccurred.value = true;
      isLoading.value = false;
    }, (success) {
      group = success;
      errorOccurred.value = false;
      isLoading.value = false;
    });
  }
}
