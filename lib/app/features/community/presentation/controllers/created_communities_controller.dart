import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/usecases/find_created_communities.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class CreatedCommunitiesController extends GetxController {
  RxBool isEmpty = true.obs;
  RxBool isLoading = false.obs;
  final FindCreatedCommunitiesUseCase findCreatedCommunitiesUseCase;
  late final List<CommunityEntity> groups;
  CreatedCommunitiesController({required this.findCreatedCommunitiesUseCase});

  @override
  void onInit() {
    findCreatedCommunities();
    super.onInit();
  }

  Future<void> findCreatedCommunities() async {
    isLoading.value = true;
    final result = await findCreatedCommunitiesUseCase.call(
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
