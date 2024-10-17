import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/layout/global/app_bottom_sheet/user_bottom_sheet.dart';
import 'package:valet_parking/view/layout/user/home/bottom_sheets/user_car_parked_successfully.dart';
import 'package:valet_parking/view/layout/user/home/controller/tickets_controller.dart';

class UserQrCodeBottomSheet extends StatelessWidget {
  const UserQrCodeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TicketsController()..getTickets(id: 206),
      child: Consumer<TicketsController>(
          builder: (context, ticketsController, _) => ApiResponseWidget(
              apiResponse: ticketsController.ticketsDetailsResponse,
              onReload: () => ticketsController.getTickets(id: 206),
              isEmpty: ticketsController.ticketsDetails == null,
              child: UserBottomSheet(
                children: [
                  Center(
                      child: Text(
                    tr(AppLocaleKey.scanQrCode),
                    textAlign: TextAlign.center,
                    style: AppTextStyle.textD16R(context),
                  )),
                  const Gap(50),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        NavigatorMethods.showAppBottomSheet(
                            context, const UserCarParkedSuccessfully());
                      },
                      child: QrImageView(
                        data: ticketsController.ticketsDetails?.id.toString() ??
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
                ],
              ))),
    );
  }
}
