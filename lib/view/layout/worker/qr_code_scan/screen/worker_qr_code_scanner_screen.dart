import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/theme/style.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/custom_app_bar/worker_app_bar.dart';
import '../../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../global/auth/controller/auth_controller.dart';
import '../controller/qr_code_scan_controller.dart';
import '../widget/qr_code_scan_widget.dart';
import 'valid_scanner_code_screen.dart';
import 'worker_add_image_screen.dart';

class WorkerQrCodeScannerScreen extends StatefulWidget {
  final bool comeEntryCarRequests;
  static const String routeName = 'WorkerQrCodeScannerScreen';

  const WorkerQrCodeScannerScreen({
    super.key,
    this.comeEntryCarRequests = true,
  });

  @override
  State<StatefulWidget> createState() => _WorkerQrCodeScannerScreenState();
}

class _WorkerQrCodeScannerScreenState extends State<WorkerQrCodeScannerScreen> {
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
    return Scaffold(
      appBar: WorkerAppBar(
        context,
        showIconSearch: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  tr(AppLocaleKey.carParkingAt),
                  style: AppTextStyle.textD24B(context),
                ),
                const Gap(5),
                Flexible(
                  child: Text(
                    context
                        .read<AuthController>()
                        .profileModel!
                        .valetCategory
                        .toString(),
                    style: AppTextStyle.textS24B(context),
                  ),
                ),
              ],
            ),
            const Gap(18),
            Text(
              tr(AppLocaleKey.scanTheQRCode),
              style: AppTextStyle.textD18B(context),
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
                    child: QrCodeScanWidget(onQRViewCreated: _onQRViewCreated),
                  ),
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
                        widget.comeEntryCarRequests
                            ? NavigatorMethods.pushNamed(
                                context, WorkerAddImageScreen.routeName,
                                arguments: WorkerAddImageArgc(
                                    idTicket:
                                        int.parse(result ?? _idTicket.text)))
                            : context
                                .read<QrCodeScanController>()
                                .exitCodeDeliveryCar(
                                    ticketId:
                                        int.parse(result ?? _idTicket.text),
                                    onSuccess: () {
                                      Navigator.pushNamed(context,
                                          ValidScannerCodeScreen.routeName);
                                    });
                      },
                      text: tr(AppLocaleKey.verification),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
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
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
