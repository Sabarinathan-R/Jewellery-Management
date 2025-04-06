import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jewellery_management/Theme/Colors.dart';
import 'package:jewellery_management/View/Screens/Dashboard/Dashboard.dart';
import 'package:jewellery_management/View/Screens/LoginRegister/LoginScreen.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;

  final validphonenumber = '9876543210';
  final validpassword = 'admin@123';

  void login(String phone, String password) async {
    if (phone.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "All fields are required.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.grey,
          backgroundGradient: const LinearGradient(
            colors: [kPrimaryColor, Color.fromARGB(255, 248, 234, 109)],
          ),
          colorText: blackColor);
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));

    if (phone == validphonenumber && password == validpassword) {
      box.write('isLoggedIn', true);
      box.write('phone', phone);
      Get.snackbar(
          "Login Successful", "Explore the Jewellery Management System",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.grey,
          backgroundGradient: const LinearGradient(
            colors: [kPrimaryColor, Color.fromARGB(255, 248, 234, 109)],
          ),
          colorText: blackColor);
      Get.offAll(() => DashboardScreen());
    } else {
      Get.snackbar("Login Failed", "Invalid phone or password.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.grey,
          backgroundGradient: const LinearGradient(
            colors: [kPrimaryColor, Color.fromARGB(255, 248, 234, 109)],
          ),
          colorText: blackColor);
    }

    isLoading.value = false;
  }

  void logout() {
    box.erase();
    Get.snackbar("Logged out", "your account logged out successful !",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey,
        backgroundGradient: const LinearGradient(
          colors: [kPrimaryColor, Color.fromARGB(255, 248, 234, 109)],
        ),
        colorText: blackColor);
    Get.offAll(() => const Loginscreen());
  }
}
