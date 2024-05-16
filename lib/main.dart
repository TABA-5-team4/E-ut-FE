import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';

// 앱의 진입점. runApp() 전에 필요한 전처리를 할 수 있다.
Future<void> main() async {
  // 위젯 바인딩. 메인함수에서 제일 먼저 실행해야함.
  WidgetsFlutterBinding.ensureInitialized();
  // 앱 수직 고정
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // 앱 상태바 활성화
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
  // 앱 상태바 스타일
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // ios 상태바 모드
    statusBarBrightness: Brightness.light,
  ));
  runApp(const App());
}
