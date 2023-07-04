import 'package:bloc_getit_practice/utils/app_theme.dart';
import 'package:flutter/material.dart';

Container textFieldError() {
  return Container(
    margin: const EdgeInsets.only(left: 22, top: 10),
    child: Text(
      'This field should not be empty.',
      style: AppTheme.getTextTheme(null).bodySmall!.copyWith(color: Colors.red),
    ),
  );
}
