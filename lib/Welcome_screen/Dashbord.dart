import 'package:agro/models/service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DashBord extends StatefulWidget {
  static String id = '/back';
  @override
  State createState() => DashBordState();
}

class DashBordState extends State<DashBord> {
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
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (list.length != 0) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xffa4d7d1),
          body: SingleChildScrollView(
            child: Container(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.45,
                    width: MediaQuery.of(context).size.width / 0.3,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 120.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              "AGRO",
                              style: TextStyle(
                                fontSize: 37.0,
                                color: Color(0xff292c31),
                                fontWeight: FontWeight.bold,
                                decorationThickness: 200,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              'MONITORING',
                              style: TextStyle(
                                fontSize: 34.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff292c31),
                                decorationThickness: 200,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 260,
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
            left: 20.0, right: 20.0, bottom: 25.0, top: 8.0),
        child: _buildContainer(inde, index, context),
      ),
    );
  }

  GestureDetector _buildContainer(int inde, int index, BuildContext context) {
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
    return GestureDetector(
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
                      color: Color(0xffa4d7d1)),
                ],
              ),
              Text(
                list[index],
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffa4d7d1),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: borderRaidus,
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
      ),
    );
  }
}
