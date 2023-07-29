import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/colors.dart';

// ignore: must_be_immutable
class DefaultButton extends StatelessWidget {

      double width = double.infinity;
      Color backgroundColor = defaultColor;
      final void Function() function;
      String text;
      double radius = 5.0;

      DefaultButton({
        super.key,
        this.width = double.infinity,
        this.backgroundColor = defaultColor,
        required this.function,
        required this.text,
        this.radius = 5.0
      });

  @override
  Widget build(BuildContext context){
      return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width,
          height: 40,
          child: Container(
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius)
            ),
            child: MaterialButton(
              onPressed: function,
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13
                ),
              ),
            ),
          ),
        ),
      );
  }

}