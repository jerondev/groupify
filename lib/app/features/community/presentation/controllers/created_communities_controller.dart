import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/usecases/find_created_communities.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class CreatedCommunitiesController extends GetxController {
  RxBool isEmpty = true.obs;
  RxBool isLoading = false.obs;
  final FindCreatedCommunitiesUseCase findCreatedGroupsUseCase;
  late final List<CommunityEntity> groups;
  CreatedCommunitiesController({required this.findCreatedGroupsUseCase});

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
