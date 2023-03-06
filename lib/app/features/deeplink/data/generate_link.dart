import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future<String> generateDeepLink({
  required String path,
  required String title,
  String? description,
}) async {
  final dynamicLinkParams = DynamicLinkParameters(
    uriPrefix: 'https://groupifi.page.link',
    link: Uri.parse('https://groupifi.page.link/$path'),
    androidParameters: const AndroidParameters(
      packageName: 'com.jerondev.groupify',
      minimumVersion: 0,
    ),
    socialMetaTagParameters: SocialMetaTagParameters(
      title: title,
      description: description,
      // imageUrl: Uri.parse(''),
    ),
  );
  final link =
      await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  return link.shortUrl.toString();
}

// mixin for deepLink

class DeepLinkGenerator {
  static Future<String> generateCommunityLink({
    required String communityId,
    required String communityName,
  }) async {
    return generateDeepLink(
      path: 'community/$communityId',
      title: communityName,
      description: "Join $communityName on Groupify",
    );
  }
}
