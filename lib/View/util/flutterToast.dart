import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

fluttertoastbar(String message) {
  return Fluttertoast.showToast(
      backgroundColor: Colors.grey.shade800.withOpacity(0.7),
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 12.0);
}
