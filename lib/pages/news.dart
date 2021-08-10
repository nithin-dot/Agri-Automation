import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "News",
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
          body: WebView(
            initialUrl: 'https://www.farmnewsindia.in/',
            javascriptMode: JavascriptMode.unrestricted,
          )),
    );
  }
}
