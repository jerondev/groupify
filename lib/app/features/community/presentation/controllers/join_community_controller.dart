// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_groups.dart';
import 'package:organizer_client/shared/ui/snackbars.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class JoinCommunityController extends GetxController {
  final String? id = Get.parameters['id'];
  late List<GroupEntity> groups;
  RxBool isLoading = false.obs;
  RxBool errorOccurred = false.obs;
  final FindGroupsUseCase findGroupsUseCase;
  JoinCommunityController({
    required this.findGroupsUseCase,
  });
  @override
  void onInit() {
    findGroups();
    super.onInit();
  }

  void findGroups() async {
    isLoading.value = true;
    final results = await findGroupsUseCase.call(StringParams(id!));
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
      isLoading.value = false;
    });
  }
}
