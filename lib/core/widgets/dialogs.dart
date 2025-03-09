import 'package:flutter/material.dart';
import 'package:taskati_task/core/utils/app_colors.dart';
import 'package:taskati_task/core/utils/text_styles.dart';

showErrorToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.redColor,
      content: Text(
        message,
        style: getSmallTextStyle(color: AppColors.whiteColor),
      )));
}
