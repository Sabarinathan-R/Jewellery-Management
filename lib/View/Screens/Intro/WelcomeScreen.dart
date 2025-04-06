import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jewellery_management/Theme/Colors.dart';
import 'package:jewellery_management/Theme/Fonts.dart';

import '../LoginRegister/LoginScreen.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/Images/Welcome_BG.jpg",
              fit: BoxFit.cover, height: Get.height, width: Get.width),
          Container(
            color: blackColor.withOpacity(.4),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Text(
                "Welcome",
                style: AppTextStyles.heading
                    .copyWith(color: whiteColor, fontSize: 40.r),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Experience seamless jewellery billing and inventory management. Streamline your business with our Golden Jewellery Billing App",
                  style: AppTextStyles.body.bold
                      .copyWith(color: whiteColor, fontSize: 16.r),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.r),
                child: SizedBox(
                    height: 50.r,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                        onPressed: () {
                          Get.to(() => const Loginscreen());
                        },
                        child: Text(
                          "GET STARTED",
                          style: AppTextStyles.subHeading
                              .withColor(whiteColor)
                              .withSize(16.r)
                              .copyWith(
                                  fontWeight: FontWeight.w800,
                                  height: 0,
                                  letterSpacing: 1),
                        ))),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
