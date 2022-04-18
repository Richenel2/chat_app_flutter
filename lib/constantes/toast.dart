import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms/constantes/theme.dart';

class Toast {
  static void showDefaultToast(String toast) {
    Fluttertoast.showToast(
        msg: toast,
        textColor: Colors.white,
        backgroundColor: MyColor.primaryGreen);
  }

  static void showAlertToast(String toast) {
    Fluttertoast.showToast(
        msg: toast, textColor: Colors.white, backgroundColor: Colors.red);
  }
}
