import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final List<TextInputFormatter> inputFormatters;
  final bool isPassword;
  final Color cursorColor;
  final bool enabled;
  final int maxLength;
  final int maxLines;
  final String labelText;
  final String hintText;
  final GlobalKey<FormState> formKey;
  final bool required;
  final String validator;
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.inputFormatters,
    this.isPassword = false,
    required this.cursorColor,
    required this.enabled,
    required this.maxLength,
    required this.maxLines,
    required this.formKey,
    required this.required,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      obscureText: isPassword,
      cursorColor: cursorColor,
      enabled: enabled,
      validator: validator == "email"
          ? ValidationBuilder().email().build()
          : validator == "password"
              ? ValidationBuilder().minLength(8).build()
              : validator == "phone"
                  ? ValidationBuilder().phone().build()
                  : ValidationBuilder().required().build(),
      decoration: InputDecoration(
        labelText: isPassword ? 'Enter Password' : labelText,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        border: const OutlineInputBorder(),
      ),
      maxLength: maxLength,
      maxLines: maxLines,
    );
  }
}
