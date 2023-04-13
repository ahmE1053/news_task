import 'package:flutter/material.dart';

import '../../core/utilities/text_direction.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.colorScheme,
    required this.onSubmitted,
    required this.textDirection,
  });

  final TextEditingController controller;
  final ColorScheme colorScheme;
  final void Function(String?) onSubmitted;
  final ValueNotifier<TextDirection> textDirection;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.length < 5) {
          return 'Please enter a longer term for better results';
        }
        return null;
      },
      textDirection: textDirection.value,
      onChanged: (input) {
        input = input.trim();
        for (int i = 0; i < input.length; i++) {
          if (input[i] == ' ') continue;
          if (double.tryParse(input[i]) == null) {
            textDirection.value = getDirection(input[i]);
            break;
          }
        }
      },
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        errorBorder: outlineInputBorder(colorScheme.error),
        enabledBorder: outlineInputBorder(colorScheme.primaryContainer),
        disabledBorder: outlineInputBorder(Colors.grey),
        focusedErrorBorder: outlineInputBorder(colorScheme.error),
        focusedBorder: outlineInputBorder(colorScheme.primary),
        filled: true,
        fillColor: Colors.white,
        alignLabelWithHint: true,
        labelText: 'Search',
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: color, width: 2),
    );
