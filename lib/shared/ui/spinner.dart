// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Spinner extends StatelessWidget {
  const Spinner({
    Key? key,
    this.radius,
  }) : super(key: key);
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: Get.theme.colorScheme.primaryContainer,
    );
  }
}
