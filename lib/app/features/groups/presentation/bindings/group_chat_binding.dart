import 'package:get/get.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/get_messages.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/send_message.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_chat_controller.dart';

class GroupChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetMessagesUseCase>(
        () => GetMessagesUseCase(repository: Get.find()));
    Get.lazyPut<SendMessageUseCase>(() => SendMessageUseCase(
          repository: Get.find(),
        ));
    Get.put(
      GroupChatController(
        getMessagesUseCase: Get.find(),
        sendMessageUseCase: Get.find(),
        authenticatedUser: Get.find(),
      ),
      permanent: true,
    );
  }
}
