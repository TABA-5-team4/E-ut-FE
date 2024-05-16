import 'package:eut/screen/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 하위 페이지 또는 구성요소로 감싸는 앱 최상단 영역
// MaterialApp 대신 getX 패키지의 getMaterialApp 클래스를 사용함
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "E-ut",
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale, // 디바이스 언어 따라감
      fallbackLocale: const Locale('ko', "KR"), // 기본 한국어
      home: const HomePage(),
    );
  }
}
