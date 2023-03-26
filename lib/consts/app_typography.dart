import 'package:flutter/material.dart';

//Different font sizes for the app that are responsive and not constant
class AppTypography {
  static TextStyle headlineSize(BuildContext context, [Color? color]) =>
      TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.08,
        fontWeight: FontWeight.w800,
        color: color ?? Colors.black,
      );

  static TextStyle semiHeadlineSize(BuildContext context, [Color? color]) =>
      TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.065,
        fontWeight: FontWeight.w600,
        color: color ?? Colors.black,
      );

  static TextStyle bodySize(BuildContext context, [Color? color]) => TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.05,
        color: color ?? Colors.black,
      );

  static TextStyle semiBodySize(BuildContext context, [Color? color]) =>
      TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.04,
        color: color ?? Colors.black,
      );

  static TextStyle smallSize(BuildContext context, [Color? color]) => TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.03,
        fontWeight: FontWeight.w300,
        color: color ?? Colors.black,
      );
}
