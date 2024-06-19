import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFieldLogin extends StatelessWidget {
  const CustomTextFormFieldLogin({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.controller,
    this.obscureText = false,
  });

  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        errorMaxLines: 5,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        labelText: hintText,
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
        hintStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
        hintText: hintText,
      ),
    );
  }
}
