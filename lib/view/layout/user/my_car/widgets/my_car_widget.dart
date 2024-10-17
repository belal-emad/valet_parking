import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/extension/context_extension.dart';
import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/theme/style.dart';
import '../../../../../helpers/utils/common_methods.dart';
import '../controller/car_controller.dart';
import '../model/car_model.dart';

class MyCarWidget extends StatelessWidget {
  final CarModel car;
  const MyCarWidget({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: AppColor.whiteColor(context),
          borderRadius: BorderRadius.circular(16),
          boxShadow: appShadow),
      child: Center(
        child: ListTile(
          leading: Image.asset(
            AppImages.carRequestImage,
            fit: BoxFit.fill,
            width: 70,
          ),
          title: Text(
            car.carModel ?? "",
            style: AppTextStyle.textD18B(context),
          ),
          dense: true,
          subtitle: Text(
            car.carPlate ?? "",
          ),
          trailing: TextButton(
            onPressed: () {
              CommonMethods.showChooseDialog(
                context,
                message: context.apiTr(
                    ar: 'هل تريد حذف السيارة ؟',
                    en: "Do you want to delete the car ?"),
                onPressed: () {
                  Navigator.pop(context);
                  context.read<CarController>().deleteCar(id: car.id!);
                },
              );
            },
            child: Text(
              tr(AppLocaleKey.delete),
              style: AppTextStyle.textR18R(context),
            ),
          ),
        ),
      ),
    );
  }
}
