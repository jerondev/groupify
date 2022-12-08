// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:share_plus/share_plus.dart';

class GroupDetailsController extends GetxController {
  final GroupEntity group = Get.arguments;
  RxBool isLoading = false.obs;

  void shareSubGroup() {
    Share.share("Join my group on Groupify App. Group ID: ${group.id}");
  }
}
