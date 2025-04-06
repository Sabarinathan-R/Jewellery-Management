import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jewellery_management/View/util/Formfield.dart';
import 'package:jewellery_management/Theme/Colors.dart';
import 'package:jewellery_management/Theme/appTheme.dart';
import 'package:jewellery_management/View/util/flutterToast.dart';
import '../../../Controller/LoginController.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formSignInKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool? remember = true;
  bool Loading = false;
  bool singnin = false;
  final TextEditingController phoneNumber = TextEditingController();

  final loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  width: Get.width,
                  height: Get.height / 3.5,
                  child: Image.asset(
                    "assets/Images/Login_BG.png",
                    fit: BoxFit.fitHeight,
                  )),
              SizedBox(height: 10.r),
              Text(
                "LOGIN",
                style: GoogleFonts.exo(
                  textStyle: TextStyle(
                    color: blackColor,
                    letterSpacing: .5,
                    fontSize: Get.width / 14,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: kPrimaryColor,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    children: [
                      LRNumberInput(
                        LabelText: "Phone Number",
                        isContactnumber: true,
                        Controller: phoneNumber,
                        HintText: "Enter Phone Number",
                        ValidatorText: "Please Enter Phone Number",
                        IconName: FontAwesomeIcons.phone,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 15),
                      passwordInput(),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                visualDensity: VisualDensity.compact,
                                value: remember,
                                activeColor: kPrimaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    remember = value;
                                  });
                                },
                              ),
                              const Text("Remember me"),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              fluttertoastbar("Available Soon");
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontSize: Get.width / 28,
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: kPrimaryColor,
                                  decorationThickness: 2,
                                  color: blackColor),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                          onPressed: () {
                            if (_formSignInKey.currentState!.validate()) {
                              loginController.login(
                                  phoneNumber.text, _passwordController.text);
                            }
                          },
                          child: Text(
                            loginController.isLoading.value
                                ? "Please Wait..."
                                : "Login",
                            style: TextStyle(
                              fontSize: Get.width / 22,
                              letterSpacing: .5,
                              fontWeight: FontWeight.w800,
                              color: blackColor,
                            ),
                          )),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don’t have an account yet? ",
                          ),
                          GestureDetector(
                            onTap: () {
                              fluttertoastbar("Available Soon");
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: Get.width / 26,
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.underline,
                                  decorationColor: kPrimaryColor,
                                  decorationThickness: 2,
                                  color: blackColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Password",
              style: TextStyle(
                fontSize: Get.width / 28,
                letterSpacing: .5,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              "*",
              style: TextStyle(
                fontSize: Get.width / 28,
                letterSpacing: .5,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: !_isPasswordVisible,
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Enter your Password",
            hintStyle: TextStyle(fontSize: Get.width / 32, color: greyColor80),
            prefixIcon: const Icon(Iconsax.lock5, color: greyColor),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10.0),
            suffixIcon: IconButton(
              iconSize: 20,
              icon: Icon(
                _isPasswordVisible ? Iconsax.eye_slash5 : Iconsax.eye4,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            filled: true,
            fillColor: greyColor10,
            enabledBorder: EnabledBorder(),
            focusedBorder: FocusedBorder(),
            errorBorder: ErrorBorder(),
            focusedErrorBorder: FocusedBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter your Password';
            }
            return null;
          },
        ),
      ],
    );
  }
}
