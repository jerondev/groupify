import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/usecases/find_created_communities.dart';
import 'package:organizer_client/shared/ui/snackbars.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class CreatedCommunitiesController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool errorOccurred = false.obs;
  final FindCreatedCommunitiesUseCase findCreatedCommunitiesUseCase;
  // late List<CommunityEntity> communities;
  RxList<CommunityEntity> communities = RxList<CommunityEntity>();
  CreatedCommunitiesController({required this.findCreatedCommunitiesUseCase});

  @override
  void onInit() {
    communities.bindStream(findCreatedCommunities());
    findCreatedCommunities();
    super.onInit();
  }

  Stream<List<CommunityEntity>> findCreatedCommunities() async* {
    isLoading.value = true;
    final result = await findCreatedCommunitiesUseCase.call(
      StringParams(FirebaseAuth.instance.currentUser!.uid),
    );
    yield* result.fold((failure) async* {
      showErrorSnackbar(message: failure.message);
      errorOccurred.value = true;
      isLoading.value = false;
    }, (success) async* {
      errorOccurred.value = false;
      isLoading.value = false;
      yield* success;
    });
  }
}
