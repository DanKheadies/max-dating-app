import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(bool)? onFocusChanged;
  final Function(String)? onChanged;
  final String hint;

  const CustomTextField({
    super.key,
    this.onFocusChanged,
    this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Focus(
        onFocusChange: onFocusChanged ?? (_) {},
        child: TextField(
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
