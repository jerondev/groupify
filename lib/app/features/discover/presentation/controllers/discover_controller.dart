// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/usecases/find_community.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/is_member.dart';
import 'package:organizer_client/shared/enums/id.dart';
import 'package:organizer_client/shared/ui/snackbars.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class DiscoverController extends GetxController {
  RxBool isLoading = false.obs;
  bool errorOccurred = false;
  final FindCommunityUseCase findCommunityUseCase;
  final FindGroupUseCase findGroupUseCase;
  final IsMemberUseCase isMemberUseCase;
  DiscoverController({
    required this.findCommunityUseCase,
    required this.findGroupUseCase,
    required this.isMemberUseCase,
  });

  void find(String code) {
    if (code.startsWith('comm')) {
      findCommunity(code);
    } else {
      findGroup(code);
    }
  }

  void findCommunity(String code) async {
    isLoading.value = true;
    final results = await findCommunityUseCase(StringParams(code));
    results.fold((failure) {
      isLoading.value = false;
      showErrorSnackbar(message: failure.message);
    }, (community) async {
      final bool value = await isMember(IdType.community, code);
      if (!errorOccurred) {
        if (value) {
          showErrorSnackbar(
              message: "Already a member of ${community.name} Community");
        } else {
          Get.toNamed(
            '/join_community/${community.id}',
          );
        }
      }
    });
  }

  void findGroup(String code) async {
    isLoading.value = true;
    final results = await findGroupUseCase(StringParams(code));
    results.fold((failure) {
      isLoading.value = false;
      showErrorSnackbar(message: failure.message);
    }, (group) async {
      final value = await isMember(IdType.group, code);
      if (!errorOccurred) {
        if (!group.isFull) {
          if (value) {
            showErrorSnackbar(message: "Already a member of ${group.name}");
            final community =
                await findCommunityUseCase(StringParams(group.communityId));
            community.fold((failure) {
              isLoading.value = false;
              showErrorSnackbar(
                  message:
                      "We couldn't find the community this group belongs to");
            }, (community) {
              Get.toNamed('/group_details', arguments: {
                "groupId": group.id,
                "groupName": group.name,
                "communityId": community.id,
              });
            });
          } else {
            Get.toNamed('/join_group/${group.id}');
          }
        } else {
          showErrorSnackbar(message: "Group is full");
        }
      }
    });
  }

  Future<bool> isMember(IdType idType, String code) async {
    errorOccurred = false;
    final results = await isMemberUseCase(IsMemberParams(
      idType: idType,
      id: code,
      userId: FirebaseAuth.instance.currentUser!.uid,
    ));
    return results.fold((failure) {
      isLoading.value = false;
      showErrorSnackbar(message: failure.message);
      errorOccurred = true;
      return false;
    }, (isMem) {
      isLoading.value = false;
      return isMem;
    });
  }
}
