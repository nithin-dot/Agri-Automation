import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';

class Animal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        body: NeuomorphicContainer(
          color: Color(0xffE2EDF8),
          height: MediaQuery.of(context).size.height / 8.5,
          width: MediaQuery.of(context).size.width / 1,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.height / 55,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.17,
                      ),
                      ClipOval(
                        child: Container(
                            height: 10.0, width: 10.0, color: Colors.green),
                      ),
                    ],
                  ),
                  Text(
                    'NO Animal Detected',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    'MONITORING',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
