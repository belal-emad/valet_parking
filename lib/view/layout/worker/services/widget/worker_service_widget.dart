import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/view/layout/worker/services/controller/services_controller.dart';
import 'package:valet_parking/view/layout/worker/services/model/services_model.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/theme/style.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../screen/worker_details_services_screen.dart';

class WorkerServiceWidget extends StatelessWidget {
  final ServicesModel servicesModel;

  const WorkerServiceWidget({
    super.key,
    required this.servicesModel,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ServicesController>(
        builder: (context, servicesController, _) {
      return GestureDetector(
        onTap: () {
          NavigatorMethods.pushNamed(
            context,
            WorkerDetailsServicesScreen.routeName,
            arguments: WorkerDetailsServicesArgs(
              servicesModel: servicesModel,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColor.whiteColor(context),
            borderRadius: BorderRadius.circular(10),
            boxShadow: appShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 63,
                height: 63,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                    colors: [
                      AppColor.grid1Color(context),
                      AppColor.grid2Color(context),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(AppImages.checkIcon),
                ),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      servicesModel.title ?? "",
                      style: AppTextStyle.textD18B(context),
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            tr(AppLocaleKey.carNumbers),
                            style: AppTextStyle.textD18B(context),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            servicesModel.carsNo.toString(),
                            style: AppTextStyle.textD18B(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
