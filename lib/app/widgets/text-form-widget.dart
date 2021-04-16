import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final label;
  final Function(String) onChanged;
  final bool isObscure;
  final Icon icon;
  final void Function(String) onFieldSubmitted;
  final TextInputType inputType;
  final Iterable<String> autofillHints;
  final String Function(String value) validator;

  const TextFormFieldWidget({this.label,
    this.onChanged,
    this.isObscure,
    this.icon,
    this.onFieldSubmitted,
    this.inputType,
    this.validator, this.controller, this.autofillHints});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[100]))),
      child: TextFormField(
        autofillHints: autofillHints,
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        onChanged: onChanged,
        obscureText: isObscure,
        keyboardType: inputType,
        style: GoogleFonts.muli(color: Colors.black),
        validator: validator,
        decoration: InputDecoration(
          // errorText: widget.errorText == null ? null : widget.errorText(),
            errorStyle: GoogleFonts.muli(),
            prefixIcon: icon,
            border: InputBorder.none,
            hintText: label,
            hintStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
}
