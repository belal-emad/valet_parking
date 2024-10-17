import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/helpers/utils/date_methods.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/custom_widgets/buttons/notification_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:valet_parking/view/custom_widgets/page_container/page_container.dart';
import 'package:valet_parking/view/layout/global/app_bottom_sheet/user_bottom_sheet.dart';
import 'package:valet_parking/view/layout/user/home/bottom_sheets/user_car_parked_successfully.dart';
import 'package:valet_parking/view/layout/user/home/controller/tickets_controller.dart';

// class MyReservationsQrCodeScreenArgs {
//  // final TicketsModel ticketsModel;

//   MyReservationsQrCodeScreenArgs({required this.ticketsModel});
// }

class MyReservationsQrCodeScreen extends StatelessWidget {
  // final MyReservationsQrCodeScreenArgs args;
  static const String routeName = 'MyReservationsQrCodeScreen';
  const MyReservationsQrCodeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TicketsController()
        ..initialTicketsDetails()
        ..getTickets(id: 206),
      child:
          Consumer<TicketsController>(builder: (context, ticketsController, _) {
        return PageContainer(
          child: Scaffold(
            appBar: CustomAppBar(
              automaticallyImplyLeading: true,
              context,
              title: Text(tr(AppLocaleKey.myReservations)),
              actions: const [
                Center(
                  child: NotificationButton(),
                ),
                Gap(10),
              ],
            ),
            body: ApiResponseWidget(
              apiResponse: ticketsController.ticketsDetailsResponse,
              onReload: () => ticketsController.getTickets(id: 206),
              isEmpty: ticketsController.ticketsDetails == null,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    const Gap(25),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.whiteFcColor(context),
                      ),
                      child: Column(
                        children: [
                          UserBottomSheet(
                            children: [
                              Center(
                                  child: Text(
                                tr(AppLocaleKey.scanQrCode),
                                textAlign: TextAlign.center,
                                style: AppTextStyle.textD16R(context),
                              )),
                              const Gap(20),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    NavigatorMethods.showAppBottomSheet(context,
                                        const UserCarParkedSuccessfully());
                                  },
                                  child: QrImageView(
                                    data: ticketsController.ticketsDetails?.id
                                            .toString() ??
                                        "",
                                    version: QrVersions.auto,
                                    size: 300,
                                  ),
                                ),
                              ),
                              const Gap(15),
                              Center(
                                child: Text(
                                  "Code : ${ticketsController.ticketsDetails?.id ?? ""}",
                                  style: AppTextStyle.textD16B(context),
                                ),
                              ),
                              const Gap(15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tr(AppLocaleKey.userName),
                                          style: AppTextStyle.textD14R(context,
                                              height: 2),
                                        ),
                                        Text(
                                          ticketsController
                                                  .ticketsDetails?.userName ??
                                              "",
                                          style: AppTextStyle.textD16B(context,
                                              height: 1.5),
                                        ),
                                        Text(
                                          tr(AppLocaleKey.parkingPlace),
                                          style: AppTextStyle.textD14R(context,
                                              height: 2),
                                        ),
                                        Text(
                                          ticketsController
                                                  .ticketsDetails?.slotTitle ??
                                              "",
                                          style: AppTextStyle.textD16B(context,
                                              height: 1.5),
                                        ),
                                        Text(
                                          tr(AppLocaleKey.date),
                                          style: AppTextStyle.textD14R(context,
                                              height: 2),
                                        ),
                                        Text(
                                          DateMethods.formatToDate(
                                            ticketsController.ticketsDetails
                                                    ?.createdAt ??
                                                "",
                                          ),
                                          style: AppTextStyle.textD16B(context,
                                              height: 1.5),
                                        ),
                                        Text(
                                          tr(AppLocaleKey.phone),
                                          style: AppTextStyle.textD14R(context,
                                              height: 2),
                                        ),
                                        Text(
                                          ticketsController
                                                  .ticketsDetails?.userMobile ??
                                              "",
                                          style: AppTextStyle.textD16B(context,
                                              height: 1.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tr(AppLocaleKey.typeOfCar),
                                          style: AppTextStyle.textD14R(context,
                                              height: 2),
                                        ),
                                        Text(
                                          ticketsController
                                                  .ticketsDetails?.carModel ??
                                              "",
                                          style: AppTextStyle.textD16B(context,
                                              height: 1.5),
                                        ),
                                        Text(
                                          tr(AppLocaleKey.attachment),
                                          style: AppTextStyle.textD14R(context,
                                              height: 2),
                                        ),
                                        Text(
                                          ticketsController.ticketsDetails
                                                  ?.categoryTypeTitle ??
                                              "",
                                          style: AppTextStyle.textD16B(context,
                                              height: 1.5),
                                        ),
                                        Text(
                                          tr(AppLocaleKey.duration),
                                          style: AppTextStyle.textD14R(context,
                                              height: 2),
                                        ),
                                        Text(
                                          '4 hours',
                                          style: AppTextStyle.textD16B(context,
                                              height: 1.5),
                                        ),
                                        Text(
                                          tr(AppLocaleKey.theHour),
                                          style: AppTextStyle.textD14R(context,
                                              height: 2),
                                        ),
                                        Text(
                                          '9:00 AM',
                                          style: AppTextStyle.textD16B(context,
                                              height: 1.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
