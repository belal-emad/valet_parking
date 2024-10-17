import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/images/app_images.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/networking/urls.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_image/custom_network_image.dart';
import 'package:valet_parking/view/layout/user/reservations/borrom_sheet/stop_receiving_car_bottom_sheet.dart';
import 'package:valet_parking/view/layout/user/reservations/controller/reservation_controller.dart';
import 'package:valet_parking/view/layout/user/reservations/model/reservations_model.dart';
import 'package:valet_parking/view/layout/user/reservations/screen/details_screen.dart';

class ReceivingACarTap extends StatefulWidget {
  final List<ReservationModel> reservationsModel;
  const ReceivingACarTap({super.key, required this.reservationsModel});

  @override
  State<ReceivingACarTap> createState() => _ReceivingACarTapState();
}

class _ReceivingACarTapState extends State<ReceivingACarTap> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ReservationController()
          ..initialReceivingCar()
          ..getReceivingCar();
      },
      child: Consumer<ReservationController>(
          builder: (context, reservationController, _) {
        return ApiResponseWidget(
          apiResponse: reservationController.receivingCarResponse,
          onReload: () => reservationController.getReceivingCar(),
          isEmpty: reservationController.receivingCar.isEmpty,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                ...List.generate(
                  reservationController.receivingCar.length,
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            reservationController.receivingCar[index].carModel,
                            style: AppTextStyle.textD18B(context),
                          ),
                        ),
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                NavigatorMethods.showAppBottomSheet(
                                  context,
                                  const StopReceivingCarBottomSheet(),
                                );
                              },
                              text: tr(AppLocaleKey.receivingACar),
                              suffixIcon:
                                  SvgPicture.asset(AppImages.arrowRightIcon),
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            child: CustomButton(
                              gradient: LinearGradient(
                                colors: [
                                  AppColor.grid1Color(context),
                                  AppColor.grid2Color(context),
                                ],
                              ),
                              onPressed: () {
                                NavigatorMethods.pushNamed(
                                  context,
                                  DetailsScreen.routeName,
                                  arguments: DetailsScreenArgs(
                                    reservationModel: reservationController
                                        .receivingCar[index],
                                  ),
                                );
                              },
                              color: AppColor.lightGreyColor(context),
                              text: tr(AppLocaleKey.details),
                              style: AppTextStyle.textM16B(context),
                            ),
                          ),
                        ],
                      ),
                      const Gap(25),
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
