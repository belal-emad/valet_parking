import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/custom_widgets/buttons/notification_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:valet_parking/view/layout/user/reservations/controller/reservation_controller.dart';
import 'package:valet_parking/view/layout/user/reservations/widgets/previous_reservation_history_widget.dart';

class PreviousReservationHistoryScreen extends StatelessWidget {
  static const String routeName = 'HistoryOfPreviousBookingsScreen';

  const PreviousReservationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ReservationController()
          ..initialReservationHistory()
          ..getReservationHistory();
      },
      child: Consumer<ReservationController>(
          builder: (context, reservationController, _) {
        return Scaffold(
          appBar: CustomAppBar(
            automaticallyImplyLeading: true,
            context,
            title: Text(tr(AppLocaleKey.historyOfPreviousReservations)),
            actions: const [
              Center(
                child: NotificationButton(),
              ),
              Gap(10),
            ],
          ),
          body: ApiResponseWidget(
            apiResponse: reservationController.reservationsHistoryResponse,
            onReload: () => reservationController.getReservationHistory(),
            isEmpty: reservationController.reservationsHistory.isEmpty,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    reservationController.reservationsHistory.length,
                    (index) => Column(
                      children: [
                        PreviousReservationHistoryWidget(
                          reservationsHistoryModel:
                              reservationController.reservationsHistory[index],
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
