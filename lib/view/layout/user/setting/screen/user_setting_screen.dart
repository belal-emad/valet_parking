import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../global/auth/controller/auth_controller.dart';
import '../../package/screen/my_packages_screen.dart';
import '../../reservations/screen/my_reservations_screen.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/networking/urls.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/utils/common_methods.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/buttons/notification_button.dart';
import '../../../../custom_widgets/buttons/setting_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../custom_widgets/custom_image/custom_network_image.dart';
import '../../../global/auth/screen/register_through_screen.dart';
import '../../../global/setting/bottom_sheet/change_language_bottom_sheet.dart';
import '../../../global/auth/screen/change_password_screen.dart';
import '../../../global/setting/screen/help_screen.dart';
import '../../../global/setting/screen/notifications_screen.dart';
import '../../../global/setting/screen/privacy_policy_screen.dart';
import '../../reservations/screen/previous_reservation_history_screen.dart';
import '../../my_car/screen/my_cars_screen.dart';
import 'edit_user_profile_screen.dart';

class UserSettingScreen extends StatelessWidget {
  final VoidCallback onLangChanged;
  const UserSettingScreen({
    super.key,
    required this.onLangChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        title: Text(tr(AppLocaleKey.settings)),
        actions: const [
          Center(
            child: NotificationButton(),
          ),
          Gap(10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            const CustomNetworkImage(
              imageUrl: Urls.testUserImage,
              width: 140,
              height: 140,
              fit: BoxFit.cover,
              hasZoom: true,
              radius: 70,
            ),
            const Gap(15),
            Text(
              'Name',
              style: AppTextStyle.textD24B(context),
            ),
            const Gap(10),
            Text(
              'email@mail.com',
              style: AppTextStyle.textD14B(context),
            ),
            const Gap(15),
            SettingButton(
              onTap: () {
                NavigatorMethods.pushNamed(
                  context,
                  UserProfileScreen.routeName,
                );
              },
              icon: AppImages.profileIcon,
              title: tr(AppLocaleKey.editProfile),
            ),
            const Gap(15),
            SettingButton(
              onTap: () {
                NavigatorMethods.pushNamed(
                  context,
                  ChangePasswordScreen.routeName,
                );
              },
              icon: AppImages.lockIcon,
              title: tr(
                AppLocaleKey.modifyPassword,
              ),
            ),
            const Gap(15),
            SettingButton(
              onTap: () {
                NavigatorMethods.pushNamed(
                  context,
                  MyPackagesScreen.routeName,
                );
              },
              icon: AppImages.walletIcon,
              title: tr(AppLocaleKey.myPackages),
            ),
            const Gap(15),
            SettingButton(
              onTap: () {
                NavigatorMethods.pushNamed(
                  context,
                  MyCarsScreen.routeName,
                );
              },
              icon: AppImages.settingCarIcon,
              title: tr(
                AppLocaleKey.myCars,
              ),
            ),
            const Gap(15),
            SettingButton(
              onTap: () {
                NavigatorMethods.pushNamed(
                  context,
                  MyReservations.routeName,
                );
              },
              icon: AppImages.settingCarIcon,
              title: tr(
                AppLocaleKey.myReservations,
              ),
            ),
            const Gap(15),
            SettingButton(
              onTap: () {
                NavigatorMethods.pushNamed(
                  context,
                  PreviousReservationHistoryScreen.routeName,
                );
              },
              icon: AppImages.settingCarIcon,
              title: tr(
                AppLocaleKey.historyOfPreviousReservations,
              ),
            ),
            const Gap(15),
            SettingButton(
              onTap: () {
                NavigatorMethods.pushNamed(
                  context,
                  NotificationsScreen.routeName,
                );
              },
              icon: AppImages.settingNotificationIcon,
              title: tr(AppLocaleKey.notifications),
            ),
            const Gap(15),
            SettingButton(
              onTap: () {
                NavigatorMethods.pushNamed(
                  context,
                  PrivacyPolicyScreen.routeName,
                );
              },
              icon: AppImages.privacyIcon,
              title: tr(AppLocaleKey.privacyPolicy),
            ),
            const Gap(15),
            SettingButton(
              onTap: () {
                NavigatorMethods.pushNamed(
                  context,
                  HelpScreen.routeName,
                );
              },
              icon: AppImages.helpIcon,
              title: tr(AppLocaleKey.help),
            ),
            const Gap(15),
            SettingButton(
              icon: AppImages.langIcon,
              title: tr(AppLocaleKey.language),
              onTap: () {
                NavigatorMethods.showAppBottomSheet(
                  context,
                  ChangeLanguageBottomSheet(
                    onChanged: onLangChanged,
                  ),
                );
              },
            ),
            const Gap(15),
            SettingButton(
              icon: AppImages.logoutIcon,
              title: tr(AppLocaleKey.logout),
              color: AppColor.redColor(context),
              onTap: () {
                CommonMethods.showChooseDialog(
                  context,
                  title: tr(AppLocaleKey.logout),
                  message: tr(AppLocaleKey.doYouWantToLogout),
                  onPressed: () {
                    context.read<AuthController>().logout(
                      onSuccess: () {
                        NavigatorMethods.pushNamedAndRemoveUntil(
                          context,
                          RegisterThroughScreen.routeName,
                        );
                      },
                    );
                  },
                );
              },
            ),
            const Gap(100),
          ],
        ),
      ),
    );
  }
}
