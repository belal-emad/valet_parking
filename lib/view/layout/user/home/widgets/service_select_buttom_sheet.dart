import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/api_response_widget/api_response_widget.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:valet_parking/view/layout/user/home/controller/parking_controller.dart';
import 'package:valet_parking/view/layout/user/home/controller/user_services_controller.dart';
import 'package:valet_parking/view/layout/user/home/model/user_services_model.dart';

class ServicesBottomSheet extends StatefulWidget {
  const ServicesBottomSheet({super.key});

  @override
  State<ServicesBottomSheet> createState() => _ServicesBottomSheetState();
}

class _ServicesBottomSheetState extends State<ServicesBottomSheet> {
  List<UserServicesModel> selectedOptions = [];

  final TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserServiceController>(
        builder: (context, serviceController, _) {
      return ApiResponseWidget(
        apiResponse: serviceController.servicesResponse,
        onReload: () => serviceController.getServices,
        isEmpty: serviceController.services.isEmpty,
        child: CustomFormField(
          readOnly: true,
          controller: _textEditingController,
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
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
                              itemCount: serviceController.services.length,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  activeColor: AppColor.mainAppColor(context),
                                  title: Text(
                                    serviceController.services[index].title!,
                                    style: AppTextStyle.textD18B(context),
                                  ),
                                  value: selectedOptions.contains(
                                      serviceController.services[index]),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value != null && value) {
                                        selectedOptions.add(
                                            serviceController.services[index]);
                                        context
                                            .read<ParkingController>()
                                            .serviceId
                                            .add(serviceController
                                                .services[index].id);
                                      } else {
                                        selectedOptions.remove(
                                            serviceController.services[index]);
                                        context
                                            .read<ParkingController>()
                                            .serviceId
                                            .remove(serviceController
                                                .services[index].id);
                                      }
                                      log(context
                                          .read<ParkingController>()
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
                                      .join(' , ');
                                  _textEditingController.text = selectedText;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      );
    });
  }
}
