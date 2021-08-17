import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextfield extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final Function(String) onSubmitted;
  final String labelText;

  AdaptiveTextfield({
    this.controller,
    this.onSubmitted,
    this.inputType = TextInputType.text,
    this.labelText = '',
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: controller,
              keyboardType: inputType,
              onSubmitted: onSubmitted,
              placeholder: labelText,
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            controller: controller,
            keyboardType: inputType,
            onSubmitted: (value) => onSubmitted,
            decoration: InputDecoration(
              labelText: labelText,
            ),
          );
  }
}
