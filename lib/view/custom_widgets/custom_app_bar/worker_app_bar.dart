import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../helpers/images/app_images.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/style.dart';
import '../buttons/custom_button.dart';

class WorkerAppBar extends PreferredSize {
  final BuildContext context;
  final bool showIconSearch;

  WorkerAppBar(this.context, {super.key, this.showIconSearch = true})
      : super(
          preferredSize: const Size.fromHeight(125),
          child: Theme(
            data: appThemeData(context).copyWith(
              platform: TargetPlatform.android,
            ),
            child: Container(
              color: AppColor.appBarColor(context),
              height: 125,
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        const Image(
                          image: AssetImage(AppImages.mapWorkerImage),
                          height: 125,
                          fit: BoxFit.fitHeight,
                        ),
                        if (Navigator.canPop(context)) ...{
                          Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: BackButton(
                                color: AppColor.appBarTextColor(context),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        }
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          showIconSearch
                              ? CustomButton(
                                  width: 47,
                                  hasShadow: true,
                                  radius: 23.5,
                                  color: AppColor.whiteColor(context),
                                  child: SvgPicture.asset(AppImages.searchIcon),
                                )
                              : const Gap(47),
                          const Gap(10),
                          CustomButton(
                            width: 47,
                            hasShadow: true,
                            radius: 23.5,
                            color: AppColor.whiteColor(context),
                            child: SvgPicture.asset(AppImages.notificationIcon),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
}
