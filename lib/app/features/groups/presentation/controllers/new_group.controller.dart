import 'package:get/state_manager.dart';

class NewGroupController extends GetxController {
  List<bool> selectedGroupingMethod = [false, true];

  void changeSelectedGroup(int index) {
    for (var i = 0; i < selectedGroupingMethod.length; i++) {
      selectedGroupingMethod[i] = i == index;
    }
    update();
  }
}
