import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/helpers/theme/style.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_form_field/custom_form_field.dart';

import 'package:valet_parking/view/layout/global/app_bottom_sheet/user_bottom_sheet.dart';
import 'package:valet_parking/view/layout/worker/home/bottom_sheet/add_car_details_bottom_sheet.dart';
import 'package:valet_parking/view/layout/worker/qr_code_scan/controller/qr_code_scan_controller.dart';
import 'package:valet_parking/view/layout/worker/qr_code_scan/screen/valid_scanner_code_screen.dart';
import 'package:valet_parking/view/layout/worker/qr_code_scan/widget/qr_code_scan_widget.dart';

class QrCodeScannerBottomSheet extends StatefulWidget {
  final bool? comeIsEntryANewCar;
  const QrCodeScannerBottomSheet({super.key, this.comeIsEntryANewCar});

  @override
  State<QrCodeScannerBottomSheet> createState() =>
      _QrCodeScannerBottomSheetState();
}

class _QrCodeScannerBottomSheetState extends State<QrCodeScannerBottomSheet> {
  String? result;
  final _idTicket = TextEditingController();
  QRViewController? controller;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: UserBottomSheet(children: [
        Center(
          child: Text(
            tr(AppLocaleKey.scanTheQRCode),
            style: AppTextStyle.textD18B(context),
          ),
        ),
        const Gap(8),
        Text(
          tr(AppLocaleKey.alignTheQRCodeWithinAFrameForScanning),
          style: AppTextStyle.textL14B(context),
          textAlign: TextAlign.center,
        ),
        const Gap(13),
        Container(
          height: 400,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              boxShadow: appShadow,
              color: AppColor.scaffoldColor(context)),
          child: Column(
            children: [
              Expanded(
                  child: QrCodeScanWidget(onQRViewCreated: _onQRViewCreated)),
              const Gap(10),
              Text(
                tr(AppLocaleKey.orEnterYourUniqueIDbelow),
                style: AppTextStyle.textL14B(context),
              ),
              const Gap(10),
              CustomFormField(
                controller: _idTicket,
                keyboardType: TextInputType.number,
                fillColor: AppColor.whiteColor(context),
              ),
            ],
          ),
        ),
        Column(
          children: [
            const Gap(10),
            if (result != null || _idTicket.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CustomButton(
                  onPressed: () {
                    context.read<QrCodeScanController>().setTicketId =
                        int.parse(result ?? _idTicket.text);
                    log(context
                        .read<QrCodeScanController>()
                        .ticketId
                        .toString());

                    widget.comeIsEntryANewCar == true
                        ? NavigatorMethods.showAppBottomSheet(
                            context,
                            enableDrag: true,
                            isScrollControlled: true,
                            const AddCarDetailsBottomSheet(),
                          )
                        : context
                            .read<QrCodeScanController>()
                            .exitCodeDeliveryCar(
                                ticketId: int.parse(result ?? _idTicket.text),
                                onSuccess: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, ValidScannerCodeScreen.routeName,
                                      arguments: ValidScanCodeArgs(
                                          ticketId: int.parse(
                                              result ?? _idTicket.text)));
                                });
                  },
                  text: tr(AppLocaleKey.verification),
                ),
              ),
          ],
        )
      ]),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code;
      });
      log(result.toString());
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
