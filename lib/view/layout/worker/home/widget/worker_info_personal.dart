import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/view/layout/global/auth/controller/auth_controller.dart';

import '../../../../../helpers/networking/urls.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/custom_image/custom_network_image.dart';

class WorkerInfoPersonal extends StatefulWidget {
  const WorkerInfoPersonal({super.key});

  @override
  State<WorkerInfoPersonal> createState() => _WorkerInfoPersonalState();
}

class _WorkerInfoPersonalState extends State<WorkerInfoPersonal> {
  bool? switchValue;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(builder: (context, authController, _) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                Text(
                  tr(AppLocaleKey.carParkingAt),
                  style: AppTextStyle.textD24B(context),
                ),
                const Gap(5),
                Flexible(
                  child: Text(
                    authController.profileModel?.valetCategory.toString() ?? "",
                    style: AppTextStyle.textS24B(context),
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 77,
                    height: 77,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.greyColor(context),
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const CustomNetworkImage(
                      imageUrl: Urls.testBlueCarImage,
                      width: 74,
                      height: 74,
                      radius: 37,
                      fit: BoxFit.cover,
                    ),
                  ),
                  authController.profileModel!.valetOnline == 1
                      ? Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColor.greenColor(context),
                            border: Border.all(
                              color: AppColor.whiteColor(context),
                              width: 3,
                            ),
                            shape: BoxShape.circle,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              const Gap(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            authController.profileModel?.name.toString() ?? "",
                            style: AppTextStyle.textD18B(context),
                          ),
                        ),
                        const Gap(10),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: authController.profileModel!.valetOnline == 1
                                ? true
                                : false,
                            onChanged: (value) {
                              setState(
                                () {
                                  authController.profileModel!.valetOnline =
                                      value ? 1 : 0;
                                  context
                                      .read<AuthController>()
                                      .changeWorkerOnlineOrNot();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      authController.profileModel?.valetCategory.toString() ??
                          "",
                      style: AppTextStyle.textL16R(
                        context,
                      ),
                    ),
                    // const Gap(5),
                    Text(
                      authController.profileModel?.valetGate.toString() ?? "",
                      style: AppTextStyle.textL16R(context, height: 2),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      );
    });
  }
}
