import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/theme/style.dart';

import '../../../helpers/networking/api_helper.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/app_text_style.dart';
import '../custom_loading/custom_loading.dart';

class CustomButton extends StatelessWidget {
  final double radius;
  final double? width;
  final double? borderWidth;
  final double height;
  final TextStyle? style;
  final String? text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? child;
  final Color? color;
  final Color? borderColor;
  final Gradient? gradient;
  final ApiResponse? apiResponse;
  final bool isLoading;
  final bool hasShadow;
  final void Function()? onPressed;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  const CustomButton({
    super.key,
    this.radius = 10,
    this.width,
    this.height = 47,
    this.style,
    this.text,
    this.prefixIcon = const SizedBox(),
    this.suffixIcon = const SizedBox(),
    this.color,
    this.gradient,
    this.apiResponse,
    this.isLoading = false,
    this.hasShadow = false,
    this.onPressed,
    this.child,
    this.borderColor,
    this.borderRadius,
    this.boxShadow,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return apiResponse?.state == ResponseState.loading || isLoading
        ? const Center(
            child: CustomLoading(),
          )
        : Container(
            width: width ?? double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: color ?? AppColor.mainAppColor(context),
              gradient: color != null
                  ? null
                  : (gradient ??
                      LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          AppColor.grid1Color(context),
                          AppColor.mainAppColor(context),
                          AppColor.grid2Color(context),
                        ],
                        stops: const [0.31, 0.9, 1.0],
                        transform:
                            const GradientRotation(41.37 * 3.14159 / 180),
                      )),
              borderRadius: borderRadius ?? BorderRadius.circular(radius),
              border: Border.all(
                  width: borderWidth ?? 1,
                  color: borderColor ?? Colors.transparent),
              boxShadow: boxShadow ?? (hasShadow ? appShadow : null),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (prefixIcon != null) ...{
                          prefixIcon!,
                          const Gap(5),
                        },
                        Flexible(
                          child: child ??
                              Text(
                                text ?? "",
                                textAlign: TextAlign.center,
                                style:
                                    style ?? AppTextStyle.buttonStyle(context),
                              ),
                        ),
                        if (suffixIcon != null) ...{
                          const Gap(5),
                          suffixIcon!,
                        }
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(radius),
                      onTap: onPressed,
                      child: SizedBox(
                        width: width ?? double.infinity,
                        height: height,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
