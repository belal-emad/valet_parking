import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/theme/style.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../../custom_widgets/buttons/notification_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../home/controller/tickets_controller.dart';
import '../services_bottom_sheet/services_bottom_sheet.dart';

class UserServicesScreen extends StatefulWidget {
  const UserServicesScreen({super.key});

  @override
  State<UserServicesScreen> createState() => _UserServicesScreenState();
}

class _UserServicesScreenState extends State<UserServicesScreen> {
  String? selectedValue;
  int selectedCarIndex = -1;
  String? selectedCarId;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TicketsController()
        ..initialServicesTicketsDetails()
        ..getServicesTickets(),
      child: Consumer<TicketsController>(
        builder: (context, ticketsController, child) => ApiResponseWidget(
          apiResponse: ticketsController.servicesTicketsDetailsResponse,
          onReload: () => ticketsController.getServicesTickets(),
          isEmpty: ticketsController.servicesTicketsDetails.isEmpty,
          child: Scaffold(
            appBar: CustomAppBar(
              context,
              title: Text(tr(AppLocaleKey.services)),
              actions: const [
                Center(
                  child: NotificationButton(),
                ),
                Gap(10),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  ...List.generate(
                    ticketsController.servicesTicketsDetails.length,
                    (index) => Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCarIndex = index;
                              selectedValue = ticketsController
                                  .servicesTicketsDetails[index].id
                                  .toString();
                              // log(widget.currentIndex.toString());
                              ticketsController
                                  .servicesTicketsDetails[index].id;
                              // parkingController.setUserCarId =
                              //     carController.cars[index].id!;
                              // log(" userCard = ${parkingController.userCarId}");
                              //  widget.onChange(widget.car.id.toString());
                            });
                            NavigatorMethods.showAppBottomSheet(
                              context,
                              enableDrag: true,
                              isScrollControlled: true,
                              const ServicesUserBottomSheet(),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor(context),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: appShadow),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 21),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppImages.carRequestImage,
                                      fit: BoxFit.fill,
                                      width: 70,
                                    ),
                                    const Gap(35),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          ticketsController
                                                  .servicesTicketsDetails[index]
                                                  .carModel ??
                                              "",
                                          style: AppTextStyle.textD18B(context),
                                        ),
                                        Text(
                                          ticketsController
                                                  .servicesTicketsDetails[index]
                                                  .carPlate ??
                                              "",
                                          style: AppTextStyle.textL16R(
                                            context,
                                            height: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(15)
                      ],
                    ),

                    // Column(
                    //   children: [

                    //     Gap(10),
                    //   ],
                    // ),
                  ),
                  const Gap(100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
