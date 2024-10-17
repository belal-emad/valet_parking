import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/view/layout/worker/services/model/services_details_model.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/theme/style.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';

class WorkerDetailsServicesWidget extends StatelessWidget {
  final ServicesDetailsModel servicesDetailsModel;
  const WorkerDetailsServicesWidget({
    super.key,
    required this.servicesDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: AppColor.whiteFcColor(context),
              borderRadius: BorderRadius.circular(6),
              boxShadow: appShadow),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                      child: Image.asset(
                        AppImages.carRequestImage,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          servicesDetailsModel.carModel ?? "",
                          style: AppTextStyle.textD18B(context),
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                servicesDetailsModel.gateTitle ?? "",
                                //    servicesModel. ,
                                style: AppTextStyle.textD18B(context),
                              ),
                            ),
                            const Gap(40),
                            Expanded(
                              child: Text(
                                tr(AppLocaleKey.slot),
                                style: AppTextStyle.textD18B(context),
                              ),
                            ),
                            Text(
                              servicesDetailsModel.slotTitle ?? "",
                              style: AppTextStyle.textD18B(context),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(25),
              Text(
                tr(
                  AppLocaleKey.notes,
                ),
                style: AppTextStyle.textL14R(context),
              ),
              const Gap(5),
              Text(servicesDetailsModel.notes ?? "",
                  style: AppTextStyle.textD14B(context)),
              const Gap(10),
              Text(
                tr(
                  AppLocaleKey.phone,
                ),
                style: AppTextStyle.textL14R(context),
              ),
              const Gap(5),
              Text(servicesDetailsModel.userMobile ?? "",
                  style: AppTextStyle.textD14B(context)),
              const Gap(30),
            ],
          ),
        ),
        Positioned(
          bottom: -20,
          child: CustomButton(
            text: tr(AppLocaleKey.serviceProvided),
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        ),
      ],
    );
  }
}
