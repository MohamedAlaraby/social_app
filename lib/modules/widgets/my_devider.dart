import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget{
  const MyDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 20.0),
      child: Container(
        height: 1,
        color: Colors.grey[300],
      ),
    );
  }

}