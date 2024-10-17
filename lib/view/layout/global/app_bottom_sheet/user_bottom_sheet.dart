import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../helpers/theme/app_colors.dart';

class UserBottomSheet extends StatelessWidget {
  const UserBottomSheet({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.popupColor(context),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 57.88,
                        height: 5.79,
                        decoration: ShapeDecoration(
                          color: AppColor.lightGreenColor(context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.50),
                          ),
                        ),
                      ),
                    ),
                    const Gap(20),
                    ...children
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
