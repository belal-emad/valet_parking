import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/extension/context_extension.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/buttons/notification_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:valet_parking/view/custom_widgets/page_container/page_container.dart';
import 'package:valet_parking/view/layout/user/reservations/controller/reservation_controller.dart';
import 'package:valet_parking/view/layout/user/reservations/tap/entering_car_tap_.dart';
import 'package:valet_parking/view/layout/user/reservations/tap/receiving_car_tap.dart';

class MyReservations extends StatefulWidget {
  static const String routeName = 'MyReservationsScreen';
  const MyReservations({super.key});

  @override
  State<MyReservations> createState() => _MyReservationsState();
}

class _MyReservationsState extends State<MyReservations>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReservationController()
        ..initialReservation()
        ..getReservation(),
      child: PageContainer(
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
          body: Consumer<ReservationController>(
            builder: (context, reservationController, _) {
              return Column(
                children: [
                  const Gap(10),
                  SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TabBar(
                        labelColor: AppColor.secondAppColor(context),
                        unselectedLabelColor: AppColor.hintColor(context),
                        labelStyle: AppTextStyle.textD18B(context).copyWith(
                          fontFamily: context.fontFamily(),
                        ),
                        unselectedLabelStyle:
                            AppTextStyle.textD16B(context).copyWith(
                          fontFamily: context.fontFamily(),
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        controller: _controller,
                        tabs: [
                          Tab(
                            text: tr(
                              AppLocaleKey.enteringACar,
                            ),
                          ),
                          Tab(
                            text: tr(AppLocaleKey.receivingACar),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        EnteringCarTap(
                            reservationsModel:
                                reservationController.reservations),
                        ReceivingACarTap(
                          reservationsModel: reservationController.receivingCar,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
