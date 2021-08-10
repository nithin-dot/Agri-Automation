import 'package:agro/Welcome_screen/Dashbord.dart';
import 'package:agro/pages/animal.dart';
import 'package:agro/pages/drone.dart';
import 'package:agro/pages/guide.dart';
import 'package:agro/pages/irrigation.dart';
import 'package:agro/pages/news.dart';
import 'package:agro/pages/plantdiease.dart';
import 'package:agro/pages/price.dart';
import 'package:agro/pages/plant_growth.dart';
import 'package:agro/pages/weather.dart';
import 'package:agro/theme/style.dart';
import 'package:flutter/material.dart';
import 'pages/livestock.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: DashBord.id,
      routes: {
        DashBord.id: (context) => DashBord(),
        '/Drone': (context) => Drone(),
        '/Irrigation': (context) => Temperature(),
        '/Plant Disease': (context) => Plant(),
        '/Crop Growth': (context) => PieChartSample2(),
        '/Live Stock': (context) => LineChartSample2(),
        '/Weather': (context) => Weather(),
        '/Crop News': (context) => News(),
        '/Crop Price': (context) => Price(),
        '/Crop Guidance': (context) => Guide(),
        '/Animal': (context) => Animal(),
      },
      theme: appTheme(),
      title: 'Flutter Login',
      home: DashBord(),
    );
  }
}
