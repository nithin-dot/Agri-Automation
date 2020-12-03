import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:webview_flutter/webview_flutter.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      home: Scaffold(
          backgroundColor: Colors.white,
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
          body: WebView(
            initialUrl: 'https://www.farmnewsindia.in/',
            javascriptMode: JavascriptMode.unrestricted,
          )),
    );
  }
}
