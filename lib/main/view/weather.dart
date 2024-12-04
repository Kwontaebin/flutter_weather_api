import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_api/common/component/custom_appbar.dart';
import 'package:flutter_weather_api/common/component/custom_image.dart';
import 'package:flutter_weather_api/common/component/custom_text.dart';
import 'package:flutter_weather_api/common/component/custom_text_field.dart';
import 'package:flutter_weather_api/common/function/sizeFn.dart';
import 'package:flutter_weather_api/main/component/bottomContainer.dart';
import 'package:intl/intl.dart';
import '../../common/component/custom_elevatedButton.dart';
import '../../common/const/data.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final Dio dio = Dio();
  Map<dynamic, dynamic> data = {
    "name": "", // 도시 이름
    "date": "", // 년월일
    "time": "", // 시분
    "temp": "", // 온도
    "weather_description": "", // 날씨 설명(흐림, 구름 많음, 맑음 ...)
    "icon": "", // 아이콘(날씨 그림)
    "feel_temp": "", // 체감 기온
    "max_temp": "", // 최고 기온
    "min_temp": "", // 최저 기온
    "humidity": "", // 습도
    "pressure": "", // 대기압
    "wind": "", // 바람
  };

  bool isLoading = false; // 로딩 상태 관리
  double n = 273.15;

  void formatTimestamp(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    setState(() {
      data["date"] = DateFormat('yyyy년 MM월 dd일').format(date);
      data["time"] = DateFormat('HH:mm EEEE').format(date);
    });
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await dio.get('https://api.openweathermap.org/data/2.5/weather?q=${data["name"]}&APPID=$WEATHER_TOKEN');

      if (res.statusCode == 200) {
        formatTimestamp(res.data["dt"]);
        String icon = res.data["weather"][0]["icon"];

        print(icon);

        setState(() {
          data["weather_description"] = res.data["weather"][0]["description"];
          data["temp"] = "${double.parse((res.data["main"]["temp"] - n).toStringAsFixed(1))}°C";
          data["feel_temp"] = "${double.parse((res.data["main"]["feels_like"] - n).toStringAsFixed(1))}°C";
          data["max_temp"] = "${double.parse((res.data["main"]["temp_max"] - n).toStringAsFixed(1))}°C";
          data["min_temp"] = "${double.parse((res.data["main"]["temp_min"] - n).toStringAsFixed(1))}°C";
          data["humidity"] = "${res.data["main"]["humidity"]}%";
          data["pressure"] = "${res.data["main"]["pressure"]}hPa";
          data["wind"] = "${res.data["wind"]["speed"]}km/h";

          if (icon == "01d" || icon == "01n") data["icon"] = "assets/image/sunny.png";
          if (icon == "02d" || icon == "02n") data["icon"] = "assets/image/cloudy.png";
          if (icon == "03d" || icon == "03n") data["icon"] = "assets/image/more_cloudy.png";
          if (icon == "04d" || icon == "04n") data["icon"] = "assets/image/cloud.png";
          if (icon == "09d" || icon == "09n" || icon == "010d" || icon == "010n") data["icon"] = "assets/image/rain.png";
          if (icon == "011d" || icon == "011n") data["icon"] = "assets/image/stormRain.png";
          if (icon == "013d" || icon == "013n") data["icon"] = "assets/image/snow.png";
          if (icon == "050d" || icon == "050n") data["icon"] = "assets/image/mist.png";

          print(data);
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "",
        showLeading: false,
        bgColor: Color.fromRGBO(232, 100, 122, 1.0),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromRGBO(232, 100, 122, 1.0),
          child: Column(
            children: [
              // 첫 번째 Container - 이 부분만 남겨두고 isLoading에 따라 로딩 표시
              SizedBox(height: deviceHeight(context) * 0.01),
              SizedBox(
                width: size.width * 0.9,
                height: deviceHeight(context) * 0.1,
                child: Row(
                  children: [
                    CustomTextFieldWidget(
                      width: size.width * 0.65,
                      backGroundColor: Colors.white,
                      hintText: "입력",
                      onChanged: (value) {
                        setState(() {
                          data["name"] = value;
                        });
                      },
                    ),
                    SizedBox(width: size.width * 0.04),
                    customElevatedButton(
                      context,
                      width: size.width * 0.2,
                      color: Colors.blue,
                      text: "버튼",
                      buttonTextSize: size.width * 0.04,
                      onPressed: () async {
                        getData();
                      },
                    ),
                  ],
                ),
              ),

              if (isLoading) const Center(child: CircularProgressIndicator()),

              if (!isLoading && data['icon'] != "") ...[
                SizedBox(height: deviceHeight(context) * 0.01),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customTextWidget(
                      text: data["name"],
                      textSize: size.width * 0.06,
                      textColor: Colors.white,
                    ),
                    customTextWidget(
                      text: data["temp"].toString(),
                      textSize: size.width * 0.1,
                      textColor: Colors.white,
                    ),
                    customTextWidget(
                      text: data["weather_description"].toString(),
                      textSize: size.width * 0.04,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: deviceHeight(context) * 0.03),
                    customTextWidget(
                      text: data["date"].toString(),
                      textSize: size.width * 0.04,
                      textColor: Colors.white,
                    ),
                    customTextWidget(
                      text: data["time"].toString(),
                      textSize: size.width * 0.04,
                      textColor: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: deviceHeight(context) * 0.01),
                SizedBox(
                  width: size.width * 0.9,
                  height: deviceHeight(context) * 0.2,
                  child:
                  customImage(image: data["icon"], fit: BoxFit.contain),
                ),
                SizedBox(height: deviceHeight(context) * 0.01),
                SizedBox(
                  width: size.width * 0.9,
                  height: deviceHeight(context) * 0.3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // 가로 간격 균등 배치
                        children: [
                          bottomContainer(
                            context,
                            icon: Icons.thermostat,
                            mainText: data["feel_temp"],
                            subText: "체감 온도",
                          ),

                          bottomContainer(
                            context,
                            icon: Icons.wb_sunny,
                            mainText: data["max_temp"],
                            subText: "최고 온도",
                          ),

                          bottomContainer(
                            context,
                            icon: Icons.ac_unit,
                            mainText: data["min_temp"],
                            subText: "최저 온도",
                          ),
                        ],
                      ),
                      // 하단 Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // 가로 간격 균등 배치
                        children: [
                          bottomContainer(
                            context,
                            icon: Icons.wind_power,
                            mainText: data["wind"],
                            subText: "풍속",
                          ),

                          bottomContainer(
                            context,
                            icon: Icons.speed,
                            mainText: data["pressure"],
                            subText: "대기압",
                          ),

                          bottomContainer(
                            context,
                            icon: Icons.water_drop,
                            mainText: data["humidity"],
                            subText: "습도",
                          ),
                        ]
                      ),
                    ],
                  ),
                ),
                SizedBox(height: deviceHeight(context) * 0.01),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
