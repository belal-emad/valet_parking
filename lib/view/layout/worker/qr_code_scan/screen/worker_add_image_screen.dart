import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:valet_parking/view/custom_widgets/custom_app_bar/worker_app_bar.dart';
import 'package:valet_parking/view/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:valet_parking/view/layout/global/auth/controller/auth_controller.dart';
import 'package:valet_parking/view/layout/worker/bottom_navigation/worker_bottom_navigation_bar_screen.dart';
import 'package:valet_parking/view/layout/worker/qr_code_scan/controller/qr_code_scan_controller.dart';
class WorkerAddImageArgc{
  final  int idTicket;
  WorkerAddImageArgc({required this.idTicket});
}
class WorkerAddImageScreen extends StatefulWidget {
  final WorkerAddImageArgc args;
  static const String routeName = 'WorkerAddImageScreen';

  const WorkerAddImageScreen({super.key,required this.args});

  @override
  WorkerAddImageScreenState createState() => WorkerAddImageScreenState();
}

class WorkerAddImageScreenState extends State<WorkerAddImageScreen> {
  List<String> _images = [];
  List<File> _sendImage = []; 
  final _addNotes=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WorkerAppBar(
        context,
        showIconSearch: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  tr(AppLocaleKey.carParkingAt),
                  style: AppTextStyle.textD24B(context),
                ),
                const Gap(5),
                Flexible(
                  child: Text(
                   context.read<AuthController>().profileModel!.valetCategory.toString(),
                    style: AppTextStyle.textS24B(context),
                  ),
                ),
              ],
            ),
            const Gap(18),
            Text(
              tr(AppLocaleKey.addAPictureOfTheCar),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Gap(36),
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
                fillColor: AppColor.whiteColor(context),
                maxLines: 6,
              ),
            ),
            const Gap(30),
            CustomButton(
              onPressed: () {
                
              context.read<QrCodeScanController>().entryCodeNewCar(
                ticketId: widget.args.idTicket,
                notes: _addNotes.text,
                images:_sendImage ,
                 onSuccess: (){
                   NavigatorMethods.pushNamed(
                    context, WorkerBottomNavigationBarScreen.routeName);
                 });
            
              
              },
              text: tr(AppLocaleKey.save),
            )
          ],
        ),
      ),
    );
  }
}
