import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/layout/global/auth/controller/auth_controller.dart';
import 'package:valet_parking/view/layout/user/home/controller/category_controller.dart';
import 'package:valet_parking/view/layout/worker/home/bottom_sheet/add_images_bottom_sheet.dart';
import 'package:valet_parking/view/layout/worker/home/widget/worker_slots_grid_view_widget.dart';
import 'package:valet_parking/view/layout/worker/qr_code_scan/controller/qr_code_scan_controller.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../global/app_bottom_sheet/user_bottom_sheet.dart';


class WorkerParkingLocationBottomSheet extends StatefulWidget {
  const WorkerParkingLocationBottomSheet({
    super.key,
  });

  @override
  State<WorkerParkingLocationBottomSheet> createState() =>
      _WorkerParkingLocationBottomSheetState();
}

class _WorkerParkingLocationBottomSheetState
    extends State<WorkerParkingLocationBottomSheet> {
  TabController? _tabController;
  int currentIndex = -1;
  bool isSelected = false;
  @override
 

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) { 
        return CategoryController()..initialCategories()..getCategories(user:context.read<AuthController>().profileModel!.id );
       },
      child: Consumer<CategoryController>(
          builder: (context, categoryController, _) {
        return ApiResponseWidget(
          apiResponse: categoryController.categoriesResponse,
          isEmpty: categoryController.categories.isEmpty,
          onReload: () => categoryController.getCategories(user:context.read<AuthController>().profileModel!.id ),
          child: DefaultTabController(
            length: categoryController.categories.length,
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
                    setState(() {
                      
                    });
                    currentIndex = value;
                    context.read<QrCodeScanController>().setGateId =
                        categoryController.categories[value].gates!.id!;
                    log("${context.read<QrCodeScanController>().gateId}");
                  },
                  indicatorColor: Colors.transparent,
                
      
                  controller: _tabController,
                  tabs: List.generate(
                      categoryController.categories.length,
                      (index) => CustomButton(
                            color: currentIndex == index
                                ? AppColor.mainAppColor(context)
                                : AppColor.whiteFcColor(context),
                            radius: 20,
                            borderColor: AppColor.mainAppColor(context),
                            borderWidth: 2,
                            text: categoryController.categories[index].title ??
                                "",
                            style: currentIndex == index
                                ? AppTextStyle.textW16B(context)
                                : AppTextStyle.textM16B(context),
                          )),
                ),
           
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
                        categoryController.categories.length,
                        (index) => WorkerSlotsGridViewWidget(
                            currentIndex: index,
                            categoryModel: categoryController.categories),
                      )),
                ),
      
                const Gap(20),
                CustomButton(
                  text: tr(AppLocaleKey.reservation),
                  onPressed: () {
                    Navigator.pop(context);
                    NavigatorMethods.showAppBottomSheet(context, const AddImagesBottomSheet(),isScrollControlled: true ,enableDrag: true);
                  },
                ),
                const Gap(10),
              ],
            ),
          ),
        );
      }),
    );
  }
}