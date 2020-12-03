import 'dart:convert';
import 'package:agro/Crop/cropdetails.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Temperature extends StatefulWidget {
  @override
  _TemperatureState createState() => _TemperatureState();
}

List<dynamic> resultList = [];
var lists;
var land = [];
double ph;
int humidity = 34;
int motor;
int temperature = 56;
int moisture;

class _TemperatureState extends State<Temperature> {
  static final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    databaseReference
        .child('Irrigation')
        .child('lands')
        .once()
        .then((DataSnapshot snapshot) {
      resultList = snapshot.value;
      print('Data : ${snapshot.value}');
      var valu = snapshot.value;
      final jsonE = json.encode(valu);
      final jsonResponse = json.decode(jsonE);
      MyCropList va = new MyCropList.fromJson(jsonResponse);
      setState(() {
        lists = va.myList;
        land = List(resultList.length);
        List<int>.generate(resultList.length,
            (int inde) => land[inde] = lists[inde].waterFlow);

        print(land);
      });

      va.myList.forEach((data) => print(data.waterFlow));
      // print(lists.cropName);
      resultList = snapshot.value;
      print(resultList.length);
    });
    // list.clear();
    // databaseReference.child('irrigation').once().then((DataSnapshot snapshot) {
    //   Map<dynamic, dynamic> values = snapshot.value;
    //   values.forEach((key, values) {
    //     setState(() {
    //       list.add(key);
    //       print(list);
    //     });
    //   });
    // });
    databaseReference.child('Irrigation').onValue.listen((event) {
      setState(() {
        ph = event.snapshot.value['Ph'];
        humidity = event.snapshot.value['humidity'];
        moisture = event.snapshot.value['moisture'];
        motor = event.snapshot.value['motor'];
        temperature = event.snapshot.value['temperature'];

        // print(humidity1);
      });
    });
  }

  CircularPercentIndicator buildCircularPercentIndicator(
      BuildContext context, int value, String non, Color data, String str) {
    return CircularPercentIndicator(
      radius: 160.0,
      lineWidth: 18.0,
      animation: true,
      percent: value / 100,
      center: Container(
        height: MediaQuery.of(context).size.height / 8,
        width: MediaQuery.of(context).size.width / 0.9,
        decoration: BoxDecoration(
          color: data,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: Offset(3, -3),
              color: Colors.black12,
              blurRadius: 1,
            ),
            BoxShadow(
              offset: Offset(-3, 3),
              color: Colors.white,
              blurRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            non,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ),
      ),
      footer: new Text(
        str,
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: data,
    );
  }

  InkWell buildContainer(
      BuildContext context, String data, String str, int value) {
    return InkWell(
      onTap: () => {
        setState(() {
          value == 1 && str == " Motor"
              ? databaseReference.child('Irrigation').update({'motor': 0})
              : value == 0 && str == " Motor"
                  ? databaseReference.child('Irrigation').update({'motor': 1})
                  : null;

          print(value);
        })
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 9.5, horizontal: 1.0),
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 2.8,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
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
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 110,
                  ),
                  ClipOval(
                    child: Container(
                      height: 10.0,
                      width: 10.0,
                      color: value == 1
                          ? Colors.pinkAccent[700]
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              str == " Motor"
                  ? Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(""),
                      ],
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30,
                      child: Text(
                        data.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
              Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: 35,
                    ),
                    Center(
                      child: Text(
                        str,
                        style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (resultList.length != 0) {
      // int value = resultList.length;
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                    Column(
                      children: [
                        buildContainer(context, "", " Motor", motor),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 25,
                        ),
                        buildContainer(
                            context, moisture.toString() + " %", "Moisture", 0),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 25,
                        ),
                        buildContainer(context, ph.toString(), "\t\t\tPH", 0),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 12,
                    ),
                    Column(
                      children: [
                        buildCircularPercentIndicator(
                            context,
                            temperature,
                            temperature.toString() + " °C",
                            Colors.red,
                            "Temperature"),
                        SizedBox(
                          height: 10,
                        ),
                        buildCircularPercentIndicator(
                            context,
                            humidity,
                            humidity.toString() + " %",
                            Colors.blue,
                            "Humidity"),
                      ],
                    ),
                  ],
                ),
                GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(50),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: List.generate(resultList.length, (index) {
                    return InkWell(
                      onTap: () => {
                        setState(() {
                          land[index] == 0
                              // ignore: unnecessary_statements
                              ? {
                                  databaseReference
                                      .child('Irrigation')
                                      .child('lands')
                                      .child('$index')
                                      .update({'waterFlow': 1}),
                                  land[index] = 1
                                }
                              // ignore: unnecessary_statements
                              : {
                                  databaseReference
                                      .child('Irrigation')
                                      .child('lands')
                                      .child('$index')
                                      .update({'waterFlow': 0}),
                                  land[index] = 0
                                };
                        }),
                        print(land)
                      },
                      child: Container(
                        // padding: const EdgeInsets.all(10.0),
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
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
                        child: Stack(
                          children: [
                            Positioned(
                              right: MediaQuery.of(context).size.height / 14,
                              bottom: MediaQuery.of(context).size.width / 11,
                              child: CircleAvatar(
                                backgroundColor: Colors.greenAccent,
                                radius: 60,
                              ),
                            ),
                            Positioned(
                              right: MediaQuery.of(context).size.height / 9,
                              bottom: MediaQuery.of(context).size.width / 5.5,
                              child: Icon(FontAwesomeIcons.seedling),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 89,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          3.6,
                                    ),
                                    ClipOval(
                                      child: Container(
                                        height: 10.0,
                                        width: 10.0,
                                        color: land[index] == 1
                                            ? Colors.pinkAccent[700]
                                            : Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 17,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          19,
                                    ),
                                    Text(
                                      lists[index].cropName,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          19,
                                    ),
                                    Text(
                                      "Humidity: " +
                                          lists[index].humidity.toString(),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 169,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
