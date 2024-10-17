import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking/view/layout/user/my_car/widgets/photo_profile_widget.dart';

import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/buttons/notification_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import '../../../../custom_widgets/validation/validation_mixin.dart';
import '../controller/car_controller.dart';

class AddNewCarArgs {
  final VoidCallback onSuccess;

  AddNewCarArgs({required this.onSuccess});
}

class AddNewCarScreen extends StatefulWidget {
  final AddNewCarArgs args;
  const AddNewCarScreen({super.key, required this.args});
  static const String routeName = 'AddNewCarScreen';
  @override
  State<AddNewCarScreen> createState() => _AddNewCarScreenState();
}

class _AddNewCarScreenState extends State<AddNewCarScreen>
    with ValidationMixin {
  final _globalKey = GlobalKey<FormState>();
  final _carTypeEc = TextEditingController();
  final _carNumberEc = TextEditingController();
  final _carColorEc = TextEditingController();
  @override
  void dispose() {
    _carTypeEc.dispose();
    _carNumberEc.dispose();
    _carColorEc.dispose();
    super.dispose();
  }

  File? _image;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarController(),
      builder: (context, child) {
        return PageContainer(
          child: Form(
            key: _globalKey,
            child: Scaffold(
              appBar: CustomAppBar(
                automaticallyImplyLeading: true,
                context,
                title: Text(
                  tr(AppLocaleKey.addAnewCar),
                ),
                actions: const [
                  Center(
                    child: NotificationButton(),
                  ),
                  Gap(10),
                ],
              ),
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(25),
                    Center(
                        child: PhotoProfileWidget(
                            image: _image,
                            onSuccess: (v) {
                              setState(() {
                                _image = v;
                              });
                            })),
                    const Gap(25),
                    CustomFormField(
                      controller: _carTypeEc,
                      hintText: tr(AppLocaleKey.typeOfCar),
                      validator: validateEmptyField,
                    ),
                    const Gap(15),
                    CustomFormField(
                      controller: _carNumberEc,
                      keyboardType: TextInputType.number,
                      hintText: tr(AppLocaleKey.carNumber),
                      validator: validateEmptyField,
                    ),
                    const Gap(15),
                    CustomFormField(
                      controller: _carColorEc,
                      hintText: tr(AppLocaleKey.carColor),
                      validator: validateEmptyField,
                    ),
                    const Gap(15),
                    CustomButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          context.read<CarController>().createNewCar(
                                carModel: _carTypeEc.text,
                                carPlate: _carNumberEc.text,
                                carColor: _carColorEc.text,
                                onSuccess: () {
                                  widget.args.onSuccess.call();
                                  Navigator.pop(context);
                                },
                              );
                        }
                      },
                      text: tr(AppLocaleKey.addAnewCar),
                      radius: 10,
                      gradient: LinearGradient(
                        colors: [
                          AppColor.grid1Color(context),
                          AppColor.grid2Color(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
