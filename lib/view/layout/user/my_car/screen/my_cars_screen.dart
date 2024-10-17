import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/buttons/notification_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../custom_widgets/custom_loading/custom_shimmer.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import '../controller/car_controller.dart';
import '../widgets/my_car_widget.dart';
import 'add_new_car_screen.dart';

class MyCarsScreen extends StatelessWidget {
  static const String routeName = 'MyCarsScreen';
  const MyCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarController()
        ..initialCar()
        ..getCar(),
      child: PageContainer(
        child: Scaffold(
          appBar: CustomAppBar(
            context,
            automaticallyImplyLeading: true,
            title: Text(
              tr(AppLocaleKey.myCars),
            ),
            actions: const [
              Center(child: NotificationButton()),
              Gap(20),
            ],
          ),
          body: Consumer<CarController>(
            builder: (context, carController, _) {
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ApiResponseWidget(
                      apiResponse: carController.carsResponse,
                      onReload: () => carController.getCar(),
                      isEmpty: carController.cars.isEmpty,
                      loadingWidget: const CustomShimmer(
                        height: 100,
                        radius: 16,
                      ),
                      child: Column(
                        children: [
                          ...List.generate(
                            carController.cars.length,
                            (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyCarWidget(
                                  car: carController.cars[index],
                                ),
                                const Gap(10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    CustomButton(
                      onPressed: () {
                        NavigatorMethods.pushNamed(
                          context,
                          AddNewCarScreen.routeName,
                          arguments: AddNewCarArgs(
                            onSuccess: () {
                              carController.getCar();
                            },
                          ),
                        );
                      },
                      text: tr(AppLocaleKey.addAnewCar),
                      gradient: LinearGradient(
                        colors: [
                          AppColor.grid1Color(context),
                          AppColor.grid2Color(context),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
