import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final bool _obscureText;
  final IconData _prefixIconData;
  final String _hintText;
  final Function(String st) _validator;
  final TextInputType _keyboardType;
  final Function(String) _onChanged;

  TextInputWidget(this._obscureText, this._prefixIconData, this._hintText,
      this._validator, this._keyboardType, this._onChanged);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Color(0xFFEFF0F2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: TextFormField(
        keyboardType: _keyboardType,
        obscureText: _obscureText,
        obscuringCharacter: '#',
        validator: _validator,
        onChanged: _onChanged,
        decoration: InputDecoration(
            focusedBorder:
                UnderlineInputBorder(borderRadius: BorderRadius.circular(15)),
            border:
                UnderlineInputBorder(borderRadius: BorderRadius.circular(15)),
            prefixIcon: Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: ShapeDecoration(
                color: Color(0xFF3C63FE),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
              ),
              child: Icon(
                _prefixIconData,
                color: Colors.white,
              ),
            ),
            hintText: _hintText),
      ),
    );
  }
}
