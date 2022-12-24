import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_chat_controller.dart';

class GroupChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupChatController>(() => GroupChatController());
  }
}
