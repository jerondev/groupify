import 'package:get/get.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/delete_community_message.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/get_community_messages.dart';
import 'package:organizer_client/app/features/chat/domain/usecases/send_community_message.dart';
import 'package:organizer_client/app/features/community/presentation/controllers/community_chat_controller.dart';

class CommunityChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetCommunityMessagesUseCase>(() => GetCommunityMessagesUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<SendCommunityMessageUseCase>(() => SendCommunityMessageUseCase(
          repository: Get.find(),
        ));
    Get.lazyPut<DeleteCommunityMessageUseCase>(
        () => DeleteCommunityMessageUseCase(
              repository: Get.find(),
            ));
    Get.lazyPut<CommunityChatController>(
      () => CommunityChatController(
        authenticatedUser: Get.find(),
        getMessagesUseCase: Get.find(),
        sendCommunityMessageUseCase: Get.find(),
        deleteCommunityMessageUseCase: Get.find(),
      ),
    );
  }
}
