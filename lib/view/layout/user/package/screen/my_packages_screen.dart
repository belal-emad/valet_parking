import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/buttons/notification_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import '../bottom_sheet/stop_pacakges_bottom_sheet.dart';
import '../controller/package_controller.dart';
import '../widgets/circular_slider_widget.dart';

class MyPackagesScreen extends StatefulWidget {
  static const String routeName = 'MyPackagesScreen';
  const MyPackagesScreen({super.key});

  @override
  State<MyPackagesScreen> createState() => _MyPackagesScreenState();
}

class _MyPackagesScreenState extends State<MyPackagesScreen> {
  DateTime? createdAt;
  DateTime? expireAt;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return PackageController()
          ..initialMyPackage()
          ..getMyPackages();
      },
      child: PageContainer(
        child: Scaffold(
          appBar: CustomAppBar(
            context,
            automaticallyImplyLeading: true,
            title: Text(
              tr(AppLocaleKey.myPackages),
            ),
            actions: const [
              Center(child: NotificationButton()),
              Gap(20),
            ],
          ),
          body: Consumer<PackageController>(
              builder: (context, packageController, _) {
            return ApiResponseWidget(
              apiResponse: packageController.mypackagesResponse,
              onReload: () => packageController.getMyPackages(),
              isEmpty: packageController.myPackages.isEmpty,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(30),
                    Text(
                      tr(
                        AppLocaleKey.myPackages,
                      ),
                      style: AppTextStyle.textD18B(context),
                    ),
                    const Gap(15),
                    ...List.generate(
                      packageController.myPackages.length,
                      (index) => Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                width: 185,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColor.mainAppColor(context),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const Gap(10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.numberUsingIcon,
                                        ),
                                        const Gap(10),
                                        Text(
                                          tr(
                                            AppLocaleKey.useTimes,
                                          ),
                                          style: AppTextStyle.textG14B(context),
                                        ),
                                        const Gap(10),
                                        Text(
                                          packageController
                                              .myPackages[index].noUsed
                                              .toString(),
                                          style: AppTextStyle.textG20B(context),
                                        )
                                      ],
                                    ),
                                    const Gap(15),
                                    Divider(
                                      thickness: 1,
                                      color: AppColor.mainAppColor(context),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.timeUseIcon,
                                        ),
                                        const Gap(10),
                                        Text(
                                          tr(
                                            AppLocaleKey.downtimeDuration,
                                          ),
                                          style: AppTextStyle.textS14B(context),
                                        ),
                                        const Gap(10),
                                        Text(
                                          packageController
                                              .myPackages[index].daysStopped
                                              .toString(),
                                          style: AppTextStyle.textS20B(context),
                                        )
                                      ],
                                    ),
                                    const Gap(15),
                                  ],
                                ),
                              ),
                              const Gap(20),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * .5,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColor.mainAppColor(context),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Gap(10),
                                      Text(
                                        tr(
                                          AppLocaleKey.consumption,
                                        ),
                                        style: AppTextStyle.textW16R(context),
                                      ),
                                      CircularSliderWidget(
                                        daysValue: daysValue(
                                          createdAtString: packageController
                                              .myPackages[index].createdAt
                                              .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(15),
                          isPackageExpire(
                                  expireAt: packageController
                                      .myPackages[index].expireAt
                                      .toString())
                              ? const SizedBox()
                              : Text(
                                  tr(AppLocaleKey
                                      .itIsPossibleToStopUsingThePackageFor10ConsecutiveOrSeparateDays),
                                  style: AppTextStyle.textD14B(context),
                                ),
                          const Gap(30),
                          isPackageExpire(
                                  expireAt: packageController
                                      .myPackages[index].expireAt
                                      .toString())
                              ? const SizedBox()
                              : CustomButton(
                                  gradient: LinearGradient(colors: [
                                    AppColor.grid1Color(context),
                                    AppColor.grid2Color(context),
                                  ]),
                                  onPressed: () {
                                    NavigatorMethods.showAppBottomSheet(
                                        context,
                                        StopPackagesBottomSheet(
                                            packagesModel: packageController
                                                .myPackages[index],
                                            onSuccess: () {
                                              packageController.getMyPackages();
                                            }),
                                        isScrollControlled: true,
                                        enableDrag: true);
                                  },
                                  text: tr(
                                    packageController
                                                .myPackages[index].status ==
                                            "active"
                                        ? AppLocaleKey.stopUsingThePackage
                                        : AppLocaleKey.resumeUsingThePackage,
                                  ),
                                ),
                          const Gap(25)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  int daysValue({String? createdAtString}) {
    DateTime createdAt = DateTime.parse(createdAtString!);
    DateTime now = DateTime.now();

    Duration difference = now.difference(createdAt);
    return difference.inDays;
  }

  bool isPackageExpire({required String expireAt}) {
    bool isExpire = true;
    DateTime currentDate = DateTime.now();
    DateTime targetDate = DateTime.parse(expireAt);
    if (currentDate.isAfter(targetDate)) {
      return isExpire;
    } else {
      return !isExpire;
    }
  }
}
