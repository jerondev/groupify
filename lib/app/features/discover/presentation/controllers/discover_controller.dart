// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/usecases/find_community.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/is_member.dart';
import 'package:organizer_client/shared/enums/id.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class DiscoverController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
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

  void find() {
    if (formKey.currentState!.validate()) {
      final code = codeController.text.trim();
      if (codeController.text.startsWith("comm")) {
        findCommunity(code);
      } else {
        findGroup(code);
      }
    } else {
      showErrorSnackbar(message: "Please enter a valid code");
    }
  }

  void findCommunity(String code) async {
    isLoading.value = true;
    final results = await findCommunityUseCase(StringParams(code));
    results.fold((failure) {
      isLoading.value = false;
      showErrorSnackbar(message: failure.message);
    }, (community) async {
      final bool value = await isMember(IdType.community);
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
      final value = await isMember(IdType.group);
      if (!errorOccurred) {
        if (!group.isFull) {
          if (value) {
            Get.toNamed('/group_details', arguments: {
              "groupId": group.id,
              "groupName": group.name,
              "group": group
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

  Future<bool> isMember(IdType idType) async {
    errorOccurred = false;
    final code = codeController.text.trim();
    final results = await isMemberUseCase.call(IsMemberParams(
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
