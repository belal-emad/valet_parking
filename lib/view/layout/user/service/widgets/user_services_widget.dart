import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../home/controller/user_services_controller.dart';
import '../../home/model/user_services_model.dart';
import '../services_bottom_sheet/user_add_note_bottom_sheet.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';

class UserServicesWidget extends StatelessWidget {
  const UserServicesWidget({
    super.key,
    required this.userServicesModel,
  });

  final UserServicesModel userServicesModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserServiceController>(
        builder: (context, serviceController, _) {
      return ApiResponseWidget(
          onReload: () => serviceController.getServices(),
          isEmpty: serviceController.services.isEmpty,
          apiResponse: serviceController.servicesResponse,
          child: GestureDetector(
            onTap: () {
              NavigatorMethods.showAppBottomSheet(
                context,
                const UserAddNoteBottomSheet(),
                enableDrag: true,
                isScrollControlled: true,
                willPop: true,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.whiteColor(context),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 63,
                    height: 63,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                        colors: [
                          AppColor.grid1Color(context),
                          AppColor.grid2Color(context),
                        ],
                      ),
                      shape: const OvalBorder(),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppImages.checkIcon,
                        colorFilter: ColorFilter.mode(
                          AppColor.whiteColor(context),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userServicesModel.title ?? " ",
                          style: AppTextStyle.textD18B(context),
                        ),
                        const Gap(8),
                        Text(
                          userServicesModel.description ?? " ",
                          style: AppTextStyle.textL14R(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
