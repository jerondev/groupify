// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/community/domain/usecases/find_community.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';

class DiscoverController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final groupCodeController = TextEditingController();
  RxBool isLoading = false.obs;
  final FindCommunityUseCase findCommunityUseCase;
  final FindGroupUseCase findGroupUseCase;
  DiscoverController({
    required this.findCommunityUseCase,
    required this.findGroupUseCase,
  });
}
