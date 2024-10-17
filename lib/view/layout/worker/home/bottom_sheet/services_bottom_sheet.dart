import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../custom_widgets/api_response_widget/api_response_widget.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../global/auth/controller/auth_controller.dart';
import '../../qr_code_scan/controller/qr_code_scan_controller.dart';
import '../../services/model/services_model.dart';

class ServicesBottomSheet extends StatefulWidget {
  const ServicesBottomSheet({super.key});

  @override
  State<ServicesBottomSheet> createState() => _ServicesBottomSheetState();
}

class _ServicesBottomSheetState extends State<ServicesBottomSheet> {
  List<ServicesModel> selectedOptions = [];

  final TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QrCodeScanController>(
        builder: (context, qrCodeScanController, _) {
      return CustomFormField(
        readOnly: true,
        controller: _textEditingController,
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ApiResponseWidget(
                apiResponse: qrCodeScanController.servicesResponse,
                isEmpty: qrCodeScanController.services.isEmpty,
                onReload: () => qrCodeScanController.getServices(
                    id: int.parse(
                        Provider.of<AuthController>(context, listen: false)
                            .profileModel!
                            .valetCategoryId!)),
                child: StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(tr(AppLocaleKey.services),
                                style: AppTextStyle.textD18B(context)),
                          ),
                          const Divider(),
                          Expanded(
                            child: ListView.builder(
                              itemCount: context
                                  .read<QrCodeScanController>()
                                  .services
                                  .length,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  activeColor: AppColor.mainAppColor(context),
                                  title: Text(
                                    context
                                            .read<QrCodeScanController>()
                                            .services[index]
                                            .title ??
                                        "",
                                    style: AppTextStyle.textD18B(context),
                                  ),
                                  value: selectedOptions.contains(context
                                      .read<QrCodeScanController>()
                                      .services[index]),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value != null && value) {
                                        selectedOptions.add(context
                                            .read<QrCodeScanController>()
                                            .services[index]);
                                        context
                                            .read<QrCodeScanController>()
                                            .serviceId
                                            .add(context
                                                .read<QrCodeScanController>()
                                                .services[index]
                                                .id);
                                      } else {
                                        selectedOptions.remove(context
                                            .read<QrCodeScanController>()
                                            .services[index]);
                                        context
                                            .read<QrCodeScanController>()
                                            .serviceId
                                            .remove(context
                                                .read<QrCodeScanController>()
                                                .services[index]
                                                .id);
                                      }
                                      log(context
                                          .read<QrCodeScanController>()
                                          .serviceId
                                          .toString());
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: CustomButton(
                              text: tr(AppLocaleKey.done),
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  String selectedText = selectedOptions
                                      .map((service) => service.title)
                                      .join(', ');

                                  _textEditingController.text = selectedText;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      );
    });
  }
}
