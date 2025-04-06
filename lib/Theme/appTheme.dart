import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Colors.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: primaryMaterialColor,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: backgroundColor,
      iconTheme: const IconThemeData(color: blackColor),
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      canvasColor: whiteColor,
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryMaterialColor,
          selectionColor: primaryMaterialColor[100],
          selectionHandleColor: primaryMaterialColor),
      elevatedButtonTheme: elevatedButtonThemeData,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          circularTrackColor: whiteColor, color: kPrimaryColor),
      textButtonTheme: textButtonThemeData,
      outlinedButtonTheme: outlinedButtonTheme(),
      listTileTheme: ListTileThemeData(
          tileColor: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          shape: CircleBorder(),
          backgroundColor: kPrimaryColor,
          foregroundColor: blackColor),

      //  inputDecorationTheme: lightInputDecorationTheme,
      checkboxTheme: checkboxThemeData.copyWith(
        overlayColor: const WidgetStatePropertyAll(kPrimaryColor),
        checkColor: const WidgetStatePropertyAll(blackColor),
        side: const BorderSide(color: blackColor40),
        splashRadius: 10,
        visualDensity: VisualDensity.compact,
      ),
      appBarTheme: appBarLightTheme,
      // scrollbarTheme: scrollbarThemeData,
      // dataTableTheme: dataTableLightThemeData,
    );
  }
}

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  checkColor: WidgetStateProperty.all(Colors.white),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(6),
    ),
  ),
  side: const BorderSide(color: whiteColor40),
);
const AppBarTheme appBarLightTheme = AppBarTheme(
  backgroundColor: Colors.white,
  elevation: 0,
  iconTheme: IconThemeData(color: blackColor),
  titleTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: blackColor,
  ),
);

//Button Themes
ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(16),
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 32),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
);

OutlinedButtonThemeData outlinedButtonTheme(
    {Color borderColor = blackColor10}) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.all(16),
      minimumSize: const Size(double.infinity, 32),
      side: BorderSide(width: 1.5, color: borderColor),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );
}

final textButtonThemeData = TextButtonThemeData(
  style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
);

//Form Border Designs
EnabledBorder() {
  return const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
      width: 1.5,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  );
}

SearchEnabledBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.shade300,
      width: 1.0,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(10),
    ),
  );
}

FocusedBorder() {
  return const OutlineInputBorder(
    borderSide: BorderSide(
      color: kPrimaryColor,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  );
}

ErrorBorder() {
  return const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  );
}

FocusedErrorBorder() {
  return const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  );
}

//Login Flow App theme
AppBar loginflowappBar() {
  return AppBar(
    backgroundColor: backgroundColor,
    surfaceTintColor: backgroundColor,
  );
}

AppBar iconAppBarBackgroundless(
    {Widget? title,
    bool centerTitle = false,
    bool implyLeading = true,
    List<Widget>? actions,
    VoidCallback? onPressed,
    Color widgetcolor = blackColor,
    Color appBackgroundColor = Colors.transparent}) {
  return AppBar(
    automaticallyImplyLeading: implyLeading,
    title: title,
    centerTitle: centerTitle,
    titleTextStyle: GoogleFonts.inter(
      textStyle: TextStyle(
        color: widgetcolor,
        letterSpacing: .5,
        fontSize: Get.width / 22,
        fontWeight: FontWeight.w600,
      ),
    ),
    surfaceTintColor: appBackgroundColor,
    backgroundColor: appBackgroundColor,
    leading: implyLeading
        ? InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onPressed ??
                () {
                  Get.back();
                },
            child: Image.asset(
              "assets/Icons/backarrow.png",
              scale: 3,
              color: widgetcolor,
            ),
          )
        : null,
    actions: actions,
  );
}

labelTitle(String labelText) {
  return Text(
    labelText,
    style: TextStyle(
      fontSize: Get.width / 28,
      letterSpacing: .5,
      fontWeight: FontWeight.w600,
      color: blackColor,
    ),
  );
}
