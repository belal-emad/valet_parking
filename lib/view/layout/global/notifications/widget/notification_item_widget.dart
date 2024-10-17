import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/view/layout/global/notifications/model/notifications_model.dart';

import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/theme/style.dart';

class NotificationsItemWidget extends StatelessWidget {
  final NotificationsModel notificationsModel;
  const NotificationsItemWidget({
    super.key,
    required this.notificationsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Text(
              notificationsModel.data?.text ?? "",
              style: AppTextStyle.textD16B(context),
            ),
          ),
        ],
      ),
    );
  }
}
