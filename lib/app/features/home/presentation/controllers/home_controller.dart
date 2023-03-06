// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groupify/app/features/account/presentation/controllers/account_controller.dart';

import '../../../deeplink/presentation/controllers/deep_link_controller.dart';

class HomeController extends GetxController {
  // access the ids of the pages through the arguments
  final int groupPageIndex = Get.arguments ?? 0;
  final currentIndex = 0.obs;
  final DeepLinkController _deepLinkController = Get.find();
  final AccountController accountController = Get.find();

  final _userBox = GetStorage('userBox');

  @override
  void onInit() {
    currentIndex.value = groupPageIndex;
    String? dynamicLink = _userBox.read('pendingDynamicLink');
    if (dynamicLink != null) {
      _deepLinkController.handleLink(Uri.tryParse(dynamicLink));
      _userBox.remove('pendingDynamicLink');
    }

    super.onInit();
  }
}
