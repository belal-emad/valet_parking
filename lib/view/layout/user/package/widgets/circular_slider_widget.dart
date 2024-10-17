import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';

class CircularSliderWidget extends StatelessWidget {
  final int daysValue;

  const CircularSliderWidget({super.key, required this.daysValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      height: 135,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
        Radius.circular(20),
      )),
      child: SleekCircularSlider(
        initialValue: daysValue.toDouble(),
        appearance: CircularSliderAppearance(
          customWidths: CustomSliderWidths(
            trackWidth: 10,
            progressBarWidth: 10,
          ),
          size: 140,
          angleRange: 360,
          startAngle: 0,
          customColors: CustomSliderColors(
            trackColors: [
              AppColor.blueColor(context).withOpacity(.80),
              AppColor.blueColor(context).withOpacity(.80),
            ],
            progressBarColors: [
              AppColor.whiteColor(context),
              AppColor.whiteColor(context),
            ],
            trackColor: AppColor.whiteColor(context),
            dotColor: AppColor.whiteColor(context),
            shadowColor: AppColor.whiteColor(context),
          ),
          infoProperties: InfoProperties(
            mainLabelStyle: TextStyle(
              color: AppColor.whiteColor(context),
              fontSize: 20,
            ),
            modifier: (double value) {
              return '${value.toInt()} ${tr(AppLocaleKey.days)}';
            },
          ),
        ),
      ),
    );
  }
}
