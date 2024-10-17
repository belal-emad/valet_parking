import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/layout/user/home/bottom_sheets/find_destination_bottom_sheet.dart';
import 'package:valet_parking/view/layout/user/home/controller/parking_controller.dart';
import 'package:valet_parking/view/layout/user/home/model/category_type_model.dart';

import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';

class UserHomeFilterWidget extends StatefulWidget {
  final CategoryTypeModel homeCategoryModel;

  const UserHomeFilterWidget({super.key, required this.homeCategoryModel});
  @override
  State<UserHomeFilterWidget> createState() => _UserHomeFilterWidgetState();
}

class _UserHomeFilterWidgetState extends State<UserHomeFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ParkingController>(
      builder: (context, parkingController, _) => ActionChip(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        label: Text(
          widget.homeCategoryModel.title ?? "",
          style: AppTextStyle.textM16R(context).copyWith(
            color: AppColor.whiteColor(context),
          ),
        ),
        avatar: Icon(
          Icons.location_on,
          color: AppColor.whiteColor(context),
        ),
        backgroundColor: AppColor.mainAppColor(context),
        onPressed: () {
          // Provider.of<ParkingController>(context).setCategoryTypeId =
          //     widget.homeCategoryModel.id!;
          NavigatorMethods.showAppBottomSheet(context,
              FindDestinationBottomSheet(id: widget.homeCategoryModel.id!),
              isScrollControlled: true);
          parkingController.setCategoryTypeId = widget.homeCategoryModel.id!;

          log("categoryTypeId= ${parkingController.categoryTypeId}");
        },
      ),
    );
  }
}
