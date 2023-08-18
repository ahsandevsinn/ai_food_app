import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:flutter/material.dart';


class CustomAppFormField extends StatefulWidget {
  final double? height;
  final double? width;
  final bool containerBorderCondition;
  final String texthint;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final double? cursorHeight;
  final TextAlign textAlign;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? prefixIconColor;
  final Color? suffixIconColor;

  CustomAppFormField(
      {Key? key,
      this.containerBorderCondition = false,
      required this.texthint,
      required this.controller,
      this.validator,
      this.height,
      this.width,
      this.obscureText = false,
      this.onChanged,
      this.onTap,
      this.onTapOutside,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.cursorHeight,
      this.textAlign = TextAlign.start, this.prefix, this.suffix, this.prefixIcon, this.suffixIcon, this.prefixIconColor, this.suffixIconColor})
      : super(key: key);

  @override
  State<CustomAppFormField> createState() => _CustomAppFormFieldState();
}

class _CustomAppFormFieldState extends State<CustomAppFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: widget.width,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            onTapOutside: widget.onTapOutside,
            onFieldSubmitted: widget.onFieldSubmitted,
            cursorHeight: widget.cursorHeight,
            textAlign: widget.textAlign,
            key: widget.key,
            obscureText: widget.obscureText,
            validator: widget.validator,
            controller: widget.controller,
            cursorColor: AppTheme.appColor,
            style: TextStyle(color: AppTheme.appColor),
            decoration: InputDecoration(
              
              prefixIconColor: widget.prefixIconColor,
              suffixIconColor: widget.suffixIconColor,

              prefix: widget.prefix,
                suffix: widget.suffix,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                contentPadding: EdgeInsets.only(left: 10, bottom: 5),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.appColor)),
                disabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: AppTheme.appColor,
                )),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.appColor)),
                hintText: "${widget.texthint}",
                hintStyle: TextStyle(color: AppTheme.appColor)),
          ),
        ));
  }
}