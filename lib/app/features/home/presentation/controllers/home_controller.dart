import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/account/presentation/pages/account_page.dart';
import 'package:organizer_client/app/features/community/presentation/pages/created_communities_page.dart';
import 'package:organizer_client/app/features/groups/presentation/pages/groups_page.dart';

class HomeController extends GetxController {
  // access the ids of the pages through the arguments
  final int groupPageIndex = Get.arguments ?? 0;
  final currentIndex = 0.obs;

  @override
  void onInit() {
    currentIndex.value = groupPageIndex;
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
