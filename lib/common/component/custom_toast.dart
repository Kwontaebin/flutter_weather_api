import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void customToast({
  required String message,
  Color color= Colors.blue,
}) {
  Fluttertoast.showToast(
    msg: message, // 표시할 메시지
    toastLength: Toast.LENGTH_SHORT, // 지속 시간 (SHORT or LONG)
    gravity: ToastGravity.TOP, // 화면 위치
    backgroundColor: color, // 배경색
    textColor: Colors.white, // 텍스트 색상
    fontSize: 16.0, // 텍스트 크기
  );
}