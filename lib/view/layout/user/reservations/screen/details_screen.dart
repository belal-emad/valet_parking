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
import 'package:valet_parking/helpers/utils/date_methods.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/custom_widgets/buttons/notification_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:valet_parking/view/custom_widgets/custom_image/custom_network_image.dart';
import 'package:valet_parking/view/custom_widgets/page_container/page_container.dart';
import 'package:valet_parking/view/layout/user/reservations/controller/reservation_controller.dart';
import 'package:valet_parking/view/layout/user/reservations/model/reservations_model.dart';

class DetailsScreenArgs {
  final ReservationModel reservationModel;

  DetailsScreenArgs({required this.reservationModel});
}

class DetailsScreen extends StatefulWidget {
  static const String routeName = 'DetailsScreen';
  final DetailsScreenArgs args;
  const DetailsScreen({
    super.key,
    required this.args,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool? _isChecked;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReservationController()
        ..initialReservation()
        ..getReservationDetails(id: widget.args.reservationModel.id),
      child: PageContainer(
        child: Scaffold(
          appBar: CustomAppBar(
            automaticallyImplyLeading: true,
            context,
            title: Text(tr(AppLocaleKey.details)),
            actions: const [
              Center(
                child: NotificationButton(),
              ),
              Gap(10),
            ],
          ),
          body: Consumer<ReservationController>(
              builder: (context, reservationController, _) {
            return ApiResponseWidget(
              apiResponse: reservationController.reservationDetailsResponse,
              isEmpty: reservationController.reservationsDetails == null,
              onReload: () => reservationController.getReservationDetails(
                  id: widget.args.reservationModel.id),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomNetworkImage(
                      width: double.infinity,
                      radius: 10,
                      fit: BoxFit.fill,
                      hasZoom: true,
                      imageUrl: Urls.testUserImage,
                    ),
                    const Gap(25),
                    Text(
                      widget.args.reservationModel.carModel,
                      style: AppTextStyle.textD18B(context),
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: reservationController
                                    .reservationsDetails?.categoryTypeTitle ??
                                "",
                            style: AppTextStyle.textM16B(context),
                            radius: 100,
                            borderColor: AppColor.mainAppColor(context),
                            color: AppColor.whiteColor(context),
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: CustomButton(
                            style: AppTextStyle.textM16B(context),
                            text: reservationController
                                    .reservationsDetails?.carColor ??
                                "",
                            radius: 100,
                            borderColor: AppColor.mainAppColor(context),
                            color: AppColor.whiteColor(context),
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: CustomButton(
                            style: AppTextStyle.textM16B(context),
                            text: reservationController
                                    .reservationsDetails?.carPlate ??
                                "",
                            radius: 100,
                            borderColor: AppColor.mainAppColor(context),
                            color: AppColor.whiteColor(context),
                          ),
                        ),
                      ],
                    ),
                    const Gap(15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr(AppLocaleKey.userName),
                              style: AppTextStyle.textD14R(context, height: 2),
                            ),
                            Text(
                              reservationController
                                      .reservationsDetails?.userName ??
                                  "",
                              style:
                                  AppTextStyle.textD16B(context, height: 1.5),
                            ),
                            Text(
                              tr(AppLocaleKey.parkingPlace),
                              style: AppTextStyle.textD14R(context, height: 2),
                            ),
                            Text(
                              reservationController
                                      .reservationsDetails?.slotTitle ??
                                  "",
                              style:
                                  AppTextStyle.textD16B(context, height: 1.5),
                            ),
                            Text(
                              tr(AppLocaleKey.date),
                              style: AppTextStyle.textD14R(context, height: 2),
                            ),
                            Text(
                              DateMethods.formatToDate(reservationController
                                      .reservationsDetails?.createdAt ??
                                  ""),
                              style:
                                  AppTextStyle.textD16B(context, height: 1.5),
                            ),
                            Text(
                              tr(AppLocaleKey.requiredServices),
                              style: AppTextStyle.textD14R(context, height: 2),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  tristate: true,
                                  activeColor: AppColor.mainAppColor(context),
                                  value: _isChecked,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _isChecked = value;
                                      },
                                    );
                                  },
                                ),
                                ...List.generate(
                                  reservationController.reservationsDetails
                                          ?.services.length ??
                                      0,
                                  (index) => SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text(
                                          reservationController
                                                  .reservationsDetails
                                                  ?.services[index]
                                                  .serviceTitle ??
                                              "",
                                          style: AppTextStyle.textD16B(context),
                                        ),
                                        const Gap(10),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tr(AppLocaleKey.typeOfCar),
                                style:
                                    AppTextStyle.textD14R(context, height: 2),
                              ),
                              Text(
                                reservationController
                                        .reservationsDetails?.carModel ??
                                    "",
                                style:
                                    AppTextStyle.textD16B(context, height: 1.5),
                              ),
                              Text(
                                tr(AppLocaleKey.attachment),
                                style:
                                    AppTextStyle.textD14R(context, height: 2),
                              ),
                              Text(
                                reservationController
                                        .reservationsDetails?.categoryTitle ??
                                    "",
                                style:
                                    AppTextStyle.textD16B(context, height: 2),
                              ),
                              Text(
                                tr(AppLocaleKey.phone),
                                style:
                                    AppTextStyle.textD14R(context, height: 1.5),
                              ),
                              const Gap(10),
                              Text(
                                reservationController
                                        .reservationsDetails?.userMobile ??
                                    "",
                                style: AppTextStyle.textD16B(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
                      gradient: LinearGradient(colors: [
                        AppColor.grid1Color(context),
                        AppColor.grid2Color(context),
                      ]),
                      radius: 10,
                      text: tr(AppLocaleKey.receivingACar),
                      suffixIcon: SvgPicture.asset(AppImages.arrowRightIcon),
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
}
