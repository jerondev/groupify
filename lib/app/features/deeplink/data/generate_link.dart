import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

Future<void> generateDynamicLink(
    {required String path, required String title, String? description}) async {
  final dynamicLinkParams = DynamicLinkParameters(
    uriPrefix: 'https://classorganizer.page.link',
    link: Uri.parse('https://classorganizer.page.link/$path'),
    androidParameters: const AndroidParameters(
        packageName: 'com.jerondev.groupify', minimumVersion: 0),
    socialMetaTagParameters: SocialMetaTagParameters(
      title: title,
      description: description,
    ),
  );
  final link =
      await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  Share.share(
    "${link.shortUrl}",
    subject: title,
  );
}
