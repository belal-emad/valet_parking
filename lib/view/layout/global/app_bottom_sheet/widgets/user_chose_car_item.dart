import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/theme/style.dart';
import '../../../user/home/controller/parking_controller.dart';
import '../../../user/my_car/model/car_model.dart';

class UserChoseCarItem extends StatefulWidget {
  const UserChoseCarItem({
    super.key,
    required this.car,
    required this.selectedCar,
    required this.currentIndex,
  });
  final CarModel car;
  final String selectedCar;

  final int currentIndex;
  @override
  State<UserChoseCarItem> createState() => _UserChoseCarItemState();
}

class _UserChoseCarItemState extends State<UserChoseCarItem> {
  String selectedCarRadio = "";
  @override
  Widget build(BuildContext context) {
    return Consumer<ParkingController>(
        builder: (context, parkingController, child) => Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                  color: AppColor.whiteColor(context),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: appShadow),
              child: Center(
                child: ListTile(
                  onTap: () {
                    setState(() {
                      selectedCarRadio = widget.currentIndex.toString();
                      // log(widget.currentIndex.toString());
                      widget.car.id.toString();
                      parkingController.setUserCarId = widget.car.id!;
                      log(" userCard = ${parkingController.userCarId}");

                      selectedCarRadio = widget.selectedCar;

                      //  widget.onChange(widget.car.id.toString());
                    });
                  },
                  leading: Image.asset(
                    AppImages.carRequestImage,
                    fit: BoxFit.fill,
                    width: 70,
                  ),
                  title: Text(
                    widget.car.carModel ?? "",
                    style: AppTextStyle.textD18B(context),
                  ),
                  dense: true,
                  subtitle: Text(widget.car.carPlate ?? "",
                      style: AppTextStyle.textL16R(context, height: 2)),
                  trailing: Radio(
                    value: widget.car.id.toString(),
                    fillColor: MaterialStateProperty.all(
                        AppColor.secondAppColor(context)),
                    groupValue: widget.selectedCar,
                    onChanged: (value) {
                      setState(() {
                        widget.selectedCar != value;
                      });
                    },
                  ),
                ),
              ),
            ));
  }
}
