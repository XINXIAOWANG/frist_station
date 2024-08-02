import 'package:first_station/home/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      //在MaterialApp的theme入参中可以配置主题数据
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        //     backgroundColor: Colors.white,
        //     selectedItemColor: Colors.blue,
        //     unselectedItemColor: Colors.grey),
        appBarTheme: const AppBarTheme(
          //标题栏的阴影深度
          elevation: 0,
          backgroundColor: Colors.orangeAccent,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
        ),
      ),
      home: const AppNavigation(),
    );
  }
}
