// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/register.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';

class UserDetailsController extends GetxController {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final RxBool isFormValid = false.obs;
  final RegisterUseCase registerUseCase;
  UserDetailsController({
    required this.registerUseCase,
  });
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? get displayName => _auth.currentUser!.displayName;
  String? get photoURL => _auth.currentUser!.photoURL;
  String? get email => _auth.currentUser!.email;
  String? get uid => _auth.currentUser!.uid;

  Future<void> register() async {
    final result = await registerUseCase(
      AppUser(
        displayName: displayName!,
        email: email!,
        id: uid!,
        profile: photoURL!,
        phoneNumber: phoneNumberController.text,
        fullName: nameController.text.trim(),
      ),
    );
    result.fold(
      (failure) => showErrorSnackbar(message: failure.message),
      (success) => Get.offAllNamed(AppRoutes.HOME),
    );
  }
}
