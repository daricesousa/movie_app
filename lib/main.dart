import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_app/core/bindings/app_binding.dart';
import 'package:movie_app/env.dart';
import 'package:movie_app/router/app_router.dart';

import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routingCallback: (value) {
        SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(statusBarColor: Colors.white));
      },
      theme: ThemeData.dark().copyWith(
          primaryColor: const Color(0xFF151C26),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF151C26)),
          scaffoldBackgroundColor: const Color(0xFF151C26),
          platform: TargetPlatform.iOS),
      debugShowCheckedModeBanner: Env.DEBUG_MODE,
      initialBinding: AppBindings(),
      getPages: AppRouters().pages,
    );
  }
}
