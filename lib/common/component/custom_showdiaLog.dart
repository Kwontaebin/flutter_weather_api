import 'package:flutter/material.dart';

void showMyDialog(
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
