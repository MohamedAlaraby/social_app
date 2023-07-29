import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget{

  TextEditingController controller;
  TextInputType textInputType;
  String? Function(String? string)? validator ;
  String label;
  IconData prefix;
  IconButton? suffix;
  Function(String string)? onFieldSubmitted;
  Function(String string)? onChange;
  Function()? onTap;
  bool isClickable = true;
  bool isPassword = false; //the default is to hide the password.

  DefaultTextFormField({
    super.key,
    required this.controller,
    required this.textInputType,
    required this.validator,
    required this.label,
    required this.prefix,
     this.suffix,
     this.onFieldSubmitted,
     this.onChange,
     this.onTap,
     this.isClickable = true,
     this.isPassword = false, //the default is to hide the password.
  });

  @override
  Widget build(BuildContext context) {

  return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      //do you want to show the password or not.
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix,
          border: const OutlineInputBorder(),
      ),
      keyboardType: textInputType,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChange,
      onTap: onTap,
      enabled: isClickable,
  );

  }


}