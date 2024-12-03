import 'package:dio/dio.dart';
import '../const/data.dart';

void postDio({
  required Map<String, dynamic> postData,
  required String url,
}) async {
  Dio dio = Dio();

  try {
    // POST 요청을 보내고 응답을 받습니다.
    Response response = await dio.post(
      "$IP/$url",
      data: postData,
      options: Options(
        validateStatus: (status) {
          return status! <= 500; // 500 이상의 상태 코드는 예외를 발생시킴
        },
      ),
    );

    // 서버 응답 상태 코드가 200일 경우
    if (response.statusCode == 200) {
      print('Login successful: ${response.data}');
    }
    // 서버 응답 상태 코드가 401일 경우 (로그인 실패)
    else if (response.statusCode == 401) {
      print('유저 정보 없음: ${response.data['message']}');
    }
    // 서버 응답 상태 코드가 404일 경우 (페이지 없음)
    else if (response.statusCode == 400) {
      print('데이터 형식이 올바르지 않습니다: ${response.data}');
    }
    // 기타 상태 코드에 대한 처리
    else {
      print('Unexpected error: ${response.statusCode}, ${response.data}');
    }
  } catch (e) {
    // 네트워크 오류 또는 기타 예외 처리
    print('Error: $e');
  }
}
