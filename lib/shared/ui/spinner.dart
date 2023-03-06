// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groupify/shared/enums/spinner.dart';

class Spinner extends StatelessWidget {
  const Spinner({
    Key? key,
    this.size,
    this.color,
  }) : super(key: key);
  final SpinnerSize? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    double spinSize = 50;
    if (size == SpinnerSize.sm) {
      spinSize = 20;
    } else if (size == SpinnerSize.md) {
      spinSize = 30;
    } else if (size == SpinnerSize.lg) {
      spinSize = 60;
    }

    return SizedBox(
      height: spinSize,
      width: spinSize,
      child: Center(
        child: CircularProgressIndicator.adaptive(
          valueColor:
              AlwaysStoppedAnimation<Color>(color ?? Get.theme.primaryColor),
          strokeWidth: 2,
          backgroundColor: Get.theme.colorScheme.primaryContainer,
          value: null,
          semanticsLabel: 'Loading',
        ),
      ),
    );
  }
}
