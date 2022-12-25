import 'package:flutter/material.dart';

class BtnWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  String? text;
  Function()? onTap;
  Color? textColor;
  Color? backgourndColor;
  double? height;
  double? width;
  // ignore: sort_constructors_first
  BtnWidget({required this.text,this.onTap,
    this.textColor,this.backgourndColor,this.height,this.width});
  ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(13),
        height: height ?? 45,
        width: width ?? 100,
        decoration: BoxDecoration(
          color: backgourndColor ?? theme.primaryColor,
          // color: const Color.fromARGB(255, 253, 188, 51),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(
          text!,
          style: TextStyle(color: textColor ?? Colors.white, fontSize: 16.0,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}