import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Theme/Colors.dart';

showLogoutConfirmationDialog(BuildContext context, VoidCallback onPressed) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Image.asset(
          "assets/Icons/Alert.png",
          height: Get.width / 6,
          scale: 3,
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: TextStyle(color: blackColor, fontSize: Get.width / 26),
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: <Widget>[
          SizedBox(
            width: Get.width / 4,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: whiteColor,
                    fontSize: Get.width / 26,
                    fontWeight: FontWeight.w600,
                  ))),
            ),
          ),
          SizedBox(
            width: Get.width / 4,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),
              onPressed: onPressed,
              child: Text('Logout',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: whiteColor,
                    fontSize: Get.width / 26,
                    fontWeight: FontWeight.w600,
                  ))),
            ),
          ),
        ],
      );
    },
  );
}
