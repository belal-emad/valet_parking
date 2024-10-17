import 'dart:async';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/extension/context_extension.dart';
import '../../../../../helpers/extension/string_extension.dart';
import '../../../../../helpers/images/app_images.dart';
import '../../../../../helpers/locale/app_locale_key.dart';
import '../../../../../helpers/theme/app_colors.dart';
import '../../../../../helpers/theme/app_text_style.dart';
import '../../../../../helpers/utils/common_methods.dart';
import '../../../../../helpers/utils/navigator_methods.dart';
import '../../../../custom_widgets/buttons/custom_button.dart';
import '../../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../custom_widgets/custom_toast/custom_toast.dart';
import '../../../../custom_widgets/page_container/page_container.dart';
import '../controller/auth_controller.dart';
import 'register_screen.dart';

class RegistrationOtpArgs {
  final String countryCode;
  final String mobile;
  final String code;

  RegistrationOtpArgs({
    required this.countryCode,
    required this.mobile,
    required this.code,
  });
}

class RegistrationOtpScreen extends StatefulWidget {
  final RegistrationOtpArgs args;
  const RegistrationOtpScreen({super.key, required this.args});
  static const String routeName = 'RegistrationOtpScreen';

  @override
  State<RegistrationOtpScreen> createState() => _RegistrationOtpScreenState();
}

class _RegistrationOtpScreenState extends State<RegistrationOtpScreen> {
  late String _code;
  final _codeEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _code = widget.args.code;
    _startTimer();
    super.initState();
  }

  late Timer _timer;
  int _time = 60;

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_time == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _time--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _codeEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      statusBarColor: AppColor.authScaffoldColor(context),
      child: Scaffold(
        backgroundColor: AppColor.authScaffoldColor(context),
        appBar: CustomAppBar(
          context,
          appBarColor: AppColor.authScaffoldColor(context),
          automaticallyImplyLeading: true,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                EasyRichText(
                  tr(AppLocaleKey.createANewAccount),
                  defaultStyle: AppTextStyle.textD24B(context),
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'حساب جديد',
                      style: AppTextStyle.textS24B(context),
                    ),
                  ],
                ),
                const Gap(50),
                const Image(
                  image: AssetImage(AppImages.otpImage),
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                const Gap(15),
                Center(
                  child: Text(
                    tr(
                      AppLocaleKey.theCodeHasBeenSentTo,
                      args: [
                        '+${widget.args.countryCode}${widget.args.mobile}'
                      ],
                    ),
                    style: AppTextStyle.textD16R(context),
                  ),
                ),
                const Gap(60),
                Center(
                  child: Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: Pinput(
                      controller: _codeEC,
                      defaultPinTheme: PinTheme(
                        height: 56,
                        width: 56,
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: AppColor.darkTextColor(context),
                          fontWeight: FontWeight.w800,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.offWhiteColor(context),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        height: 56,
                        width: 56,
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: AppColor.mainAppColor(context),
                          fontWeight: FontWeight.w800,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.mainAppColor(context),
                          ),
                          color: AppColor.offWhiteColor(context),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        height: 56,
                        width: 56,
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: AppColor.mainAppColor(context),
                          fontWeight: FontWeight.w800,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.mainAppColor(context),
                          ),
                          color: AppColor.offWhiteColor(context),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      errorPinTheme: PinTheme(
                        height: 56,
                        width: 56,
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: AppColor.mainAppColor(context),
                          fontWeight: FontWeight.w800,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.offWhiteColor(context),
                          border: Border.all(
                            color: Colors.red.shade700,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      errorBuilder: (errorText, pin) {
                        return Align(
                          alignment: context.getByLang(
                            ar: AlignmentDirectional.centerEnd,
                            en: AlignmentDirectional.centerStart,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              errorText!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red.shade700,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      },
                      validator: (s) {
                        return s!.trim().length == 4
                            ? null
                            : context.apiTr(
                                ar: 'الكود مكون من اربعة ارقام',
                                en: 'The code consists of four digits',
                              );
                      },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onCompleted: (pin) {
                        if (_formKey.currentState!.validate()) {
                          if (_codeEC.text == _code) {
                            NavigatorMethods.pushReplacementNamed(
                              context,
                              RegisterScreen.routeName,
                              arguments: RegisterArgs(
                                countryCode: widget.args.countryCode,
                                mobile: widget.args.mobile,
                              ),
                            );
                          } else {
                            CommonMethods.showError(
                              message: context.apiTr(
                                ar: 'الكود غير صحيح',
                                en: 'The code isn\'t correct',
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
                const Gap(20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      if (_time == 0) {
                        context.read<AuthController>().sendSMS(
                              countryCode: widget.args.countryCode,
                              mobile: widget.args.mobile.removeZero(),
                              onSuccess: (v) {
                                setState(() {
                                  _time = 60;
                                  _code = v;
                                });
                                _startTimer();
                              },
                            );
                      } else {
                        CommonMethods.showToast(
                          message: tr(AppLocaleKey.waitTime),
                          type: ToastType.warning,
                        );
                      }
                    },
                    child: Text(
                      _time == 0
                          ? tr(AppLocaleKey.resendTheCode)
                          : tr(
                              AppLocaleKey.resendTheCodeInSeconds,
                              args: ['$_time'],
                            ),
                      style: AppTextStyle.textD16R(context),
                    ),
                  ),
                ),
                const Gap(30),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_codeEC.text == _code) {
                        NavigatorMethods.pushReplacementNamed(
                          context,
                          RegisterScreen.routeName,
                          arguments: RegisterArgs(
                            countryCode: widget.args.countryCode,
                            mobile: widget.args.mobile,
                          ),
                        );
                      } else {
                        CommonMethods.showError(
                          message: context.apiTr(
                            ar: 'الكود غير صحيح',
                            en: 'The code isn\'t correct',
                          ),
                        );
                      }
                    }
                  },
                  text: tr(AppLocaleKey.confirm),
                  style: AppTextStyle.textW16B(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
