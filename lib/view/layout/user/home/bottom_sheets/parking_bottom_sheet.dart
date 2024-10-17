import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../global/app_bottom_sheet/user_bottom_sheet.dart';
import '../controller/parking_controller.dart';
import '../widgets/slot_grid_view.dart';
import 'user_add_service_bottom_sheet.dart';

class ParkingLocationBottomSheet extends StatefulWidget {
  const ParkingLocationBottomSheet({
    super.key,
    required this.id,
  });
  final int id;

  @override
  State<ParkingLocationBottomSheet> createState() =>
      _ParkingLocationBottomSheetState();
}

class _ParkingLocationBottomSheetState
    extends State<ParkingLocationBottomSheet> {
  TabController? _tabController;
  int currentIndex = -1;
  bool isSelected = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ParkingController>(context, listen: false)
          .initialParkingDetails();
      Provider.of<ParkingController>(context, listen: false)
          .getParkingDetails(id: widget.id);
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ParkingController>(
        builder: (context, parkingController, _) {
      return ApiResponseWidget(
        apiResponse: parkingController.parkingResponse,
        isEmpty: parkingController.parkingDetails.isEmpty,
        onReload: () => parkingController.getParkingDetails(id: widget.id),
        child: DefaultTabController(
          length: parkingController.parkingDetails.length,
          child: UserBottomSheet(
            children: [
              CustomAppBar(
                context,
                title: Text(
                  tr(AppLocaleKey.choseYourParkingLocation),
                ),
                automaticallyImplyLeading: true,
                appBarColor: AppColor.whiteColor(context),
              ),
              const Gap(10),
              TabBar(
                onTap: (value) {
                  currentIndex = value;
                  parkingController.setGateId =
                      parkingController.parkingDetails[value].id!;
                  log("${parkingController.gateId}");
                },
                indicatorColor: Colors.transparent,
                //   indicatorPadding: EdgeInsets.symmetric(horizontal: 0),
                // indicatorWeight: 20,
                // indicatorSize: TabBarIndicatorSize.label,

                controller: _tabController,
                tabs: List.generate(
                    parkingController.parkingDetails.length,
                    (index) => CustomButton(
                          color: currentIndex == index
                              ? AppColor.mainAppColor(context)
                              : AppColor.whiteFcColor(context),
                          radius: 20,
                          borderColor: AppColor.mainAppColor(context),
                          borderWidth: 2,
                          text: parkingController.parkingDetails[index].title ??
                              "",
                          style: currentIndex == index
                              ? AppTextStyle.textW16B(context)
                              : AppTextStyle.textM16B(context),
                        )),
              ),
              // Center(
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       children: List.generate(
              //           growable: true,
              //           parkingController.parkingDetails.length,
              //           (index) => Padding(
              //               padding: const EdgeInsets.only(left: 5),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   ActionChip(
              //                     labelPadding: const EdgeInsets.symmetric(
              //                         horizontal: 25, vertical: 5),
              //                     onPressed: () {},
              //                     backgroundColor:
              //                         AppColor.mainAppColor(context),
              //                     label: Text(
              //                       parkingController
              //                               .parkingDetails[index].title ??
              //                           "",
              //                       style: AppTextStyle.textW16B(context),
              //                     ),
              //                   ),
              //                 ],
              //               ))),
              //     ),
              //   ),
              // ),
              Row(
                children: [
                  Text(tr(AppLocaleKey.login)),
                  Expanded(
                    child: Divider(
                      indent: 10,
                      color: AppColor.greyColor(context),
                      thickness: 2,
                    ),
                  ),
                ],
              ),
              const Gap(20),
              SizedBox(
                height: 250,
                child: TabBarView(
                    controller: _tabController,
                    children: List.generate(
                      parkingController.parkingDetails.length,
                      (index) => SlotsGridView(
                          currentIndex: index,
                          parkingModel: parkingController.parkingDetails),
                    )),
              ),

              const Gap(20),
              CustomButton(
                text: tr(AppLocaleKey.reservation),
                onPressed: () {
                  Navigator.pop(context);
                  NavigatorMethods.showAppBottomSheet(
                    context,
                    const UserAddServiceBottomSheet(),
                    enableDrag: true,
                    isScrollControlled: true,
                  );
                },
              ),
              const Gap(10),
            ],
          ),
        ),
      );
    });
  }
}
