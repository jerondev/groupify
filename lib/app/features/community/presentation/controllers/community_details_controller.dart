import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/usecases/delete_community.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_groups.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';
import 'package:organizer_client/shared/utils/copy_to_clipboard.dart';

class CommunityDetailsController extends GetxController {
  CommunityEntity community = Get.arguments;
  String get name => community.name;
  RxString nameRx = "".obs;
  String get id => community.id;
  final FindGroupsUseCase findGroupsUseCase;
  final DeleteCommunityUseCase deleteCommunityUseCase;
  RxBool isLoading = false.obs;
  RxBool errorOccurred = false.obs;
  RxBool isDeleting = false.obs;

  late List<GroupEntity> groups;
  CommunityDetailsController({
    required this.findGroupsUseCase,
    required this.deleteCommunityUseCase,
  });

  @override
  void onInit() {
    findGroups();
    nameRx.value = name;
    super.onInit();
  }

  copyCommunityId() {
    copyToClipboard(id);
    Get.snackbar("Success", "Community Id copied to clipboard");
  }

  void findGroups() async {
    isLoading.value = true;
    final results = await findGroupsUseCase.call(StringParams(id));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      errorOccurred.value = true;
      isLoading.value = false;
    }, (success) {
      groups = success;
      groups.sort((a, b) {
        final aNumber = int.parse(a.name.split(' ')[1]);
        final bNumber = int.parse(b.name.split(' ')[1]);
        return aNumber.compareTo(bNumber);
      });
      errorOccurred.value = false;
      isLoading.value = false;
    });
  }
}
