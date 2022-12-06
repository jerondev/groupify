// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/usecases/find_community.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class JoinGroupController extends GetxController {
  final FindGroupUseCase findGroupUseCase;
  final String? groupId = Get.parameters['id'];
  late final CommunityEntity groupEntity;
  RxBool isLoading = false.obs;
  JoinGroupController({
    required this.findGroupUseCase,
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
      groupEntity = CommunityEntity.initial();
      showErrorSnackbar(message: failure.message);
      isLoading.value = false;
    }, (group) {
      groupEntity = group;
      isLoading.value = false;
    });
  }

  String formatJoinedText(int totalMembers, int capacity) {
    if (totalMembers < capacity) {
      if (totalMembers == 0) {
        return "No one has joined yet";
      }
      if (totalMembers == 1) {
        return "There's one soul here";
      } else {
        return "$totalMembers have joined this group";
      }
    }
    return "sorry this group is full";
  }
}
