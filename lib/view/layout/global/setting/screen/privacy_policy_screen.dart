import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/extension/context_extension.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/layout/global/setting/controller/setting_controller.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../custom_widgets/buttons/notification_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../custom_widgets/page_container/page_container.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static const String routeName = 'PrivacyPolicyScreen';
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return SettingController()
          ..initialPrivacy()
          ..getPrivacy();
      },
      child:
          Consumer<SettingController>(builder: (context, settingController, _) {
        return PageContainer(
          child: Scaffold(
            appBar: CustomAppBar(
              context,
              automaticallyImplyLeading: true,
              title: Text(
                tr(AppLocaleKey.privacyPolicy),
              ),
              actions: const [
                Center(child: NotificationButton()),
                Gap(20),
              ],
            ),
            body: ApiResponseWidget(
              apiResponse: settingController.privacyResponse,
              onReload: () => settingController.getPrivacy(),
              isEmpty: settingController.privacy == null,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    const Gap(50),
                    Container(
                      decoration: const BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10, top: 2),
                            width: 10,
                            height: 8,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.darkTextColor(context)),
                          ),
                          const Gap(15),
                          Expanded(
                            child: Text(
                              context.apiTr(
                                  ar: settingController.privacy?.privacyAr ??
                                      "",
                                  en: settingController.privacy?.privacyEn ??
                                      ""),
                              textAlign: TextAlign.justify,
                              style: AppTextStyle.textD16R(context),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
