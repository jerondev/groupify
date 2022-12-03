// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Spinner extends StatelessWidget {
  const Spinner({
    Key? key,
    this.size,
    this.color,
  }) : super(key: key);
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: color ?? Get.theme.colorScheme.primaryContainer,
      size: size ?? 50,
    );
  }
}
