import 'dart:async';
import 'package:agro/models/service.dart';
import 'package:agro/utilities/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';

class ChooseDevice extends StatefulWidget {
  @override
  State createState() => ChooseDeviceState();
}

class ChooseDeviceState extends State<ChooseDevice> {
  static final databaseReference = FirebaseDatabase.instance.reference();

  List<String> list = [];

  @override
  void initState() {
    super.initState();
    databaseReference.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        setState(() {
          list.add(key);
          // print(list);
          // print(list);
        });
      });
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // print(list.length);
    if (list.length != 0) {
      return MaterialApp(
        home: Scaffold(
          // backgroundColor: Colors.green,
          body: SingleChildScrollView(
            child: Container(
              // margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: [
                  Positioned(
                    child: ClipPath(
                      clipper: CurvedClipper(),
                      child: NeuomorphicContainer(
                        height: MediaQuery.of(context).size.height / 1.45,
                        width: MediaQuery.of(context).size.width / 0.3,
                        color: Colors.black,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 120.0,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 60,
                                ),
                                Text(
                                  "AGRO",
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                ),
                                Text(
                                  'Monitoring',
                                  style: TextStyle(
                                    fontSize: 27.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    decorationThickness: 200,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: _buildHomeServiceMenu(context, list.length),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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

  List<Padding> _buildHomeServiceMenu(BuildContext context, i) {
    int inde = i;
    return List.generate(
      i,
      (index) => Padding(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, bottom: 25.0, top: 8.0),
        child: _buildContainer(inde, index, context),
      ),
    );
  }

  InkWell _buildContainer(int inde, int index, BuildContext context) {
    BorderRadius borderRaidus;

    if (index == 0) {
      borderRaidus = BorderRadius.only(topLeft: Radius.circular(15.0));
    } else if (index == 1) {
      borderRaidus = BorderRadius.only(topRight: Radius.circular(15.0));
    } else if (index == inde - 1) {
      borderRaidus = BorderRadius.only(bottomRight: Radius.circular(15.0));
    } else if (index == inde - 2) {
      borderRaidus = BorderRadius.only(bottomLeft: Radius.circular(15.0));
    } else {
      borderRaidus = BorderRadius.all(Radius.circular(0.0));
    }
    // print(list[10]);
    return InkWell(
      onTap: () => {
        Navigator.pushNamed(context, '/' + list[index].toString()),
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 2.8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Service.getHomeService(list[index]),
                      color: Colors.black),
                ],
              ),
              Text(
                list[index],
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: borderRaidus,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(3, 3),
                color: Colors.black12,
                blurRadius: 60,
                spreadRadius: 27),
          ],
        ),
      ),
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 18);
    path.quadraticBezierTo(
        size.width / 90, size.height, size.width, size.height - 90);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
