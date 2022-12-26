import 'package:get/get.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/get_group_messages.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/send_group_message.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_chat_controller.dart';

class GroupChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetGroupMessagesUseCase>(
        () => GetGroupMessagesUseCase(repository: Get.find()));
    Get.lazyPut<SendGroupMessageUseCase>(() => SendGroupMessageUseCase(
          repository: Get.find(),
        ));
    Get.put(
      GroupChatController(
        getMessagesUseCase: Get.find(),
        authenticatedUser: Get.find(),
      ),
      permanent: true,
    );
  }
}
