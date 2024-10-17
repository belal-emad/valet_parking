import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/custom_widgets/validation/validation_mixin.dart';
import 'package:valet_parking/view/layout/user/home/bottom_sheets/user_qr_code_buttom_sheet.dart';
import 'package:valet_parking/view/layout/user/home/controller/parking_controller.dart';
import 'package:valet_parking/view/layout/user/home/controller/user_services_controller.dart';
import 'package:valet_parking/view/layout/user/home/model/user_services_model.dart';
import 'package:valet_parking/view/layout/user/home/widgets/service_select_buttom_sheet.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../global/app_bottom_sheet/user_bottom_sheet.dart';

class UserAddServiceBottomSheet extends StatefulWidget {
  const UserAddServiceBottomSheet({super.key});

  @override
  State<UserAddServiceBottomSheet> createState() =>
      _UserAddServiceBottomSheetState();
}

class _UserAddServiceBottomSheetState extends State<UserAddServiceBottomSheet>
    with ValidationMixin {
  UserServicesModel? servicesModel;
  List<String> selectedOptions = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserServiceController>(context, listen: false)
          .initialServices();
      Provider.of<UserServiceController>(context, listen: false).getServices();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserServiceController>(
        builder: (context, serviceController, _) {
      return ApiResponseWidget(
        apiResponse: serviceController.servicesResponse,
        onReload: serviceController.getServices,
        isEmpty: serviceController.services.isEmpty,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: UserBottomSheet(
            children: [
              Text(
                tr(AppLocaleKey.doYouWantAnyService),
                style: AppTextStyle.textD18B(context),
              ),
              const Gap(20),
              // const CustomFormField(
              //   formFieldBorder: FormFieldBorder.outLine,
              // ),

              const SizedBox(height: 20),
              const ServicesBottomSheet(),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    height: 58,
                    text: tr(AppLocaleKey.done),
                    onPressed: () {
                      setState(() {
                        context.read<ParkingController>().createTickets(
                              categoryTypeId: context
                                  .read<ParkingController>()
                                  .categoryTypeId,
                              categoryId:
                                  context.read<ParkingController>().categoryId,
                              gateId:
                                  context.read<ParkingController>().categoryId,
                              slotId:
                                  context.read<ParkingController>().categoryId,
                              userCarId:
                                  context.read<ParkingController>().userCarId,
                              serviceId:
                                  context.read<ParkingController>().serviceId,
                            );
                      });
                      Navigator.pop(context);
                      NavigatorMethods.showAppBottomSheet(
                          context, const UserQrCodeBottomSheet());
                    },
                  )),
                  const Gap(20),
                  Expanded(
                      child: CustomButton(
                    height: 58,
                    color: AppColor.lightGreenColor(context),
                    text: tr(AppLocaleKey.skip),
                    style: AppTextStyle.textM20R(context),
                    onPressed: () {
                      context.read<ParkingController>().createTickets(
                            categoryTypeId: context
                                .read<ParkingController>()
                                .categoryTypeId,
                            categoryId:
                                context.read<ParkingController>().categoryId,
                            gateId:
                                context.read<ParkingController>().categoryId,
                            slotId:
                                context.read<ParkingController>().categoryId,
                            userCarId:
                                context.read<ParkingController>().userCarId,
                            serviceId:
                                context.read<ParkingController>().serviceId,
                          );
                      Navigator.pop(context);
                      NavigatorMethods.showAppBottomSheet(
                          willPop: true,
                          enableDrag: true,
                          isScrollControlled: true,
                          context,
                          const UserQrCodeBottomSheet());
                    },
                  ))
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
