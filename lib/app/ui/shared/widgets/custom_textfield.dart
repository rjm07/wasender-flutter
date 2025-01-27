import 'package:flutter/material.dart';
import 'package:wasender/app/utils/lang/colors.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.isObscure,
    required this.controller,
    required this.validator,
    required this.onChanged,
    required this.suffixIcon,
    this.onTap,
  });

  final String label;
  final String hintText;
  final bool isObscure;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final IconButton? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: SizedBox(
        child: TextFormField(
          onTap: onTap,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          style: const TextStyle(color: Colors.black, fontSize: 14.0),
          autocorrect: false,
          obscureText: isObscure,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            labelText: label,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black54, fontSize: 14.0),
            labelStyle: const TextStyle(color: Colors.black54, fontSize: 14.0),
            focusColor: Colors.black54,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black54, // Color when the field is not focused
                width: 1.0, // Optional: set a smaller width for the default border
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red, // Color for the border when there's an error and it's focused
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          // validator: validator,
        ),
      ),
    );
  }
}

class WidgetWithOutlineTextField extends StatelessWidget {
  const WidgetWithOutlineTextField({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
    required this.textAlign,
    required this.textInputType,
    this.suffixText,
    this.suffixColor,
    this.onTap,
    this.prefixText,
    this.prefixColor,
    this.focusNode,
    this.autoFocus,
    this.description,
  });

  final String label;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextAlign textAlign;
  final TextInputType textInputType;
  final String? prefixText;
  final Color? prefixColor;
  final String? suffixText;
  final Color? suffixColor;
  final FocusNode? focusNode;
  final bool? autoFocus;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.black, fontSize: 16.0),
          textAlign: textAlign,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100], // Light background color similar to the image
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey[600], fontSize: 12.0), // Smaller and gray
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5), // Removes the border
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5), // Inactive outline
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5), // Active outline when focused
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Adjust padding to match appearance
            prefixText: prefixText,
            prefixStyle: TextStyle(color: prefixColor),
            suffixText: suffixText,
            suffixStyle: TextStyle(color: suffixColor),
          ),
          keyboardType: textInputType,
          onChanged: onChanged,
          onTap: onTap,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0, left: 16.0, right: 16.0),
          child: Text(description ?? "", style: TextStyle(fontSize: 12, color: Colors.black38)),
        ),
      ],
    );
  }
}
