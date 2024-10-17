import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/buttons/notification_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import '../widget/receiver_text_widget.dart';

class HelpScreen extends StatelessWidget {
  static const String routeName = 'HelpScreen';
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          automaticallyImplyLeading: true,
          context,
          title: Text(tr(AppLocaleKey.help)),
          actions: const [
            Center(
              child: NotificationButton(),
            ),
            Gap(10),
          ],
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        ReceiverTextWidget(),
                        Gap(10),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: CustomFormField(
                    fillColor: AppColor.whiteColor(context),
                    hintText: tr(AppLocaleKey.youCanWriteSomethingHere),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomButton(
                          height: 40,
                          width: 100,
                          text: tr(AppLocaleKey.send),
                        ),
                        const Gap(5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
