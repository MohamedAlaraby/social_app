import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
void navigateTo(context, nextScreen) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ));
}

void navigateAndFinish(context, nextScreen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => nextScreen,
    ),
    (route) => false, //to eliminate the last screen.
  );
}
void makeToast({required String message, required ToastStates toastState,}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(toastState),
        textColor: Colors.white,
        fontSize: 16.0
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color? chooseToastColor(ToastStates states) {
  Color? color;
  switch (states) {
    case ToastStates.SUCCESS:
      {
        color = Colors.green;
        break;
      }
    case ToastStates.ERROR:
      {
        color = Colors.red;
        break;
      }
    case ToastStates.WARNING:
      {
        color = Colors.amber;
        break;
      }
  }
  return color;
}

