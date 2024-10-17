import 'dart:ui' as ui;

import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../helpers/extension/context_extension.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/app_text_style.dart';
import '../../../helpers/utils/country_code_methods.dart';
import 'svg_prefix_icon.dart';

enum FormFieldBorder { underLine, outLine, none }

class CustomFormField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? hintText;
  final int? maxLines;
  final void Function()? onTap;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double radius;
  final Color? fillColor;
  final Color? focusColor;
  final Color? unFocusColor;
  final Color? passwordColor;
  final String? title;
  final String? otherSideTitle;
  final ui.TextDirection? textDirection;
  final Country? country;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(Country)? onCountrySelect;
  final FormFieldBorder formFieldBorder;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final String? prefixSvg;
  const CustomFormField({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.hintText,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.radius = 10,
    this.fillColor,
    this.focusColor,
    this.unFocusColor,
    this.title,
    this.textDirection,
    this.otherSideTitle,
    this.country,
    this.passwordColor,
    this.formFieldBorder = FormFieldBorder.outLine,
    this.inputFormatters,
    this.onCountrySelect,
    this.titleStyle,
    this.textStyle,
    this.hintStyle,
    this.prefixSvg,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = true;
  bool _isFocus = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _isFocus = true;
        });
      } else {
        setState(() {
          _isFocus = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.title != null) ...{
                Expanded(
                  child: Text(
                    widget.title!,
                    style: widget.titleStyle ??
                        AppTextStyle.formTitleStyle(context),
                  ),
                ),
              },
              if (widget.otherSideTitle != null) ...{
                Text(
                  widget.otherSideTitle!,
                  style:
                      widget.titleStyle ?? AppTextStyle.formTitleStyle(context),
                ),
              }
            ],
          ),
          if (widget.title != null || widget.otherSideTitle != null) ...{
            const SizedBox(height: 10),
          },
          Directionality(
            textDirection: widget.textDirection != null
                ? widget.textDirection!
                : context.isRTL()
                    ? ui.TextDirection.rtl
                    : ui.TextDirection.ltr,
            child: TextFormField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              focusNode: _focusNode,
              controller: widget.controller,
              onChanged: widget.onChanged,
              validator: widget.validator,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              keyboardType: widget.keyboardType,
              obscureText: widget.isPassword ? _obscureText : false,
              style: widget.textStyle ?? AppTextStyle.textFormStyle(context),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLines: widget.maxLines,
              cursorColor: widget.focusColor ?? AppColor.mainAppColor(context),
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                hintMaxLines: 2,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ??
                    AppTextStyle.hintStyle(context).copyWith(
                      color: _isFocus
                          ? AppColor.darkTextColor(context)
                          : AppColor.hintColor(context),
                    ),
                fillColor: widget.fillColor ??
                    (widget.formFieldBorder == FormFieldBorder.underLine
                        ? Colors.transparent
                        : (_isFocus
                            ? Colors.transparent
                            : AppColor.textFormFillColor(context))),
                filled: true,
                border: _border(
                    color: widget.unFocusColor ??
                        AppColor.textFormBorderColor(context)),
                disabledBorder: _border(
                    color: widget.unFocusColor ??
                        AppColor.textFormBorderColor(context)),
                focusedBorder: _border(
                    color:
                        widget.unFocusColor ?? AppColor.mainAppColor(context)),
                enabledBorder: _border(
                    color: widget.unFocusColor ??
                        AppColor.textFormBorderColor(context)),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                prefixIcon: widget.country != null &&
                        context.locale == const Locale('en')
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.prefixSvg != null
                              ? SvgPrefixIcon(
                                  imagePath: widget.prefixSvg!,
                                  color: _isFocus
                                      ? AppColor.mainAppColor(context)
                                      : AppColor.hintColor(context),
                                )
                              : widget.prefixIcon ?? const SizedBox(),
                          TextButton(
                            onPressed:
                                widget.onCountrySelect != null ? _select : null,
                            child: Text(
                              '+${widget.country?.phoneCode}',
                              style: widget.textStyle ??
                                  AppTextStyle.textFormStyle(context),
                              textDirection: ui.TextDirection.ltr,
                            ),
                          ),
                        ],
                      )
                    : widget.prefixSvg != null
                        ? SvgPrefixIcon(
                            imagePath: widget.prefixSvg!,
                            color: _isFocus
                                ? AppColor.mainAppColor(context)
                                : AppColor.hintColor(context),
                          )
                        : widget.prefixIcon,
                suffixIcon: widget.country != null &&
                        context.locale == const Locale('ar')
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed:
                                widget.onCountrySelect != null ? _select : null,
                            child: Text(
                              '+${widget.country?.phoneCode}',
                              style: widget.textStyle ??
                                  AppTextStyle.textFormStyle(context),
                              textDirection: ui.TextDirection.ltr,
                            ),
                          ),
                          widget.suffixIcon ?? const SizedBox(),
                        ],
                      )
                    : widget.isPassword
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                              color: widget.passwordColor ??
                                  AppColor.hintColor(context),
                            ),
                          )
                        : widget.suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputBorder _border({
    required Color color,
  }) {
    switch (widget.formFieldBorder) {
      case FormFieldBorder.outLine:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(
            color: color,
          ),
        );
      case FormFieldBorder.underLine:
        return UnderlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(
            color: color,
          ),
        );
      case FormFieldBorder.none:
        return InputBorder.none;
    }
  }

  void _select() {
    CountryCodeMethods.pickCountry(
      onSelect: (v) {
        widget.onCountrySelect?.call(v);
      },
      context: context,
    );
  }
}
