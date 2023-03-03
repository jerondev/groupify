import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organizer_client/app/features/account/presentation/pages/account_page.dart';
import 'package:organizer_client/app/features/community/presentation/pages/created_communities_page.dart';
import 'package:organizer_client/app/features/groups/presentation/pages/groups_page.dart';

import '../../../deeplink/presentation/controllers/deep_link_controller.dart';

class HomeController extends GetxController {
  // access the ids of the pages through the arguments
  final int groupPageIndex = Get.arguments ?? 0;
  final currentIndex = 0.obs;
  final DeepLinkController _deepLinkController = Get.find();
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

  final List<Widget> _pages = [
    const GroupsPage(),
    const CreatedCommunitiesPage(),
    const AccountPage()
  ];
  void changeIndex(int index) {
    currentIndex.value = index;
  }

  Widget get currentPage => _pages[currentIndex.value];
}
