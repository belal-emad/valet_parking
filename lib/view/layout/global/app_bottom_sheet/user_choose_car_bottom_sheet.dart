import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/images/app_images.dart';
import 'package:valet_parking/helpers/theme/style.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/custom_widgets/custom_loading/custom_shimmer.dart';
import 'package:valet_parking/view/layout/user/home/controller/parking_controller.dart';
import 'package:valet_parking/view/layout/user/my_car/controller/car_controller.dart';
import 'package:valet_parking/view/layout/user/my_car/screen/add_new_car_screen.dart';
import '../../../../helpers/locale/app_locale_key.dart';
import '../../../../helpers/theme/app_colors.dart';
import '../../../../helpers/theme/app_text_style.dart';
import '../../../../helpers/utils/navigator_methods.dart';
import '../../../custom_widgets/buttons/custom_button.dart';
import 'user_bottom_sheet.dart';

class UserChooseCarBottomSheet extends StatefulWidget {
  const UserChooseCarBottomSheet({
    super.key,
    required this.nextBottomSheet,
    required this.addNewCar,
  });

  final Widget nextBottomSheet;
  final bool addNewCar;

  @override
  State<UserChooseCarBottomSheet> createState() =>
      _UserChooseCarBottomSheetState();
}

class _UserChooseCarBottomSheetState extends State<UserChooseCarBottomSheet> {
  String? selectedValue;
  int selectedCarIndex = -1;
  String? selectedCarId;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarController()
        ..initialCar()
        ..getCar(),
      child: Consumer<CarController>(builder: (context, carController, _) {
        return UserBottomSheet(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColor.blackColor(context),
                  ),
                ),

                // const Spacer(),
                Expanded(
                    child: Center(
                        child: Text(
                  tr(AppLocaleKey.choseYourCar),
                  style: AppTextStyle.textD24B(context),
                ))),
                // const Spacer(),
              ],
            ),
            //end of title
            const Gap(40),
            ApiResponseWidget(
                apiResponse: carController.carsResponse,
                onReload: () => carController.getCar(),
                isEmpty: carController.cars.isEmpty,
                loadingWidget: const CustomShimmer(
                  height: 100,
                  radius: 16,
                ),
                child: Column(
                  children: List.generate(
                      carController.cars.length,
                      (index) => Consumer<ParkingController>(
                          builder: (context, parkingController, child) =>
                              Container(
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
                                        selectedCarIndex = index;
                                        selectedValue = carController
                                            .cars[index].id
                                            .toString();
                                        // log(widget.currentIndex.toString());
                                        carController.cars[index].id.toString();
                                        parkingController.setUserCarId =
                                            carController.cars[index].id!;
                                        log(" userCard = ${parkingController.userCarId}");

                                        //  widget.onChange(widget.car.id.toString());
                                      });
                                    },
                                    leading: Image.asset(
                                      AppImages.carRequestImage,
                                      fit: BoxFit.fill,
                                      width: 70,
                                    ),
                                    title: Text(
                                      carController.cars[index].carModel ?? "",
                                      style: AppTextStyle.textD18B(context),
                                    ),
                                    dense: true,
                                    subtitle: Text(
                                        carController.cars[index].carPlate ??
                                            "",
                                        style: AppTextStyle.textL16R(context,
                                            height: 2)),
                                    trailing: Radio(
                                      value: carController.cars[index].id
                                          .toString(),
                                      fillColor: MaterialStateProperty.all(
                                          AppColor.secondAppColor(context)),
                                      groupValue: selectedValue.toString(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value as String;
                                          parkingController.setUserCarId =
                                              carController.cars[index].id!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ))),
                )),

            const Gap(20),
            widget.addNewCar
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AddNewCarScreen.routeName,
                                arguments: AddNewCarArgs(onSuccess: () {
                              carController.getCar();
                            }));
                            // NavigatorMethods.pushNamed(
                            //     context, AddNewCarScreen.routeName,);
                          },
                          child: Text(
                            tr(AppLocaleKey.addNewCar),
                            style: AppTextStyle.textD18B(context),
                          )),
                    ],
                  )
                : const Gap(0),
            const Gap(20),

            CustomButton(
              onPressed: () {
                Navigator.pop(context);
                NavigatorMethods.showAppBottomSheet(
                  context,
                  widget.nextBottomSheet,
                  enableDrag: true,
                  isScrollControlled: true,
                );
              },
              text: tr(AppLocaleKey.next),
            )
          ],
        );
      }),
    );
  }
}
