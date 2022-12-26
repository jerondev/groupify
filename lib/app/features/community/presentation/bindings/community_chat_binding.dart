import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/community_chat_controller.dart';

class CommunityChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityChatController>(() => CommunityChatController());
  }
}
