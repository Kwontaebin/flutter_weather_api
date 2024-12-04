import 'package:flutter/material.dart';
import 'package:flutter_weather_api/common/component/custom_elevatedButton.dart';
import 'package:flutter_weather_api/common/component/custom_text_field.dart';
import 'package:flutter_weather_api/common/function/sizeFn.dart';

void showDialogModule(
  BuildContext context, {
  required String title,
  required String content,
  required VoidCallback leftButtonOnPressed,
  required VoidCallback rightButtonOnPressed,
  String leftButton = "취소",
  String rightButton = "확인",
}) {
  showDialog(
    context: context,
    barrierDismissible: false, // 바깥 부분을 클릭하면 다이얼로그가 닫히지 않게 설정
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text(leftButton),
            onPressed: () {
              Navigator.of(context).pop();
              leftButtonOnPressed();
            },
          ),
          TextButton(
            child: Text(rightButton),
            onPressed: () {
              Navigator.of(context).pop();
              rightButtonOnPressed();
            },
          ),
        ],
      );
    },
  );
}

void showTextFieldDialogModule(BuildContext context, {
  required String titleText,
  required String hintText,
  required ValueChanged onChanged,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titleText),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFieldWidget(
              hintText: hintText,
              onChanged: onChanged,
              autoFocus: true,
            )
          ],
        ),
        actions: [
          customElevatedButton(
            width: sizeFn(context).width * 0.08,
            color: const Color.fromRGBO(232, 100, 122, 1.0),
            context,
            text: "검색",
            onPressed: onPressed,
          )
        ],
      );
    },
  );
}
