import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:groupify/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:groupify/app/features/groups/domain/entities/group_entity.dart';
import 'package:groupify/app/features/groups/domain/usecases/find_joined_groups.dart';
import 'package:groupify/shared/ui/snackbars.dart';
import 'package:groupify/shared/usecase/usecase.dart';

class GroupsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool errorOccurred = false.obs;
  final FindJoinedGroupsUseCase findJoinedGroupUseCase;
  final AuthenticatedUserUseCase authenticatedUserUseCase;

  RxList<GroupEntity> groups = RxList<GroupEntity>();

  GroupsController({
    required this.findJoinedGroupUseCase,
    required this.authenticatedUserUseCase,
  });

  @override
  void onInit() {
    groups.bindStream(findJoinedGroups());
    super.onInit();
  }

  Stream<List<GroupEntity>> findJoinedGroups() async* {
    isLoading.value = true;
    final results = await findJoinedGroupUseCase
        .call(StringParams(FirebaseAuth.instance.currentUser!.uid));
    yield* results.fold((failure) async* {
      showErrorSnackbar(message: failure.message);
      errorOccurred.value = true;
      yield [];
    }, (success) async* {
      errorOccurred.value = false;
      yield* success;
    });
  }
}
