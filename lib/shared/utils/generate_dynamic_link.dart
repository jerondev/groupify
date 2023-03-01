import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future<void> inviteOrganizers() async {
  // final organization = await retrieve();
  // final dynamicLinkParams = DynamicLinkParameters(
  //   uriPrefix: 'https://grabtickapp.page.link',
  //   link: Uri.parse(
  //       'https://grabtickapp.page.link/organization/join/${organization.id}'),
  //   androidParameters: const AndroidParameters(
  //       packageName: 'com.grabtick.app.com.grabtick.organiser',
  //       minimumVersion: 0),
  //   iosParameters: const IOSParameters(
  //       bundleId: 'com.grabtick.app.com.grabtick.organiser',
  //       minimumVersion: '0',
  //       appStoreId: '0'),
  //   socialMetaTagParameters: SocialMetaTagParameters(
  //       title: 'Join Organization',
  //       description: 'Join ${organization.name} on GrabTick'),
  // );
  // final link =
  //     await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  // Share.share("${link.shortUrl}");
}

Future<void> handleDynamicLink(PendingDynamicLinkData? dynamicLink) async {
  if (dynamicLink != null) {
    final Uri deepLink = dynamicLink.link;
    final id = deepLink.pathSegments[2];
  }
}
