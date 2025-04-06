import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jewellery_management/Theme/Colors.dart';
import 'Controller/Internet_Controller/dependency_injector.dart';
import 'Theme/appTheme.dart';
import 'View/Screens/Dashboard/Dashboard.dart';
import 'View/Screens/Intro/WelcomeScreen.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const Jewellery_Management());
  DependencyInjection.init();
}

class Jewellery_Management extends StatefulWidget {
  const Jewellery_Management({super.key});

  @override
  State<Jewellery_Management> createState() => _Jewellery_ManagementState();
}

class _Jewellery_ManagementState extends State<Jewellery_Management> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = box.read('isLoggedIn') ?? false;
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(context),
          home: AnimatedSplashScreen(
            splash: Image.asset("assets/Images/logo.png"),
            splashIconSize: 100,
            backgroundColor: blackColor,
            nextScreen: isLoggedIn ? DashboardScreen() : const Welcomescreen(),
            splashTransition: SplashTransition.fadeTransition,
            animationDuration: const Duration(seconds: 2),
          ),
          //  initialRoute: AppRoutes.splashScreen,
          // getPages: AppRoutes.getPages,
          // unknownRoute: AppRoutes.unknown,
        );
      },
    );
  }
}
