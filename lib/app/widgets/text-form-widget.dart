import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  final label;
  final Function(String) onChanged;
  final bool isObscure;
  final Icon icon;
  final TextInputType inputType;
  final String Function(String value) validator;

  const TextFormFieldWidget(
      {this.label,
      this.onChanged,
      this.isObscure,
      this.icon,
      this.inputType,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[100]))),
      child: TextFormField(
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
