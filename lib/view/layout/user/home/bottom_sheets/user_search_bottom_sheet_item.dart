import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/view/layout/user/home/controller/parking_controller.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../global/app_bottom_sheet/user_choose_car_bottom_sheet.dart';
import '../model/category_model.dart';
import 'parking_bottom_sheet.dart';

class UserSearchBottomSheetItem extends StatelessWidget {
  const UserSearchBottomSheetItem({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Consumer<ParkingController>(
        builder: (context, parkingController, _) => InkWell(
              onTap: () {
                parkingController.setCategoryId = category.id!;
                log("${category.id!} ${parkingController.categoryId}");
                log("categoryTypeId= ${parkingController.categoryTypeId}");
                Navigator.pop(context);
                NavigatorMethods.showAppBottomSheet(
                  context,
                  UserChooseCarBottomSheet(
                    addNewCar: true,
                    nextBottomSheet:
                        ParkingLocationBottomSheet(id: category.id ?? 0),
                  ),
                  enableDrag: true,
                  isScrollControlled: true,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColor.lightGreyColor(context),
                      radius: 30,
                      child: CircleAvatar(
                        backgroundColor: AppColor.lightGreenColor(context),
                        radius: 20,
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(AppImages.appLogoIcon)),
                      ),
                    ),
                    const Gap(15),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.title ?? "",
                            style: AppTextStyle.textD18B(context),
                          ),
                          const Gap(10),
                          Text(
                            category.address ?? "",
                            style: AppTextStyle.textL16R(context),
                          ),
                        ],
                      ),
                    ),
                    // Text(
                    //   tr(AppLocaleKey.km, args: ['5']),
                    //   style: AppTextStyle.textL16R(context),
                    // ),
                  ],
                ),
              ),
            ));
  }
}
