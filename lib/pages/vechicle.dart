import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:quiver/iterables.dart';
import 'package:agro/Crop/cropmanage.dart';
import 'package:agro/models/indicator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

String name;
String nutrient;
String percentage;
String waterlevel;
List<dynamic> resultList = [];
var lists;
List non;
List non1;
List<int> val = [
  0xff0293ee,
  0xfff8b250,
  0xff845bef,
  0xff13d38e,
  0xFFB74093,
  0xFFf21b0c,
  0xFF19115e,
  0xFF15e66f
];

class PieChart2State extends State {
  int touchedIndex;
  // int val = 0xff0293ee;
  static final databaseReference = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    super.initState();
    databaseReference.child('Crop Growth').once().then((DataSnapshot snapshot) {
      resultList = snapshot.value;
      // print('Data : ${snapshot.value}');
      var valu = snapshot.value;
      final jsonE = json.encode(valu);
      final jsonResponse = json.decode(jsonE);
      MyDataList va = new MyDataList.fromJson(jsonResponse);
      setState(() {
        lists = va.myList;
        // print(non[1].length);
        // print(non[0]);
        // land = List(resultList.length);
      });
      // print(va.myList);

      // print(non);
      // resultList = snapshot.value;
      // print(resultList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (resultList.length != 0) {
      return NeumorphicApp(
        home: Scaffold(
          appBar: NeumorphicAppBar(
            leading: InkWell(
              onTap: () => {Navigator.popAndPushNamed(context, '/back')},
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.amber,
                  shape: BoxShape.circle,
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(3, 3),
                      color: Colors.black12,
                      blurRadius: 3,
                    ),
                    BoxShadow(
                      offset: Offset(-3, -3),
                      color: Colors.white,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: ListView.builder(
              shrinkWrap: true,
              // scrollDirection: Axis.horizontal,
              // padding: const EdgeInsets.all(40),
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                print(lists[index].nutrient);
                non = lists[index].nutrient.split(",");
                non1 = lists[index].percentage.split(",");
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Crop Name: " + lists[index].name.toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "WaterFlow: " +
                                  lists[index].waterlevel.toString() +
                                  "%",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              height: 18,
                            ),
                            Expanded(
                              child: PieChart(
                                PieChartData(
                                    pieTouchData: PieTouchData(
                                        touchCallback: (pieTouchResponse) {
                                      setState(() {
                                        if (pieTouchResponse.touchInput
                                                is FlLongPressEnd ||
                                            pieTouchResponse.touchInput
                                                is FlPanEnd) {
                                          touchedIndex = -1;
                                        } else {
                                          touchedIndex = pieTouchResponse
                                              .touchedSectionIndex;
                                        }
                                      });
                                    }),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40,
                                    sections: showingSections()),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var i in range(non.length))
                                  buildIndicator(non[i].toString(), val[i]),
                                // SizedBox(
                                //   height: 4,
                                // ),
                                SizedBox(
                                  height: 18,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 28,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
            child: CircularProgressIndicator(
                // color: Colors.grey,
                // size: 50.0,
                )),
      );
    }
  }

  Indicator buildIndicator(String data, int val) {
    return Indicator(
      color: Color(val),
      text: data,
      isSquare: true,
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(non.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return pieChartSectionData(radius, fontSize, non1[i], val[i]);
        case 1:
          return pieChartSectionData(radius, fontSize, non1[i], val[i]);
        default:
          return pieChartSectionData(radius, fontSize, non1[i], val[i]);
      }
    });
  }

  PieChartSectionData pieChartSectionData(
      double radius, double fontSize, String value, int val) {
    var one = double.parse(value);
    return PieChartSectionData(
      color: Color(val),
      value: one,
      title: value + "%",
      radius: radius,
      titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff)),
    );
  }
}
