import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

int humidity;
int mtemperature = 0;
int temp1;
int temp2;
int temp3;
int uv;
int visi;
int wind;

class _WeatherState extends State<Weather> {
  String finalDate = '';
  static final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    String dateFormat = DateFormat('EEEE').format(date);
    setState(() {
      finalDate = dateFormat.toString();
    });
    databaseReference.child('Weather').onValue.listen((event) {
      setState(() {
        humidity = event.snapshot.value['humidity'];
        mtemperature = event.snapshot.value['mtemperature'];
        temp1 = event.snapshot.value['temp1'];
        temp2 = event.snapshot.value['temp2'];
        temp3 = event.snapshot.value['temp3'];
        uv = event.snapshot.value['uv'];
        visi = event.snapshot.value['visi'];
        wind = event.snapshot.value['wind'];
        // print(humidity1);
      });
    });
  }

  Widget build(BuildContext context) {
    if (mtemperature != 0) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              color: Colors.green,
              splashColor: Colors.purple,
              onPressed: () {
                Navigator.popAndPushNamed(context, '/back');
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 50,
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 3.9,
                  width: MediaQuery.of(context).size.width / 1.2,
                  // color: Theme.of(context).primaryColor,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(22)),
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
                  // style: NeuomorphicStyle.Convex,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "$finalDate",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 38,
                          ),
                          Text(
                            "SUNNY",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.4,
                          ),
                          Text(
                            mtemperature.toString() + "°C",
                            style: TextStyle(
                              fontSize: 55.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.7,
                          ),
                          Text(
                            "14°C - 70°C",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: MediaQuery.of(context).size.width / 1.9,
                      //     ),
                      //     Text(
                      //       "precipitation:" + precipitation() + "%",
                      //       style: TextStyle(
                      //         fontSize: 12.0,
                      //         fontWeight: FontWeight.w800,
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: MediaQuery.of(context).size.width / 1.9,
                      //     ),
                      //     Text(
                      //       "humidity:" + humidity() + "%",
                      //       style: TextStyle(
                      //         fontSize: 12.0,
                      //         fontWeight: FontWeight.w800,
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: MediaQuery.of(context).size.width / 1.9,
                      //     ),
                      //     Text(
                      //       "wind :" + wind() + "k/h",
                      //       style: TextStyle(
                      //         fontSize: 12.0,
                      //         fontWeight: FontWeight.w800,
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: MediaQuery.of(context).size.height / 2.8,
                color: Theme.of(context).primaryColor,
                // width: MediaQuery.of(context).size.width / 1.2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                    ),
                    buildContainer("11:34 AM", 58742, temp1.toString() + "°C"),
                    SizedBox(
                      width: 30,
                    ),
                    buildContainer("12:30 PM", 62625, temp2.toString() + "°C"),
                    SizedBox(
                      width: 30,
                    ),
                    buildContainer("4:34 PM", 57349, temp3.toString() + "°C"),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 5.9,
                width: MediaQuery.of(context).size.width / 0.2,
                // color: Theme.of(context).primaryColor,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
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

                child: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 60,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                          // width: 90,
                        ),
                        Text(
                          "Wind :" + wind.toString() + "m/h",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          // width: 90,
                        ),
                        Text(
                          "Visibilty : " + visi.toString() + "km",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                      width: 30,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                          // width: 90,
                        ),
                        Text(
                          "Humidity : $humidity",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          // width: 90,
                        ),
                        Text(
                          "UV : $uv",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }

  Container buildContainer(String data, int value, String temp) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.orangeAccent,
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
            SizedBox(
              height: 60,
            ),
            Text(data),
            SizedBox(
              height: 30,
            ),
            Icon(IconData(value, fontFamily: 'MaterialIcons')),
            SizedBox(
              height: 20,
            ),
            Text(temp)
          ],
        ),
      ),
      width: 160.0,
      // color: Colors.red,
    );
  }
}
