import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../controller/home_controller.dart';
import '../widgets/user_home_filter_widget.dart';

class UserSHomeTab extends StatelessWidget {
  const UserSHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return HomeController()
          ..initialCategoryType()
          ..getCategoryType();
      },
      child: Consumer<HomeController>(builder: (context, homeController, _) {
        return ApiResponseWidget(
          apiResponse: homeController.categoryTypeResponse,
          onReload: () => homeController.getCategoryType(),
          isEmpty: homeController.categoryTypes.isEmpty,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor.whiteColor(context),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tr(AppLocaleKey.choseYourDestination),
                      style: AppTextStyle.textD24B(context),
                    ),
                    const Gap(15),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        homeController.categoryTypes.length,
                        (index) => UserHomeFilterWidget(
                            homeCategoryModel:
                                homeController.categoryTypes[index]),
                      ),
                    ),
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
