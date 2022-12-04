import 'package:get/state_manager.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_member_entity.dart';
import 'package:organizer_client/app/features/groups/domain/entities/sub_group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_joined_groups.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class GroupsController extends GetxController {
  RxBool isEmpty = true.obs;
  RxBool isLoading = false.obs;
  final FindJoinedGroupUseCase findJoinedGroupUseCase;
  final AuthenticatedUserUseCase authenticatedUserUseCase;
  late final List<SubGroupEntity> groups;
  GroupsController({
    required this.findJoinedGroupUseCase,
    required this.authenticatedUserUseCase,
  });

  @override
  void onInit() {
    findJoinedGroupsWrapper();
    super.onInit();
  }

  Future<void> findJoinedGroupsWrapper() async {
    isLoading.value = true;
    final results = await authenticatedUserUseCase.call(NoParams());
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
    }, (user) {
      findJoinedGroups(user);
    });
  }

  Future<void> findJoinedGroups(AppUser user) async {
    isLoading.value = true;
    final member = GroupMemberEntity(
      id: user.id,
      name: user.fullName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      profile: user.profile,
    );
    final result = await findJoinedGroupUseCase.call(member);
    result.fold((failure) {
      showErrorSnackbar(message: failure.message);
    }, (success) {
      groups = success;
      isEmpty.value = success.isEmpty;
    });
    isLoading.value = false;
  }
}
