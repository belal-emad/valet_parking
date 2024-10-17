import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../custom_widgets/validation/validation_mixin.dart';
import '../../../global/app_bottom_sheet/user_bottom_sheet.dart';
import '../../home/controller/user_services_controller.dart';

class UserAddNoteBottomSheet extends StatefulWidget {
  const UserAddNoteBottomSheet({super.key});

  @override
  State<UserAddNoteBottomSheet> createState() => _UserAddNoteBottomSheetState();
}

class _UserAddNoteBottomSheetState extends State<UserAddNoteBottomSheet>
    with ValidationMixin {
  final _noteController = TextEditingController();
  final _userMobile = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _noteController.dispose();
    _userMobile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: UserBottomSheet(
          children: [
            Text(tr(AppLocaleKey.note), style: AppTextStyle.textD18B(context)),
            const Gap(20),
            CustomFormField(
              validator: validateEmptyField,
              controller: _noteController,
            ),
            const Gap(20),
            Text(tr(AppLocaleKey.receiptPhoneNumber),
                style: AppTextStyle.textD18B(context)),
            const Gap(20),
            CustomFormField(
              validator: validatePhone,
              controller: _userMobile,
              keyboardType: TextInputType.phone,
            ),
            const Gap(20),
            CustomButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<UserServiceController>().addServices(
                        ticketId:
                            context.read<UserServiceController>().ticketId,
                        serviceId:
                            context.read<UserServiceController>().serviceId,
                        note: _noteController.text,
                        userMobile: _userMobile.text,
                        onSuccess: () {
                          Navigator.pop(context);
                        },
                      );
                }
              },
              height: 58,
              text: tr(AppLocaleKey.done),
            )
          ],
        ),
      ),
    );
  }
}
