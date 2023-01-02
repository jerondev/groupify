import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/shared/utils/launch_url.dart';

RichText buildRichTextWithClickableLink(String message) {
  // Extract the link from the message using a regular expression
  final linkRegex = RegExp(
      r"(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]");
  final matches = linkRegex.allMatches(message);

  // Build the list of TextSpans
  final children = <TextSpan>[];
  int lastIndex = 0;
  for (final match in matches) {
    if (match.start > lastIndex) {
      children.add(TextSpan(
        style: Get.textTheme.bodyText2,
        text: message.substring(lastIndex, match.start),
      ));
    }
    children.add(TextSpan(
      text: match.group(0),
      style: Get.textTheme.bodyText2!
          .copyWith(color: Get.theme.colorScheme.secondary),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          // Open the link
          openLink(match.group(0)!);
        },
    ));
    lastIndex = match.end;
  }
  if (lastIndex < message.length) {
    children.add(TextSpan(
      style: Get.textTheme.bodyText2,
      text: message.substring(lastIndex),
    ));
  }

  // Return the RichText widget with the link made clickable
  return RichText(
    text: TextSpan(
      children: children,
    ),
  );
}
