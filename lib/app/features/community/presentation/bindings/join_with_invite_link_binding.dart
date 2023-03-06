import 'package:get/get.dart';
import 'package:groupify/app/features/community/presentation/controllers/join_with_invite_link_controller.dart';

class JoinWithInviteLinkBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoinWithInviteLinkController>(
        () => JoinWithInviteLinkController());
  }
}
