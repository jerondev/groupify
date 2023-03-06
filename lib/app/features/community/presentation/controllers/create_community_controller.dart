// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:groupify/app/features/account/presentation/controllers/account_controller.dart';
import 'package:groupify/app/features/community/domain/usecases/create.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nanoid/nanoid.dart';

import '../../../../../shared/usecase/usecase.dart';
import '../../domain/entities/community.dart';

class CreateCommunityController extends GetxController {
  final AccountController _accountController = Get.find();
  late final TextEditingController nameController;
  RxBool enableButton = true.obs;
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

  // crop image
  Future<String?> cropImage(String imagePath) async {
    final croppedImage = await ImageCropper().cropImage(sourcePath: imagePath);
    return croppedImage?.path;
  }

  Future<void> create() async {
    final community = Community(
      name: nameController.text,
      id: nanoid(),
      description: "",
      avatar: "",
      members: const [],
      ownerId: FirebaseAuth.instance.currentUser!.uid,
      createdAt: DateTime.now(),
    );
    final result = await createCommunity(Params(community));
    result.fold(
      (failure) => print(failure),
      (id) => print(id),
    );
  }
}
