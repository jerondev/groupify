// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/signout.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountController extends GetxController {
  final AuthenticatedUserUseCase authenticatedUser;
  final SignOutUseCase signOutUseCase;
  late AppUser appUser;
  RxBool isLoading = false.obs;
  final box = GetStorage('userBox');

  AccountController(
      {required this.authenticatedUser, required this.signOutUseCase});

  @override
  void onInit() {
    super.onInit();
    box.listen(() {
      getUserDetails();
    });
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    isLoading.value = true;
    final results = await authenticatedUser.call(NoParams());
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      appUser = AppUser.initial();
      isLoading.value = false;
    }, (success) {
      appUser = success;
      isLoading.value = false;
    });
  }

  Future<void> signOut() async {
    final results = await signOutUseCase.call(NoParams());
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
    }, (success) {
      Get.offAllNamed(AppRoutes.REGISTER);
    });
  }

  void launchLink(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      showErrorSnackbar(message: "Could not open link");
    }
  }

  void shareApp() {
    Share.share(
      "Hey, Groupify makes it easier to form groups for assignments, get it today: https://play.google.com/store/apps/details?id=com.jerondev.groupify&pli=1",
      subject: "Download Groupify today",
    );
  }

  void rateApp() {
    InAppReview inAppReview = InAppReview.instance;
    inAppReview.openStoreListing();
  }

  final List<SocialMediaIcon> socialMediaIcons = [
    SocialMediaIcon(
      url: "https:github.com/jeronasiedu",
      icon: const Icon(Ionicons.logo_github),
    ),
    SocialMediaIcon(
      url: "https://linkedin.com/in/jeronasiedu",
      icon: const Icon(Ionicons.logo_linkedin),
      color: Colors.blue[800],
    ),
    SocialMediaIcon(
      url: "https://twitter.com/norej_udeisa",
      icon: const Icon(Ionicons.logo_twitter),
      color: Colors.blue,
    ),
    SocialMediaIcon(
      url: "https://wa.me/233544751048/?text=Hi%20Jeron",
      icon: const Icon(Ionicons.logo_whatsapp),
      color: Colors.green,
    ),
  ];
}

class SocialMediaIcon {
  final String url;
  final Widget icon;
  final Color? color;
  SocialMediaIcon({
    required this.url,
    required this.icon,
    this.color,
  });
}
