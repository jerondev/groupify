import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/discover_controller.dart';

class DeepLinkController extends GetxController {
  final DiscoverController _discoverController = Get.find();
  Future<void> handleLink(PendingDynamicLinkData? dynamicLink) async {
    if (dynamicLink != null) {
      final Uri deepLink = dynamicLink.link;
      final activity = deepLink.pathSegments[0];
      if (activity == 'join') {
        final code = deepLink.pathSegments[2];
        _discoverController.find(code);
      }
    }
  }
}
