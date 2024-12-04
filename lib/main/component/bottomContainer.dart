import 'package:flutter/material.dart';

import '../../common/function/sizeFn.dart';

Widget bottomContainer(
  BuildContext context, {
  required IconData icon,
  required String mainText,
  required String subText,
  double fontSize = 18,
  FontWeight fontWeight = FontWeight.w500,
}) {
  final textStyleModule = TextStyle(
    color: Colors.white,
    fontWeight: fontWeight,
    fontSize: fontSize,
  );

  return SizedBox(
    width: sizeFn(context).width * 0.3,
    height: deviceHeight(context) * 0.15,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        SizedBox(height: deviceHeight(context) * 0.005),
        Text(
          mainText,
          style: textStyleModule,
        ),
        Text(
          subText,
          style: textStyleModule,
        )
      ],
    ),
  );
}
