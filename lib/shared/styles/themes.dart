import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';
ThemeData lightTheme=ThemeData(
  fontFamily: 'Jannah',
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    titleSpacing: 20.0,
    backgroundColor: Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
    ),
    titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(

   bodyLarge:  TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'Jannah',
   ),
   bodySmall:  TextStyle(
     color: Colors.black,
     fontSize: 14.0,
     fontWeight: FontWeight.w600,
     fontFamily: 'Jannah',
   ),
   titleSmall: TextStyle(
     color: Colors.black,
     fontSize: 16.0,
     fontWeight: FontWeight.w600,
     fontFamily: 'Jannah',
    ),

  ),
);
ThemeData darkTheme= ThemeData(
    fontFamily: 'Jannah',
    scaffoldBackgroundColor: HexColor('333739'),
    primarySwatch: defaultColor ,

    appBarTheme: AppBarTheme
    (

        iconTheme: const IconThemeData(
          color: Colors.white,

        ),
        backgroundColor: HexColor('333739'),
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
           statusBarColor: HexColor('333739'),
           statusBarIconBrightness: Brightness.light,
        ),


        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold
        ),
    ),
   bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
   textTheme: const TextTheme(
    bodyLarge:  TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium:  TextStyle(
      color: Colors.grey,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
       color: Colors.white,
       fontSize: 20.0,
       fontWeight: FontWeight.w600,
    ),

  ),
);
