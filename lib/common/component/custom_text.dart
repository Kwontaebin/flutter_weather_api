import 'package:flutter/material.dart';

Widget customTextWidget({
  required String text,
  double textSize = 18,
  Color textColor = Colors.black,
  FontWeight textFontWeight = FontWeight.w700
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: textSize,
      color: textColor,
      fontWeight: textFontWeight,
    ),
  );
}
