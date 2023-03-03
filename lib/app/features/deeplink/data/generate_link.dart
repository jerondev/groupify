import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

Future<String> generateDeepLink({
  required String path,
  required String title,
  String? description,
  bool shareImmediately = true,
}) async {
  final dynamicLinkParams = DynamicLinkParameters(
    uriPrefix: 'https://classorganizer.page.link',
    link: Uri.parse('https://classorganizer.page.link/$path'),
    androidParameters: const AndroidParameters(
        packageName: 'com.jerondev.groupify', minimumVersion: 0),
    socialMetaTagParameters: SocialMetaTagParameters(
      title: title,
      description: description,
      // imageUrl: Uri.parse(''),
    ),
  );
  final link =
      await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  if (shareImmediately) {
    Share.share(
      "${link.shortUrl}",
      subject: title,
    );
  }
  return link.shortUrl.toString();
}
