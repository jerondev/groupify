import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:organizer_client/app/features/account/presentation/pages/account_page.dart';
import 'package:organizer_client/app/features/groups/presentation/pages/gropus_page.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  final List<Widget> _pages = [const GroupsPage(), const AccountPage()];
  void changeIndex(int index) {
    currentIndex.value = index;
  }

  Widget get currentPage => _pages[currentIndex.value];
}
