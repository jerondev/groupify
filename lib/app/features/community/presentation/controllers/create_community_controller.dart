// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:groupify/app/features/account/presentation/controllers/account_controller.dart';
import 'package:groupify/app/features/community/domain/usecases/create.dart';
import 'package:groupify/app/features/community/presentation/pages/invite_after_creation_page.dart';
import 'package:groupify/app/features/deeplink/data/generate_link.dart';
import 'package:groupify/shared/ui/snackbars.dart';
import 'package:groupify/shared/utils/crop_image.dart';
import 'package:groupify/shared/utils/upload_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nanoid/nanoid.dart';

import '../../../../../shared/usecase/usecase.dart';
import '../../domain/entities/community.dart';

class CreateCommunityController extends GetxController {
  final AccountController _accountController = Get.find();
  late final TextEditingController nameController;
  RxBool enableButton = true.obs;
  RxBool isLoading = false.obs;
  final CreateCommunity createCommunity;
  String communityProfile = '';
  CreateCommunityController({
    required this.createCommunity,
  });

  @override
  void onInit() {
    final name = _accountController.appUser.fullName;
    nameController = TextEditingController(text: "$name's Community");
    // add a listener to the text field and update the enableButton variable
    nameController.addListener(() {
      enableButton.value = nameController.text.isNotEmpty;
    });
    super.onInit();
  }

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final croppedImage = await cropImage(pickedImage.path);
      if (croppedImage != null) {
        communityProfile = croppedImage;
        update();
      }
    }
  }

  Future<void> create() async {
    isLoading.value = true;
    enableButton.value = false;
    String? imageUrl;
    if (communityProfile.isNotEmpty) {
      try {
        imageUrl = await uploadImageToFirebaseStorage(communityProfile);
      } on Exception {
        showErrorSnackbar(message: "Check your connectivity and try again");
      }
    } else {
      imageUrl =
          'https://api.dicebear.com/5.x/initials/png?seed=${nameController.text.trim()}';
    }

    final community = Community(
      name: nameController.text.trim(),
      id: nanoid(),
      description: "",
      avatar: imageUrl ??
          'https://api.dicebear.com/5.x/initials/png?seed=${nameController.text.trim()}',
      members: const [],
      ownerId: FirebaseAuth.instance.currentUser!.uid,
      createdAt: DateTime.now(),
    );
    final result = await createCommunity(Params(community));
    result.fold(
      (failure) {
        isLoading.value = false;
        enableButton.value = true;
        showErrorSnackbar(message: failure.message);
      },
      (id) async {
        final inviteLink = await DeepLinkGenerator.generateCommunityLink(
            communityId: community.id, communityName: community.name);
        isLoading.value = false;
        enableButton.value = true;
        Get.off(
          () => const InviteAfterCreationPage(),
          arguments: inviteLink,
        );
      },
    );
  }
}
