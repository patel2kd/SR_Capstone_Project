import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Gender { male, female, none }

const String appName = "Alarm Manager Example";
const String durationSeconds = "Seconds";
const String durationMinutes = "Minutes";
const String durationHours = "Hours";
const String oneShotAlarm = "oneShot";
const String oneShotAtAlarm = "oneShotAt";
const String periodicAlarm = "periodic";
const String inseralarmdetail = "/demo/insertalarmdetail.php";
const String login = "/demo/login.php";
const String register = "/demo/register.php";
const String index = "index.php";

const String inseralarms = "/demo/insertalarm.php";
const String repetealarm = "/demo/repetealarm.php";
const String updatealarm = "/demo/updatealarm.php";
const String deletealarm = "/demo/deletealarm.php";
const String deletedetails = "/demo/deletedetail.php";
const String deletehistory = "/demo/deletehistory.php";
const String url = "http://192.168.86.28/demo/";
const String ipadd = "192.168.86.28";
final colorGrey = Colors.grey.withOpacity(0.2);
const colorBlue = Color(0xFF2565CC);
const colorbBlue = Color.fromARGB(255, 235, 235, 235);
const colorDarkBlue = Color(0xFF0A1028);
TextStyle kTextStyleBold(double size) {
  return GoogleFonts.nunito(
    textStyle: TextStyle(
      color: colorDarkBlue,
      fontWeight: FontWeight.w700,
      fontSize: size,
    ),
  );
}

TextStyle kTextStyle(double size) {
  return GoogleFonts.nunito(
    textStyle: TextStyle(
      color: colorDarkBlue,
      fontWeight: FontWeight.w400,
      fontSize: size,
    ),
  );
}

TextStyle kTextStyleBoldWhite(double size) {
  return GoogleFonts.nunito(
    textStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: size,
    ),
  );
}

TextStyle kTextStyleWhite(double size) {
  return GoogleFonts.nunito(
    textStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: size,
    ),
  );
}

Widget kVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// enum Gender { male, female, none }

// const String appName = "Alarm Manager Example";
// const String durationSeconds = "Seconds";
// const String durationMinutes = "Minutes";
// const String durationHours = "Hours";
// const String oneShotAlarm = "oneShot";
// const String oneShotAtAlarm = "oneShotAt";
// const String periodicAlarm = "periodic";
// const String inseralarmdetail = "/insertalarmdetail.php";
// const String login = "/login.php";
// const String register = "/register.php";
// const String index = "/index.php";

// const String inseralarms = "/insertalarm.php";
// const String repetealarm = "/repetealarm.php";
// const String updatealarm = "/updatealarm.php";
// const String deletealarm = "/deletealarm.php";
// const String deletedetails = "/deletedetail.php";
// const String deletehistory = "/deletehistory.php";
// const String url = "http://alertmindalarmapp.000webhostapp.com/";
// const String ipadd = "alertmindalarmapp.000webhostapp.com";
// final colorGrey = Colors.grey.withOpacity(0.2);
// const colorBlue = Color(0xFF2565CC);
// const colorbBlue = Color.fromARGB(255, 235, 235, 235);
// const colorDarkBlue = Color(0xFF0A1028);
// TextStyle kTextStyleBold(double size) {
//   return GoogleFonts.nunito(
//     textStyle: TextStyle(
//       color: colorDarkBlue,
//       fontWeight: FontWeight.w700,
//       fontSize: size,
//     ),
//   );
// }

// TextStyle kTextStyle(double size) {
//   return GoogleFonts.nunito(
//     textStyle: TextStyle(
//       color: colorDarkBlue,
//       fontWeight: FontWeight.w400,
//       fontSize: size,
//     ),
//   );
// }

// TextStyle kTextStyleBoldWhite(double size) {
//   return GoogleFonts.nunito(
//     textStyle: TextStyle(
//       color: Colors.white,
//       fontWeight: FontWeight.w700,
//       fontSize: size,
//     ),
//   );
// }

// TextStyle kTextStyleWhite(double size) {
//   return GoogleFonts.nunito(
//     textStyle: TextStyle(
//       color: Colors.white,
//       fontWeight: FontWeight.w400,
//       fontSize: size,
//     ),
//   );
// }

// Widget kVerticalSpace(double height) {
//   return SizedBox(
//     height: height,
//   );
// }
