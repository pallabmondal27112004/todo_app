import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';

class Customsnackbar {
  static void showCustomSnackBar(
    BuildContext context,
    String? message,
    String icon,
  ) {
    DelightToastBar(
      builder: (context) {
        return ToastCard(
          leading: Icon(
            icon == 'success' ? Icons.check_circle : Icons.error,
            size: 32,
            color: icon == 'success' ? Colors.green : Colors.red,
          ),
          title: Text(
            message ?? " ",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        );
      },
      position: DelightSnackbarPosition.top,
      autoDismiss: true,
      snackbarDuration: Duration(seconds: 2),
    ).show(context);
  }
}
