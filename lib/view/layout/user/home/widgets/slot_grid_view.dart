import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/view/layout/user/home/controller/parking_controller.dart';
import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';

class SlotsGridView extends StatefulWidget {
  final List<dynamic> parkingModel;
  final int currentIndex;
  const SlotsGridView({
    super.key,
    required this.parkingModel,
    required this.currentIndex,
  });

  @override
  State<SlotsGridView> createState() => _SlotsGridViewState();
}

class _SlotsGridViewState extends State<SlotsGridView> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ParkingController(),
      child: Consumer<ParkingController>(
        builder: (context, parkingController, _) => Wrap(
          children: List.generate(
            widget.parkingModel[widget.currentIndex].slots!.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  parkingController.setSlotId = widget
                          .parkingModel[widget.currentIndex].slots?[index].id ??
                      0;

                  log("${parkingController.slotId}");
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: ShapeDecoration(
                    color: selectedIndex == index
                        ? AppColor.mainAppColor(context)
                        : AppColor.mainAppColor(context).withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 2, color: AppColor.mainAppColor(context)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      selectedIndex == index
                          ? Padding(
                              padding: const EdgeInsets.all(2),
                              child: SvgPicture.asset(AppImages.checkIcon),
                            )
                          : const SizedBox(),
                      selectedIndex == index ? const Gap(10) : const SizedBox(),
                      Text(
                        widget.parkingModel[widget.currentIndex].slots?[index]
                                .title ??
                            "",
                        style: selectedIndex == index
                            ? AppTextStyle.textW18B(context)
                            : AppTextStyle.textM20R(context),
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //    GridView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         childAspectRatio: 2.9,
  //         crossAxisSpacing: 15,
  //         mainAxisSpacing: 20),
  //     itemBuilder: (BuildContext context, int index) {
  //       return GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             selectedIndex = index;
  //           });
  //         },
  //         child: Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
  //           decoration: ShapeDecoration(
  //             color: selectedIndex == index
  //                 ? AppColor.mainAppColor(context)
  //                 : AppColor.mainAppColor(context).withOpacity(0.1),
  //             shape: RoundedRectangleBorder(
  //               side:
  //                   BorderSide(width: 2, color: AppColor.mainAppColor(context)),
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //           ),
  //           child: Center(
  //               child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               selectedIndex == index
  //                   ? Padding(
  //                       padding: const EdgeInsets.all(2),
  //                       child: SvgPicture.asset(AppImages.checkIcon),
  //                     )
  //                   : const SizedBox(),
  //               selectedIndex == index ? const Gap(10) : const SizedBox(),
  //               Text(
  //                 widget.parkingModel[0].slots?[index].title ?? "",
  //                 style: selectedIndex == index
  //                     ? AppTextStyle.textW18B(context)
  //                     : AppTextStyle.textM20R(context),
  //               ),
  //             ],
  //           )),
  //         ),
  //       );
  //     },
  //     itemCount: widget.parkingModel[0].slots!.length,
  //   );
  // }
}
