import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

void openLink(String url) async {
  if (await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
  } else {
    showErrorSnackbar(message: "Couldn't open link");
  }
}
