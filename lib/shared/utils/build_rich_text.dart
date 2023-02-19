import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/shared/utils/launch_url.dart';

RichText buildRichTextWithClickableLink(String message) {
  // Extract the link from the message using a regular expression
  final linkRegex = RegExp(
      r"(https?://)?[-A-Za-z0-9+&@#/%?=~_|!:,.;]+\.(aero|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|ac|ad|ae|af|ag|ai|al|am|an|ao|aq|ar|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|co|cr|cu|cv|cw|cx|cy|cz|de|dj|dk|dm|do|dz|ec|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|in|io|iq|ir|is|it|je|jm|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mk|ml|mm|mn|mo|mp|mq|mr|ms|mt|mu|mv|mw|mx|my|mz|na|nc|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|pa|pe|pf|pg|ph|pk|pl|pm|pn|pr|ps|pt|pw|py|qa|re|ro|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tf|tg|th|tj|tk|tl|tm|tn|to|tp|tr|tt|tv|tw|tz|ua|ug|uk|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|ye|yt|za|zm|zw)");

  final matches = linkRegex.allMatches(message);

  // Build the list of TextSpans
  final children = <TextSpan>[];
  int lastIndex = 0;
  for (final match in matches) {
    if (match.start > lastIndex) {
      children.add(TextSpan(
        style: Get.textTheme.bodyMedium,
        text: message.substring(lastIndex, match.start),
      ));
    }
    children.add(TextSpan(
      text: match.group(0),
      style: Get.textTheme.bodyMedium!
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
      style: Get.textTheme.bodyMedium,
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
