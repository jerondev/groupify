import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UserDetailsController extends GetxController {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool isFormValid = false.obs;
}
