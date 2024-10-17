import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/images/app_images.dart';
import 'package:valet_parking/helpers/images/image_methods.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/helpers/theme/style.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:valet_parking/view/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:valet_parking/view/layout/global/app_bottom_sheet/user_bottom_sheet.dart';
import 'package:valet_parking/view/layout/worker/home/bottom_sheet/car_parked_successfully_bottom_sheet.dart';
import 'package:valet_parking/view/layout/worker/qr_code_scan/controller/qr_code_scan_controller.dart';

class AddImagesBottomSheet extends StatefulWidget {
  const AddImagesBottomSheet({
    super.key,
  });

  @override
  State<AddImagesBottomSheet> createState() => _AddImagesBottomSheetState();
}

class _AddImagesBottomSheetState extends State<AddImagesBottomSheet> {
  List<String> _images = []; 
  List<File> _sendImage = []; 
  final _addNotes=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: UserBottomSheet(children: [
        CustomAppBar(
          context,
          title: Text(tr(AppLocaleKey.addAPictureOfTheCar)),
          leading: const Icon(Icons.arrow_back),
          appBarColor: Colors.transparent,
        ),
        const Gap(34),
        InkWell(
          onTap: () {
            ImageMethods.pickMultiImage(onSuccess: (images) {
              setState(() {
                _sendImage=images;
                _images = images.map((image) => image.path).toList();
              });
            });
          },
          child: Row(
            children: [
              Expanded(
                // flex: 2,
                child: _images.isNotEmpty
                    ? SizedBox(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                image: DecorationImage(
                                  image: FileImage(File(_images[index])),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: AppColor.lightGreyColor(context),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppImages.cameraIcon,
                            colorFilter: ColorFilter.mode(
                              AppColor.mainAppColor(context),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
              ),
              _images.isNotEmpty
                  ? const SizedBox()
                  : Expanded(child: SvgPicture.asset(AppImages.plusIcon)),
            ],
          ),
        ),
        const Gap(47),
        Text(
          tr(
            AppLocaleKey.addNotes,
          ),
          style: AppTextStyle.textD16B(context),
        ),
        const Gap(18),
        Container(
          decoration: BoxDecoration(boxShadow: appShadow),
          child: CustomFormField(
            controller: _addNotes,
            fillColor: AppColor.whiteColor(context),
            maxLines: 6,
          ),
        ),
        const Gap(30),
        CustomButton(
          onPressed: () {
          
              context.read<QrCodeScanController>().createScanRequest(
                images: _sendImage,
                notes:_addNotes.text ,
                onSuccess: (){
                  NavigatorMethods.showAppBottomSheet(context, const CarParkedSuccessfulyyBottomSheet());
                });
           
          },
          text: tr(AppLocaleKey.save),
        )
      ]),
    );
  }
}
