import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/buttons/notification_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../payment/screen/user_choose_payment_methods_screen.dart';
import '../controller/package_controller.dart';
import '../model/package_model.dart';
import '../widgets/user_package_type_list.dart';

class PackageDetailsArgs {
  final PackageModel packageModel;

  PackageDetailsArgs({required this.packageModel});
}

class UserPackagesDetailsScreen extends StatefulWidget {
  static const String routeName = 'UserPackagesDetailsScreen';
  final PackageDetailsArgs args;

  const UserPackagesDetailsScreen({super.key, required this.args});

  @override
  State<UserPackagesDetailsScreen> createState() =>
      _UserPackagesDetailsScreenState();
}

class _UserPackagesDetailsScreenState extends State<UserPackagesDetailsScreen> {
  final List<int?> _selectedPackage = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return PackageController()
          ..initialDetailsPackage()
          ..getDetailsPackage(id: widget.args.packageModel.id!);
      },
      child: Scaffold(
        appBar: CustomAppBar(
          context,
          automaticallyImplyLeading: true,
          title: Text(tr(AppLocaleKey.packageDetails)),
          actions: const [
            Center(
              child: NotificationButton(),
            ),
            Gap(10),
          ],
        ),
        body: Consumer<PackageController>(
            builder: (context, packageController, _) {
          return ApiResponseWidget(
            apiResponse: packageController.detailsPackageResponse,
            isEmpty: packageController.detailsPackage == null,
            onReload: () => packageController.getDetailsPackage(
                id: widget.args.packageModel.id!),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            packageController.detailsPackage?.title
                                    .toString() ??
                                "",
                            style: AppTextStyle.textD18B(context),
                          )),
                      const Gap(15),
                      DefaultTextStyle(
                        style: AppTextStyle.textD18R(context),
                        child: HtmlWidget(
                          packageController.detailsPackage?.description ?? "",
                        ),
                      ),
                      const Gap(20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            packageController
                                    .detailsPackage?.packagePrices?.length ??
                                0,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: PackageTypeList(
                                price: packageController.detailsPackage
                                        ?.packagePrices?[index].price ??
                                    "",
                                title: packageController.detailsPackage
                                        ?.packagePrices?[index].name ??
                                    "",
                                onTap: () {
                                  if (_selectedPackage.contains(
                                    packageController.detailsPackage
                                        ?.packagePrices?[index].id,
                                  )) {
                                    _selectedPackage.remove(
                                      packageController.detailsPackage
                                          ?.packagePrices?[index].id,
                                    );
                                    setState(() {
                                      bool isSelected =
                                          _selectedPackage.contains(
                                        packageController.detailsPackage
                                            ?.packagePrices?[index].id,
                                      );
                                      isSelected = !isSelected;
                                    });
                                  } else {
                                    _selectedPackage.add(
                                      packageController.detailsPackage
                                          ?.packagePrices?[index].id,
                                    );
                                    setState(() {});
                                  }

                                  // if (_selectedPackage.contains(
                                  //   packageController.detailsPackage
                                  //       ?.packagePrices?[index].id,
                                  // )) {
                                  //   _selectedPackage.remove(
                                  //     packageController.detailsPackage
                                  //         ?.packagePrices?[index].id,
                                  //   );
                                  //   setState(() {});
                                  // } else {
                                  //   _selectedPackage.add(
                                  //     packageController.detailsPackage
                                  //         ?.packagePrices?[index].id,
                                  //   );
                                  //   setState(() {});
                                  // }
                                },
                                isSelected: _selectedPackage.contains(
                                  packageController
                                      .detailsPackage?.packagePrices?[index].id,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(20),
                      CustomButton(
                        onPressed: () {
                          if (_selectedPackage.isNotEmpty) {
                            context
                                .read<PackageController>()
                                .subscribeToPackage(
                                    packageId: packageController
                                        .detailsPackage!.id!
                                        .toInt(),
                                    packageType:
                                        _selectedPackage.firstOrNull ?? 0,
                                    onSuccess: () {
                                      NavigatorMethods.pushNamed(context,
                                          UserChoosePaymentMethods.routeName);
                                    });
                          }
                        },
                        suffixIcon: SvgPicture.asset(
                            AppImages.subscribePackageArrowIcon),
                        text: tr(AppLocaleKey.subscribeToThePackage),
                      )
                    ]),
              ),
            ),
          );
        }),
      ),
    );
  }
}
