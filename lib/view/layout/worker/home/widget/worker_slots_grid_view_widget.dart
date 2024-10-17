import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/view/layout/user/home/controller/parking_controller.dart';
import 'package:valet_parking/view/layout/user/home/model/category_model.dart';
import 'package:valet_parking/view/layout/worker/qr_code_scan/controller/qr_code_scan_controller.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';

class WorkerSlotsGridViewWidget extends StatefulWidget {
  final List<CategoryModel> categoryModel;
  final int currentIndex;
  const WorkerSlotsGridViewWidget({
    super.key,
    required this.categoryModel,
    required this.currentIndex,
  });

  @override
  State<WorkerSlotsGridViewWidget> createState() => _WorkerSlotsGridViewWidgetState();
}

class _WorkerSlotsGridViewWidgetState extends State<WorkerSlotsGridViewWidget> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ParkingController(),
      child: Consumer<ParkingController>(
        builder: (context, parkingController, _) => Wrap(
          children: List.generate(
            widget.categoryModel[widget.currentIndex].gates!.slots!.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  context.read<QrCodeScanController>().setSlotId =
                  widget.categoryModel[widget.currentIndex].gates!.slots![index].id!; 
                      

                  log("${ context.read<QrCodeScanController>().slotId}");
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
                        widget.categoryModel[widget.currentIndex].gates!.slots![index]
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

 
}
