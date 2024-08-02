import 'package:first_station/home/app_navigation.dart';
import 'package:first_station/counter/counter_page.dart';
import 'package:first_station/draw/paper.dart';
import 'package:first_station/guess/guess_page.dart';
import 'package:first_station/storage/db_storage/db_storage.dart';
import 'package:flutter/material.dart';

import 'muyu/muyu_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dbstorage.instance.open();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: AppNavigation(),
    );
  }
}
