// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DiscoverController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final groupCodeController = TextEditingController();
  RxBool isLoading = false.obs;
}
