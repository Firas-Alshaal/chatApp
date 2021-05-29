import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Colors.dart';

ThemeData darkTheme = ThemeData(
  iconTheme: IconThemeData(color: Colors.white),
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      elevation: 0.0,
      backgroundColor: HexColor('333739'),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light),
      titleTextStyle: TextStyle(
          fontFamily: "Janna",
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: "Janna",
      ),
      subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.3,
      )),
  fontFamily: 'Janna',
);

ThemeData lightTheme = ThemeData(
  iconTheme: IconThemeData(color: defaultColor),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      elevation: 0.0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      color: Colors.white,
      titleTextStyle: TextStyle(
          fontFamily: "Janna",
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.black)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        fontFamily: "Janna",
      ),
      subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        height: 1.3,
      )),
  fontFamily: 'Janna',
);
