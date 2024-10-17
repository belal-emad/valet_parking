import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:valet_parking/view/custom_widgets/validation/validation_mixin.dart';
import 'package:valet_parking/view/layout/global/app_bottom_sheet/user_bottom_sheet.dart';
import 'package:valet_parking/view/layout/worker/services/controller/services_controller.dart';
import 'package:valet_parking/view/layout/worker/services/model/services_model.dart';

class AddNoteAndPhoneBottomSheet extends StatefulWidget {
  final ServicesModel servicesModel;
  const AddNoteAndPhoneBottomSheet({super.key, required this.servicesModel});

  @override
  State<AddNoteAndPhoneBottomSheet> createState() =>
      _AddNoteAndPhoneBottomSheetState();
}

class _AddNoteAndPhoneBottomSheetState extends State<AddNoteAndPhoneBottomSheet>
    with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final noteEc = TextEditingController();
  final phoneEc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ServicesController();
      },
      child: Consumer<ServicesController>(
          builder: (context, servicesController, _) {
        return Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: UserBottomSheet(children: [
              const Gap(30),
              CustomFormField(
                validator: validateEmptyField,
                controller: noteEc,
                titleStyle: AppTextStyle.textD18B(context),
                title: tr(AppLocaleKey.note),
              ),
              const Gap(30),
              CustomFormField(
                validator: validatePhone,
                controller: phoneEc,
                titleStyle: AppTextStyle.textD18B(context),
                title: tr(AppLocaleKey.receiptPhoneNumber),
              ),
              const Gap(30),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<ServicesController>().addNewRequestServices(
                          ticketId: widget.servicesModel.ticketId ?? 0,
                          serviceId: widget.servicesModel.serviceId ?? 0,
                          notes: noteEc.text,
                          userMobile: phoneEc.text,
                          onSuccess: () {
                            Navigator.pop(context);
                          },
                        );
                  }
                },
                text: tr(AppLocaleKey.done),
              )
            ]),
          ),
        );
      }),
    );
  }
}
