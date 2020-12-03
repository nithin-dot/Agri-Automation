import 'dart:convert';
import 'package:quiver/iterables.dart';
import 'package:agro/Crop/listv.dart';
import 'package:agro/Crop/mandiapi.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class Price extends StatefulWidget {
  @override
  _PriceState createState() => _PriceState();
}

List<dynamic> resultList1 = [];
var lists1;
List<dynamic> resultList = [];
var lists;
String val;

class _PriceState extends State<Price> {
  static final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    databaseReference
        .child('Crop Price')
        .child('Data')
        .once()
        .then((DataSnapshot snapshot) {
      resultList = snapshot.value;
      print('Data : ${snapshot.value}');
      var valu = snapshot.value;
      final jsonE = json.encode(valu);
      final jsonResponse = json.decode(jsonE);
      MyPriceList va = new MyPriceList.fromJson(jsonResponse);
      setState(() {
        lists = va.myList;
        print(lists);
      });

      // print(lists.cropName);
      resultList = snapshot.value;
      print(resultList.length);
    });
    databaseReference
        .child('Crop Price')
        .child('Listv')
        .once()
        .then((DataSnapshot snapshot) {
      resultList1 = snapshot.value;
      print('Data : ${snapshot.value}');
      var valu1 = snapshot.value;
      final jsonE1 = json.encode(valu1);
      final jsonResponse1 = json.decode(jsonE1);
      MyListList ta = new MyListList.fromJson(jsonResponse1);
      setState(() {
        lists1 = ta.myList;
        print(lists1);
      });

      // print(lists.cropName);
      // resultList1 = snapshot.value;
      // print(resultList1.length);
    });
    databaseReference.child('Crop Price').onValue.listen((event) {
      setState(() {
        val = event.snapshot.value['val'];

        // print(humidity1);
      });
    });
  }

  final List<List<double>> charts = [
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
    ],
    [
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4,
      0.0,
      0.3,
      0.7,
      0.6,
      0.55,
      0.8,
      1.2,
      1.3,
      1.35,
      0.9,
      1.5,
      1.7,
      1.8,
      1.7,
      1.2,
      0.8,
      1.9,
      2.0,
      2.2,
      1.9,
      2.2,
      2.1,
      2.0,
      2.3,
      2.4,
      2.45,
      2.6,
      3.6,
      2.6,
      2.7,
      2.9,
      2.8,
      3.4
    ]
  ];
  var colo = [0xffff0000, 0xff07862b];
  List<List<double>> data = [
    [1.0, 1.1, 1.0, 1.2, 1.3, 1.3, 1.3, 1.3],
    [1.0, 1.1, 1.0, 0.9, 1.2, 1.2, 1.3, 1.4],
    [0.4, 0.5, 0.6, 1.0, 1.0, 0.9, 0.6, 0.5],
    [0.8, 0.7, 1.0, 0.9, 0.2, 1.3, 1.6, 0.8, 0.3, 0.0],
    [1.0, 1.1, 1.0, 0.9, 1.2, 1.3, 0.8, 1, 2],
    [0.8, 0.9, 0.7, 0.6, 0.8, 0.9],
    [0.2, 0.3, 0.6, 1.0, 0.6, 0.3, 0.2],
    [1.0, 1.1, 1.2, 1.3, 1.4, 1.2, 1.3],
    [1.0, 1.1, 1.0, 0.9, 1.2, 1.3, 1.0, 0.8, 1.3, 1.0]
  ];

  static final List<String> chartDropdownItems = [
    'Last 7 days',
    'Last month',
    'Last year'
  ];

  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;
  @override
  Widget build(BuildContext context) {
    if (resultList.length != 0 && resultList1.length != 0) {
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
          body: ListView(
            children: [
              Column(
                children: [
                  Material(
                    color: Colors.white,
                    elevation: 14.0,
                    shadowColor: Color(0x802196F3),
                    child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Total Revenue',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Text("$val",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 34.0)),
                                  ],
                                ),
                                DropdownButton(
                                    isDense: true,
                                    value: actualDropdown,
                                    onChanged: (String value) => setState(() {
                                          actualDropdown = value;
                                          actualChart =
                                              chartDropdownItems.indexOf(
                                                  value); // Refresh the chart
                                        }),
                                    items:
                                        chartDropdownItems.map((String title) {
                                      return DropdownMenuItem(
                                        value: title,
                                        child: Text(title,
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0)),
                                      );
                                    }).toList())
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 4.0)),
                            Sparkline(
                              data: charts[actualChart],
                              lineWidth: 5.0,
                              lineColor: Colors.greenAccent,
                            )
                          ],
                        )),
                  ),
                  for (var i in range(lists1.length))
                    myCardDetails(
                        lists1[i].name,
                        data[lists1[i].charts],
                        lists1[i].price.toString(),
                        lists1[i].per.toString(),
                        lists1[i].status.toString(),
                        colo[lists1[i].color]),
                  GridView.count(
                    crossAxisCount: 2,
                    primary: false,
                    shrinkWrap: true,
                    childAspectRatio: (15 / 19),
                    mainAxisSpacing: 40,
                    crossAxisSpacing: 10,
                    padding: EdgeInsets.all(12.0),
                    children: List.generate(resultList.length, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.all(Radius.circular(22)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(3, 3),
                              color: Colors.black12,
                              blurRadius: 3,
                            ),
                            BoxShadow(
                              offset: Offset(-3, -3),
                              color: Colors.black12,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            // Row(
                            //   children: [
                            //     Container(
                            //         height: 30,
                            //         width: 70,
                            //         color: Colors.green,
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.end,
                            //           children: [
                            //             Text(
                            //               "Name",
                            //               style: TextStyle(
                            //                 fontSize: 18.0,
                            //                 fontWeight: FontWeight.bold,
                            //                 color: Colors.white,
                            //               ),
                            //             ),
                            //             SizedBox(
                            //               width: 10,
                            //             )
                            //           ],
                            //         )),
                            //   ],
                            // ),

                            Text(
                              lists[index].name +
                                  "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                    height: 30,
                                    width: 90,
                                    color: Colors.green,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Price",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            Text(
                              lists[index].price +
                                  "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 67,
                            ),
                            Row(
                              children: [
                                Container(
                                    height: 30,
                                    width: 120,
                                    color: Colors.green,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Quantity ",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    )),
                              ],
                            ),
                            Text(
                              lists[index].quantity +
                                  "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
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

  myCardDetails(String currencyName, List<double> data, String currencyVal,
      String currencyPercentage, String currencyStatus, int colorVal) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.white,
        elevation: 14.0,
        // borderRadius: BorderRadius.circular(24.0),
        shadowColor: Color(0x802196F3),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: myCurrencies(currencyName, data, currencyVal,
              currencyPercentage, currencyStatus, colorVal),
        ),
      ),
    );
  }

  myCurrencies(String currencyName, List<double> data, String currencyVal,
      String currencyPercentage, String currencyStatus, int colorVal) {
    return Center(
        child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            myLeadingDetails(currencyName),
            myGraphDetails(data),
            myCurrenciesDetails(
                currencyVal, currencyPercentage, currencyStatus, colorVal),
          ],
        )
      ],
    ));
  }

  myLeadingDetails(String currencyName) {
    return Container(
        child: Row(
      children: <Widget>[
        Container(
          child: Text(
            currencyName,
            style: TextStyle(
                color: Color(0xff3a2483),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
        ),
      ],
    ));
  }

  myGraphDetails(List<double> data) {
    return Container(
      width: 80.0,
      height: 50.0,
      child: Sparkline(
        data: data,
        lineColor: Color(0xff013db7),
        fillMode: FillMode.below,
        fillColor: Colors.blue[100],
      ),
    );
  }

  myCurrenciesDetails(String currencyVal, String currencyPercentage,
      String currencyStatus, int colorVal) {
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          child: Text("\u0024" + currencyVal,
              style: TextStyle(
                  color: Color(0xff3a2483),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  fontSize: 20.0)),
        ),
        Container(
          child: Text(currencyPercentage + "\u0025\u0020" + currencyStatus,
              style: TextStyle(
                color: Color(colorVal),
                fontFamily: 'Poppins',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
    ));
  }
}
