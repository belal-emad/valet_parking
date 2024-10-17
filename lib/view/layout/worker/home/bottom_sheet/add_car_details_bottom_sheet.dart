import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:valet_parking/view/custom_widgets/validation/validation_mixin.dart';
import 'package:valet_parking/view/layout/global/app_bottom_sheet/user_bottom_sheet.dart';
import 'package:valet_parking/view/layout/global/auth/controller/auth_controller.dart';

import 'package:valet_parking/view/layout/worker/home/bottom_sheet/services_bottom_sheet.dart';
import 'package:valet_parking/view/layout/worker/home/bottom_sheet/worker_parking_location_bottom_sheet.dart';
import 'package:valet_parking/view/layout/worker/qr_code_scan/controller/qr_code_scan_controller.dart';

class AddCarDetailsBottomSheet extends StatefulWidget {
  const AddCarDetailsBottomSheet({
    super.key,
  });

  @override
  State<AddCarDetailsBottomSheet> createState() =>
      _AddCarDetailsBottomSheetState();
}

class _AddCarDetailsBottomSheetState extends State<AddCarDetailsBottomSheet>
    with ValidationMixin {
  final _carModel = TextEditingController();
  final _carPlate = TextEditingController();
  final _carColor = TextEditingController();
  final _userNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QrCodeScanController>(context, listen: false)
        ..initialServices()
        ..getServices(
            id: int.parse(Provider.of<AuthController>(context, listen: false)
                .profileModel!
                .valetCategoryId!));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: UserBottomSheet(children: [
          const Gap(30),
          Text(
            tr(AppLocaleKey.typeOfCar),
            style: AppTextStyle.textD18B(context),
          ),
          const Gap(10),
          CustomFormField(
            controller: _carModel,
            validator: validateEmptyField,
          ),
          const Gap(30),
          Text(
            tr(AppLocaleKey.carNumber),
            style: AppTextStyle.textD18B(context),
          ),
          const Gap(10),
          CustomFormField(
            controller: _carPlate,
            validator: validateEmptyField,
          ),
          const Gap(30),
          Text(
            tr(AppLocaleKey.carColor),
            style: AppTextStyle.textD18B(context),
          ),
          const Gap(10),
          CustomFormField(
            controller: _carColor,
            validator: validateEmptyField,
          ),
          const Gap(30),
          Text(
            tr(AppLocaleKey.phone),
            style: AppTextStyle.textD18B(context),
          ),
          const Gap(10),
          CustomFormField(
            controller: _userNumber,
            validator: validateEmptyField,
          ),
          const Gap(30),
          Text(
            tr(AppLocaleKey.theService),
            style: AppTextStyle.textD18B(context),
          ),
          const Gap(10),
          const ServicesBottomSheet(),
          const Gap(50),
          CustomButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<QrCodeScanController>().setCarModel =
                    _carModel.text;
                context.read<QrCodeScanController>().setCarPlate =
                    _carPlate.text;
                context.read<QrCodeScanController>().setCarColor =
                    _carColor.text;
                context.read<QrCodeScanController>().setUserMobile =
                    _userNumber.text;
                // log(context.read<QrCodeScanController>().carModel);
                // log(context.read<QrCodeScanController>().carPlate);
                // log(context.read<QrCodeScanController>().carColor);
                // log(context.read<QrCodeScanController>().userMobile);
                Navigator.pop(context);
                NavigatorMethods.showAppBottomSheet(
                  context,
                  enableDrag: true,
                  isScrollControlled: true,
                  const WorkerParkingLocationBottomSheet(),
                );
              }
            },
            text: tr(AppLocaleKey.next),
          )
        ]),
      ),
    );
  }
}
