import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/helpers/locale/app_locale_key.dart';
import 'package:valet_parking/helpers/theme/app_colors.dart';
import 'package:valet_parking/helpers/theme/app_text_style.dart';
import 'package:valet_parking/view/custom_widgets/buttons/custom_button.dart';
import 'package:valet_parking/view/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:valet_parking/view/custom_widgets/validation/validation_mixin.dart';
import 'package:valet_parking/view/layout/user/package/controller/package_controller.dart';
import 'package:valet_parking/view/layout/user/package/model/my_packages_model.dart';


class StopPackagesBottomSheet extends StatefulWidget {
  final MyPackagesModel packagesModel;
  final VoidCallback onSuccess;
  const StopPackagesBottomSheet({super.key, required this.packagesModel,required this.onSuccess});

  @override
  State<StopPackagesBottomSheet> createState() =>
      _StopPackagesBottomSheetState();
}

class _StopPackagesBottomSheetState extends State<StopPackagesBottomSheet>with ValidationMixin {
final _stopDayes=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
       create: (BuildContext context) {
        return PackageController();
         
      },
      child: Builder(
        builder: (context) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColor.popupColor(context),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Flexible(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                    ),
                    const Divider(
                      thickness: 4,
                      endIndent: 170,
                      indent: 170,
                    ),
                    const Gap(20),
                    Text(tr(AppLocaleKey.stopUsingForAWhile),style: AppTextStyle.textD18B(context),),
                      const Gap(15),
                       CustomFormField(
                        controller: _stopDayes,
                        hintText:tr(AppLocaleKey.stopUsingForAWhile) ,
                        keyboardType: TextInputType.number,
                        validator: validateEmptyField,
              
                      ),
                      const Gap(15),
                    CustomButton(
                      
                      gradient: LinearGradient(colors: [
                        AppColor.grid1Color(context),
                        AppColor.grid2Color(context),
                      ]),
                      radius: 10,
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          widget.packagesModel.status=="active"?
                          context.read<PackageController>().stopPackage(
                            daysStopped: _stopDayes.text,
                             id: widget.packagesModel.packageId!.toInt(),
                              onSuccess: (){                     
                                widget.onSuccess.call();
                                 Navigator.pop(context);  
                              }):context.read<PackageController>().stopPackage(
                                reNew: 1,
                            daysStopped: _stopDayes.text,
                             id: widget.packagesModel.packageId!.toInt(),
                              onSuccess: (){                     
                                widget.onSuccess.call();
                                 Navigator.pop(context);  
                              });
                        }
                      },
                      text: tr(AppLocaleKey.done),
                    ),
                    const Gap(25),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
