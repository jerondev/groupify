import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groupify/shared/constant/images_path.dart';
import 'package:groupify/shared/ui/snackbars.dart';
import 'package:groupify/shared/utils/copy_to_clipboard.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../routes/app_pages.dart';

class InviteAfterCreationPage extends StatefulWidget {
  const InviteAfterCreationPage({Key? key}) : super(key: key);

  @override
  State<InviteAfterCreationPage> createState() =>
      _InviteAfterCreationPageState();
}

class _InviteAfterCreationPageState extends State<InviteAfterCreationPage> {
  final inviteLink = Get.arguments as String;
  bool hasSharedLink = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoutes.HOME);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Get.offAllNamed(AppRoutes.HOME),
              child: Text(
                hasSharedLink ? "Done" : "Skip",
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  "Add some people",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: Text(
                  "You will need a few friends to get the most out of your community",
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                AppImages.invite,
                width: 300,
                fit: BoxFit.cover,
              ),
              ListTile(
                trailing: const Icon(Ionicons.link),
                title: Text(inviteLink),
                tileColor:
                    Get.theme.colorScheme.secondaryContainer.withOpacity(0.2),
                onTap: () {
                  copyToClipboard(inviteLink);
                  showSuccessSnackbar(
                      message: "Invite link copied to clipboard");
                  setState(() {
                    hasSharedLink = true;
                  });
                },
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    Share.share(
                        "Hey, join my community on Groupify $inviteLink",
                        subject: "Join my community on Groupify");
                    setState(() {
                      hasSharedLink = true;
                    });
                  },
                  child: const Text("Share Link"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
