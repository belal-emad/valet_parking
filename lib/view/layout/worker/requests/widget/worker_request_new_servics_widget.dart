import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/helpers/theme/style.dart';
import 'package:valet_parking/helpers/utils/navigator_methods.dart';
import 'package:valet_parking/view/layout/worker/requests/bottom_sheet/add_note_and_phone_bottom_sheet.dart';
import 'package:valet_parking/view/layout/worker/requests/model/car_request_model.dart';
import 'package:valet_parking/view/layout/worker/services/model/services_model.dart';

class WorkerRequestsNewServicesWidget extends StatefulWidget {
  final CarRequestModel carRequestModel;
  final ServicesModel servicesModel;
  const WorkerRequestsNewServicesWidget(
      {super.key, required this.carRequestModel, required this.servicesModel});

  @override
  State<WorkerRequestsNewServicesWidget> createState() =>
      _WorkerRequestsNewServicesWidgetState();
}

class _WorkerRequestsNewServicesWidgetState
    extends State<WorkerRequestsNewServicesWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.whiteColor(context),
        borderRadius: BorderRadius.circular(10),
        boxShadow: appShadow,
      ),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.5,
            child: Checkbox(
              activeColor: AppColor.mainAppColor(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(
                    width: 2.0, color: AppColor.mainAppColor(context)),
              ),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                  if (isChecked) {
                    NavigatorMethods.showAppBottomSheet(
                        context,
                        AddNoteAndPhoneBottomSheet(
                          servicesModel: widget.servicesModel,
                        ),
                        isScrollControlled: true);
                  }
                });
              },
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.carRequestModel.carModel ?? "",
                  style: AppTextStyle.textD18B(context),
                ),
                const Gap(10),
                Text(
                  "${widget.carRequestModel.gateTitle ?? ""}    ${widget.carRequestModel.slotTitle ?? ""}",
                  style: AppTextStyle.textD18B(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
