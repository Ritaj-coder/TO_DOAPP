import 'package:flutter/material.dart';
import 'package:to_do_app1/app_Colors.dart';

class CustomerForm extends StatelessWidget {
  String label;

  TextEditingController controller;

  TextInputType keyboardtype;

  bool obscureText;

  String? Function(String?) validator;

  CustomerForm(
      {required this.label,
      required this.controller,
      this.keyboardtype = TextInputType.text,
      this.obscureText = false,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.PrimaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.PrimaryColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.RedColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.RedColor)),
        ),
        controller: controller,
        keyboardType: keyboardtype,
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
