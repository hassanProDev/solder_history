import 'package:flutter/material.dart';

class GlobalTextFormField extends StatelessWidget {
  String? text;
  String? regexCondition;
  TextEditingController? controller;
  bool isPassword;
  bool? enabled;
  IconData? iconData;
  Function? onClick;
  TextInputType? keyboardType;
  Function(String)? onChange;
  String? Function(String?)? validator;
  TextInputAction? textInputAction;
  void Function(String)? onFieldSubmitted;
  FocusNode? focusNode;
  bool autofocus;

  GlobalTextFormField({
    this.focusNode,
    this.autofocus = false,
    this.regexCondition,
    this.text,
    this.controller,
    this.iconData,
    this.onClick,
    this.keyboardType,
    this.isPassword = false,
    this.onChange,
    this.validator,
    this.enabled,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        maxLines: isPassword ? 1 : null,
        autofocus: autofocus,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        // textInputAction: textInputAction,
        onChanged: onChange,
        validator: validator ??
            (value){
              if (value == null || value.isEmpty) {
                return "Please Enter $text Currect";
              }
              if (regexCondition != null) {
                if (!RegExp('$regexCondition').hasMatch(value)) {
                  return 'your $text must be $regexCondition';
                }
              }
            },
        enabled: enabled,
        controller: controller,
        // obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          labelText: text!.toUpperCase(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          // prefixIcon: iconData != null
          //     ? InkWell(
          //         onTap: () {
          //           onClick!();
          //         },
          //         child: Icon(
          //           iconData,
          //           // color: ColorManager.darkOrangeColor,
          //         ),
          //       )
          //     : SizedBox(),
        ),
      ),
    );
  }
}
