import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/networking/urls.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/theme/style.dart';
import '../../../../../helpers/utils/date_methods.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/custom_app_bar/worker_app_bar.dart';
import '../../../../custom_widgets/custom_image/custom_network_image.dart';
import '../../bottom_navigation/worker_bottom_navigation_bar_screen.dart';
import '../controller/qr_code_scan_controller.dart';

class ValidScanCodeArgs {
  final int ticketId;
  ValidScanCodeArgs({required this.ticketId});
}

class ValidScannerCodeScreen extends StatefulWidget {
  static const String routeName = 'ValidScannerCodeScreen';
  final ValidScanCodeArgs args;
  const ValidScannerCodeScreen({super.key, required this.args});

  @override
  ValidScannerCodeScreenState createState() => ValidScannerCodeScreenState();
}

class ValidScannerCodeScreenState extends State<ValidScannerCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return QrCodeScanController()
          ..initialValidScanCode()
          ..getValidScan(ticketId: widget.args.ticketId);
      },
      child: Scaffold(
        appBar: WorkerAppBar(
          context,
          showIconSearch: false,
        ),
        body: Consumer<QrCodeScanController>(
            builder: (context, qrCodeScanController, _) {
          return ApiResponseWidget(
            apiResponse: qrCodeScanController.validScanResponse,
            isEmpty: qrCodeScanController.validScanCode == null,
            onReload: () => qrCodeScanController.getValidScan(
                ticketId: widget.args.ticketId),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  const Gap(20),
                  Center(
                    child: Text(
                      tr(AppLocaleKey.scanTheQRCode),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Gap(50),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: appShadow,
                      color: AppColor.whiteColor(context),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(AppImages.packageCheckIcon),
                        const Gap(10),
                        Text(
                          tr(AppLocaleKey.validScannerCode),
                          style: AppTextStyle.textD18B(context),
                        ),
                        const Gap(10),
                        Container(
                          width: 77,
                          height: 77,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.greyColor(context),
                              width: 3,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const CustomNetworkImage(
                            imageUrl: Urls.testUserImage,
                            width: 74,
                            height: 74,
                            radius: 37,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Gap(
                          10,
                        ),
                        Text(
                          qrCodeScanController.validScanCode?.categoryTitle ??
                              "",
                          style: AppTextStyle.textD16B(context),
                        ),
                        const Gap(10),
                        Text(
                          qrCodeScanController
                                  .validScanCode?.ticketIdentifier ??
                              "",
                          style: AppTextStyle.textD16B(context),
                        ),
                        const Gap(10),
                        Text(
                          tr(AppLocaleKey.bookingDetails),
                          style: AppTextStyle.textD16B(context),
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr(AppLocaleKey.userName),
                                    style: AppTextStyle.textL14R(context),
                                  ),
                                  const Gap(10),
                                  Text(
                                    qrCodeScanController
                                            .validScanCode?.userName ??
                                        "",
                                    style: AppTextStyle.textD14B(context),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr(AppLocaleKey.phone),
                                    style: AppTextStyle.textL14R(context),
                                  ),
                                  const Gap(10),
                                  Text(
                                    qrCodeScanController
                                            .validScanCode?.userMobile ??
                                        "",
                                    style: AppTextStyle.textD14B(context),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Gap(15),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr(AppLocaleKey.parkingPlace),
                                    style: AppTextStyle.textL14R(context),
                                  ),
                                  const Gap(10),
                                  Text(
                                    '${qrCodeScanController.validScanCode?.gateTitle ?? ""}  ${qrCodeScanController.validScanCode?.slotTitle ?? ""}',
                                    style: AppTextStyle.textD14B(context),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr(AppLocaleKey.facility),
                                    style: AppTextStyle.textL14R(context),
                                  ),
                                  const Gap(10),
                                  Text(
                                    qrCodeScanController
                                            .validScanCode?.categoryTypeTitle ??
                                        "",
                                    style: AppTextStyle.textD14B(context),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Gap(15),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr(AppLocaleKey.dateOfServiceRequest),
                                    style: AppTextStyle.textL14R(context),
                                  ),
                                  const Gap(10),
                                  Text(
                                    DateMethods.formatToDate(
                                        qrCodeScanController
                                                .validScanCode?.createdAt ??
                                            ""),
                                    style: AppTextStyle.textD14B(context),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tr(AppLocaleKey.theHour),
                                    style: AppTextStyle.textL14R(context),
                                  ),
                                  const Gap(10),
                                  Text(
                                    DateMethods.formatToTime(
                                        qrCodeScanController
                                                .validScanCode?.createdAt ??
                                            ""),
                                    style: AppTextStyle.textD14B(context),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            Text(tr(AppLocaleKey.total),
                                style: AppTextStyle.textL14R(context)),
                            const Gap(40),
                            Text(
                              '200 ريال',
                              style: AppTextStyle.textD14B(context),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const Gap(40),
                  CustomButton(
                    onPressed: () {
                      NavigatorMethods.pushNamedAndRemoveUntil(
                          context, WorkerBottomNavigationBarScreen.routeName);
                    },
                    text: tr(AppLocaleKey.theCarHasBeenDelivered),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
