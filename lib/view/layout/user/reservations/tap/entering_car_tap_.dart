import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/images/app_images.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/networking/urls.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_image/custom_network_image.dart';
import 'package:valet_parking/view/layout/user/reservations/controller/reservation_controller.dart';
import 'package:valet_parking/view/layout/user/reservations/model/reservations_model.dart';
import 'package:valet_parking/view/layout/user/reservations/screen/entering_car_qr_code_screen.dart';

class EnteringCarTap extends StatelessWidget {
  final List<ReservationModel> reservationsModel;
  const EnteringCarTap({
    super.key,
    required this.reservationsModel,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ReservationController()
          ..initialReservation()
          ..getReservation();
      },
      child: Consumer<ReservationController>(
          builder: (context, revReservationController, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ApiResponseWidget(
            apiResponse: revReservationController.reservationsResponse,
            onReload: () => revReservationController.getReservation(),
            isEmpty: revReservationController.reservations.isEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  revReservationController.reservations.length,
                  (index) => Column(
                    children: [
                      const CustomNetworkImage(
                        width: double.infinity,
                        radius: 10,
                        fit: BoxFit.fill,
                        hasZoom: true,
                        imageUrl: Urls.testUserImage,
                      ),
                      const Gap(25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            revReservationController
                                .reservations[index].carModel,
                            style: AppTextStyle.textD18B(context),
                          ),
                        ),
                      ),
                      const Gap(15),
                      CustomButton(
                        onPressed: () {
                          NavigatorMethods.pushNamed(
                              context, MyReservationsQrCodeScreen.routeName);
                        },
                        text: tr(AppLocaleKey.codeAppearance),
                        style: AppTextStyle.textW16B(context),
                        suffixIcon: SvgPicture.asset(AppImages.arrowRightIcon),
                      ),
                      const Gap(15),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
