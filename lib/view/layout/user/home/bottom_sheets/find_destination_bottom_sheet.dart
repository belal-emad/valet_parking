import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/extension/context_extension.dart';
import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../global/app_bottom_sheet/user_bottom_sheet.dart';
import '../controller/category_controller.dart';
import 'user_search_bottom_sheet_item.dart';

class FindDestinationBottomSheet extends StatefulWidget {
  final int id;
  const FindDestinationBottomSheet({super.key, required this.id});

  @override
  State<FindDestinationBottomSheet> createState() =>
      _FindDestinationBottomSheetState();
}

class _FindDestinationBottomSheetState
    extends State<FindDestinationBottomSheet> {
  String? _search;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoryController()
        ..initialCategories()
        ..getCategories(
          type: widget.id,
          search: _search,
        ),
      child: Consumer<CategoryController>(
        builder: (context, categoryController, _) => UserBottomSheet(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomFormField(
                    hintText: tr(AppLocaleKey.findYourDestination),
                    fillColor: AppColor.whiteColor(context),
                    prefixIcon: SizedBox(
                      width: 47,
                      height: 47,
                      child: Center(
                        child: SvgPicture.asset(
                          AppImages.searchIcon,
                          colorFilter: ColorFilter.mode(
                            AppColor.blackColor(context),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    onChanged: (searchEc) {
                      setState(() {
                        _search = searchEc;
                      });
                      categoryController.getCategories(
                        type: widget.id,
                        search: _search,
                      );
                    },
                  ),
                ),
                const Gap(5),
                CustomButton(
                  color: AppColor.lightGreenColor(context),
                  width: 47,
                  radius: 17,
                  child: SvgPicture.asset(AppImages.micIcon),
                ),
              ],
            ),
            const Gap(20),
            Text(
              tr(AppLocaleKey.results),
              style: AppTextStyle.textL16R(context),
            ),
            const Gap(10),
            ApiResponseWidget(
              apiResponse: categoryController.categoriesResponse,
              onReload: () => categoryController.getCategories(
                type: widget.id,
                search: _search,
              ),
              isEmpty: categoryController.categories.isEmpty,
              child: Column(
                children: [
                  ...List.generate(
                    categoryController.categories.length,
                    (index) => UserSearchBottomSheetItem(
                      category: categoryController.categories[index],
                    ),
                  ),
                ],
              ),
            ),
            Gap(context.bottomInsets()),
          ],
        ),
      ),
    );
  }
}
