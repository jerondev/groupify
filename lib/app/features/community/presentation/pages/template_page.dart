import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/presentation/pages/create_page.dart';
import 'package:organizer_client/app/routes/app_pages.dart';
import 'package:organizer_client/shared/constant/images_path.dart';
import 'package:organizer_client/shared/ui/custom_listtile.dart';

class CommunityTemplatePage extends StatelessWidget {
  const CommunityTemplatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      "Create Your Community",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Your community is where you and your mates hang out. Make yours and start talking",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CustomListTile(
                    leadingIcon: AppImages.assignments,
                    onTap: () {
                      Get.to(() => const CreatePage());
                    },
                    title: "Create My Own",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "START FROM A TEMPLATE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: CustomListTile(
                      onTap: () {
                        Get.to(() => const CreatePage());
                      },
                      title: "Assignment",
                      leadingIcon: AppImages.assignments,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CustomListTile(
                      onTap: () {
                        Get.to(() => const CreatePage());
                      },
                      title: "Study Group",
                      leadingIcon: AppImages.studyGroup,
                    ),
                  ),
                  CustomListTile(
                    onTap: () {
                      Get.to(() => const CreatePage());
                    },
                    title: "Friends",
                    leadingIcon: AppImages.friends,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                "Have an invite already?",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: OutlinedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.JOIN_COMMUNITY_WITH_INVITE_LINK);
                },
                child: const Text("Join a community"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
