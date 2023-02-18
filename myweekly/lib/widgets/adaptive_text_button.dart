import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String? enterText;
  final Function()? onPressedFunction;

  const AdaptiveTextButton({
    super.key,
    required this.enterText,
    required this.onPressedFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressedFunction,
            child: Text(
              enterText!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ))
        : TextButton(
            onPressed: onPressedFunction,
            child: Text(
              enterText!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ));
  }
}
