import 'dart:convert';
import 'package:agro/Crop/animaldetails.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

var names = ['Total Animals', 'Milking Cows', 'Per litre', 'Kgs Av.Milk\nCow'];

var names1 = [
  'Nonpregnant',
  "Anoestrus",
  "Barren",
  "Pregnant",
  "Dry",
  "open Cows"
];
int dry = 0;
int milking = 0;
int total = 0;
int kgs = 0;
int nonpregnant = 0;
int anoestrus = 0;
int barren = 0;
int pregnant = 0;
int price = 0;
int open = 0;

List<dynamic> resultList = [];
var lists;

class _LineChartSample2State extends State<LineChartSample2> {
  static final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();

    databaseReference.child('Live Stock').onValue.listen((event) {
      if (mounted) {
        setState(() {
          dry = event.snapshot.value['dry'];
          milking = event.snapshot.value['Milking'];
          total = event.snapshot.value['Total'];
          kgs = event.snapshot.value['Kgs'];
          nonpregnant = event.snapshot.value['Nonpregnant'];
          anoestrus = event.snapshot.value['anoestrus'];
          barren = event.snapshot.value['barren'];
          pregnant = event.snapshot.value['pregnant'];
          price = event.snapshot.value['Price'];
          open = event.snapshot.value['open'];
        });
      }
    });
    databaseReference
        .child('Live Stock')
        .child('Cows')
        .once()
        .then((DataSnapshot snapshot) {
      resultList = snapshot.value;
      print('Data : ${snapshot.value}');
      var valu = snapshot.value;
      final jsonE = json.encode(valu);
      final jsonResponse = json.decode(jsonE);
      MyAniList va = new MyAniList.fromJson(jsonResponse);
      print(va.myList);
      setState(() {
        lists = va.myList;
      });
      resultList = snapshot.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var feature = [total, milking, 'Rs : ' + price.toString(), kgs];
    var feature1 = [nonpregnant, anoestrus, barren, pregnant, dry, open];
    if (resultList.length != 0) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xffa4d7d1),
          appBar: AppBar(
            title: Text(
              "Live Stock",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Color(0xffa4d7d1),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              color: Colors.green,
              splashColor: Colors.purple,
              onPressed: () {
                Navigator.popAndPushNamed(context, '/back');
              },
            ),
          ),
          body: ListView(
            children: [
              Column(
                children: [
                  GridView.count(
                    primary: false,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                    padding: EdgeInsets.all(32.0),
                    children: List.generate(feature.length, (index) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(26.0)),
                            color: Color(0xff292c31),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffa4d7d1),
                                  offset: Offset(3.0, 3.0),
                                  blurRadius: 15.0,
                                  spreadRadius: 1.0),
                              BoxShadow(
                                  color: Color(0xff292c31),
                                  offset: Offset(-5.0, -5.0),
                                  blurRadius: 15.0,
                                  spreadRadius: 1.0),
                            ]),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 70,
                              bottom: 70,
                              child: CircleAvatar(
                                backgroundColor: Color(0xffa4d7d1),
                                radius: 52,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      feature[index].toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      names[index],
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "Fertility Summary",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  GridView.count(
                    primary: false,
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    padding: EdgeInsets.all(30.0),
                    children: List.generate(feature1.length, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          color: Color(0xffa4d7d1),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(3, 3),
                              color: Colors.black12,
                              blurRadius: 3,
                            ),
                            BoxShadow(
                              offset: Offset(-3, -3),
                              color: Color(0xffa4d7d1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        // color: Colors.black,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black87,
                                      border: Border.all(color: Colors.black),
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
                                        child: Text(
                                      feature1[index].toString(),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    )))),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              names1[index],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: SizedBox(
                  height: 250,

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: resultList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              color: Color(0xff292c31),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(3, 3),
                                  color: Colors.black12,
                                  blurRadius: 3,
                                ),
                                BoxShadow(
                                  offset: Offset(-3, -3),
                                  color: Colors.white10,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            height: 200,
                            width: 350,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        height: 30,
                                        width: 200,
                                        color: Color(0xffa4d7d1),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              lists[index].name.toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(FontAwesomeIcons.snapchatGhost,
                                                color: Colors.black),
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 60,
                                    ),
                                    Container(
                                        child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Health\n" +
                                                  lists[index]
                                                      .health
                                                      .toString() +
                                                  "%",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 80,
                                            ),
                                            lists[index].yiel == 0
                                                ? Text(
                                                    "Yield\n -",
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : Text(
                                                    "Yield\n" +
                                                        lists[index]
                                                            .yiel
                                                            .toString() +
                                                        "%",
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 60,
                                    ),
                                    Container(
                                        child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Milk-Quality\n" +
                                                  lists[index]
                                                      .quality
                                                      .toString() +
                                                  "%",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Text(
                                              "temperature \n" +
                                                  lists[index].temp.toString() +
                                                  "%",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                                  ],
                                )
                              ],
                            )),
                      );
                    },
                  ),
                  //   ],
                  // ),
                ),
              )
            ],
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
