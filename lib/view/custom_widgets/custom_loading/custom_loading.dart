import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../helpers/theme/app_colors.dart';

class CustomLoading extends StatelessWidget {
  final double size;
  final Color? color;
  const CustomLoading({
    super.key,
    this.size = 45,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: color ?? AppColor.mainAppColor(context),
      size: size,
    );
  }
}
