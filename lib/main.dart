import 'package:agro/pages/animal.dart';
import 'package:agro/pages/drone.dart';
import 'package:agro/pages/guide.dart';
import 'package:agro/pages/irrigation.dart';
import 'package:agro/pages/news.dart';
import 'package:agro/pages/plantdiease.dart';
import 'package:agro/pages/price.dart';
import 'package:agro/pages/vechicle.dart';
import 'package:agro/pages/weather.dart';
import 'package:agro/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:agro/device/Device.dart';
import 'package:splashscreen/splashscreen.dart';
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
      initialRoute: '/',
      routes: {
        '/back': (context) => ChooseDevice(),
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
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      title: 'Flutter Login',
      home: ChooseDevice(),
      //  SplashScreen(
      //   seconds: 5,
      //   backgroundColor: Colors.white,
      //   image: Image.asset("images/logo.png"),
      //   photoSize: 150.0,
      //   loaderColor: Colors.green,
      //   navigateAfterSeconds: ChooseDevice(),
      //   loadingText: Text(
      //     "AGRO",
      //     style: new TextStyle(color: Colors.green, fontSize: 20.0),
      //   ),
      // )
    );
  }
}
