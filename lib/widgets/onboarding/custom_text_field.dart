import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final String initialValue;
  final EdgeInsets padding;
  final Function(bool)? onFocusChanged;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.hint = '',
    this.initialValue = '',
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.onFocusChanged,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Focus(
        onFocusChange: onFocusChanged ?? (_) {},
        child: TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hint,
            contentPadding: const EdgeInsets.only(
              bottom: 5,
              top: 12.5,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
