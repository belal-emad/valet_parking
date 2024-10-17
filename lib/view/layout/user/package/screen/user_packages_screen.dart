import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/layout/user/package/controller/package_controller.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../custom_widgets/buttons/notification_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../widgets/user_package_widget.dart';

class UserPackagesScreen extends StatelessWidget {
  const UserPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return PackageController()
          ..initialPackage()
          ..getPackages();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          context,
          title: Text(tr(AppLocaleKey.packages)),
          actions: const [
            Center(
              child: NotificationButton(),
            ),
            Gap(10),
          ],
        ),
        body: Consumer<PackageController>(
            builder: (context, packageController, _) {
          return ApiResponseWidget(
            apiResponse: packageController.packageResponse,
            onReload: () => packageController.getPackages(),
            isEmpty: packageController.packages.isEmpty,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  ...List.generate(
                    packageController.packages.length,
                    (index) => Column(
                      children: [
                        UserPackageWidget(
                          packageModel: packageController.packages[index],
                        ),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const Gap(100),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
