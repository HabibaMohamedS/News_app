import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 870),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            //themeMode: ThemeMode.light,
            themeMode: ThemeMode.light,
            routes: {
              '/homePage': (context) => MyHomePage(),
            },
            initialRoute: '/homePage',
            home: child,
          );
        });
  }
}
