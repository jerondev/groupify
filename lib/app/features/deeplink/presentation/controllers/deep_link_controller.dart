import 'package:get/get.dart';

class DeepLinkController extends GetxController {
  Future<void> handleLink(Uri? dynamicLink) async {
    if (dynamicLink != null) {
      final Uri deepLink = dynamicLink;
      final activity = deepLink.pathSegments[0];
      if (activity == 'join') {
        final code = deepLink.pathSegments[2];
      }
    }
  }
}
