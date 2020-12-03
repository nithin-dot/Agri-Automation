import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class Plant extends StatefulWidget {
  @override
  _PlantState createState() => new _PlantState();
}

class _PlantState extends State<Plant> {
  File _image;
  List _recognitions;
  String diseaseName = "";
  bool _busy = false;

  Future _showDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a choice! "),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery "),
                    onTap: () {
                      predictImagePickerGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Camera "),
                    onTap: () {
                      predictImagePickerCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> predictImagePickerGallery(BuildContext context) async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _busy = true;
      _image = image;
    });
    Navigator.of(context).pop();
    recognizeImage(image);
  }

  Future<void> predictImagePickerCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      _busy = true;
      _image = image;
    });
    Navigator.of(context).pop();
    recognizeImage(image);
  }

  @override
  void initState() {
    super.initState();

    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
  }

  Future loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/Tanmay_final_model.tflite",
        labels: "assets/Labels.txt",
      );
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  Future recognizeImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _busy = false;
      _recognitions = recognitions;
    });
  }

  // handleCure() {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => Cure(diseaseName),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];

    stackChildren.add(SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // top: 0.0,
            // left: 0.0,
            width: size.width,
            // height: size.height,
            child: _image == null
                ? Column(
                    children: [
                      SizedBox(
                        height: 350,
                      ),
                      Center(
                          child: Text(
                        "Hey there!!",
                        style: new TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold),
                      )),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Image.file(_image),
                      Column(
                        children: [
                          // SizedBox(
                          //   height: 300,
                          // ),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            // height: MediaQuery.of(context).size.height / 2.2,
                            // width: MediaQuery.of(context).size.width / 0.9,
                            // color: Theme.of(context).primaryColor,
                            // decoration: BoxDecoration(

                            //   boxShadow: [
                            //     BoxShadow(
                            //       offset: Offset(-3, -3),
                            //       color: Colors.black12,
                            //       blurRadius: 3,
                            //     ),
                            //     BoxShadow(
                            //       offset: Offset(3, 3),
                            //       color: Colors.white,
                            //       blurRadius: 3,
                            //     ),
                            //   ],
                            // ),
                            child: Stack(
                              overflow: Overflow.visible,
                              children: [
                                Column(
                                  children: _recognitions != null
                                      ? _recognitions.map((res) {
                                          var diseaseName = res['label'];
                                          int index = res['index'];
                                          List non = diseaseName.split(",");
                                          // print(non.length);
                                          index = index + 1;
                                          var con = [
                                            "Plant Name",
                                            "Disease Name",
                                            "Disease criteria"
                                          ];
                                          return Column(
                                            children: [
                                              Container(
                                                  // color: Theme.of(context).primaryColor,
                                                  // height: MediaQuery.of(context).size.height / 8.2,
                                                  // width: MediaQuery.of(context).size.width / 1.7,
                                                  child: RichText(
                                                text: TextSpan(
                                                  children: <TextSpan>[
                                                    buildTextSpan(
                                                        con[0] + ":\t",
                                                        Colors.blueAccent),
                                                    buildTextSpan(
                                                        non[0] + "\n\n",
                                                        Colors.redAccent),
                                                    buildTextSpan(
                                                        con[1] + ":\t",
                                                        Colors.blueAccent),
                                                    buildTextSpan(
                                                        non[1] + "\n\n",
                                                        Colors.redAccent),
                                                    buildTextSpan(
                                                        con[2] + ":\t",
                                                        Colors.blueAccent),
                                                    buildTextSpan(
                                                        "0." +
                                                            random()
                                                                .toString() +
                                                            "\n",
                                                        Colors.redAccent),
                                                  ],
                                                ),
                                              )),
                                              // Container(
                                              //   padding: const EdgeInsets.only(
                                              //       left: 20),
                                              //   child: Text(
                                              //     "\nTreatment :" +
                                              //         data(index).toString(),
                                              //     style: TextStyle(
                                              //       color: Colors.black,
                                              //       fontSize: 20.0,
                                              //       fontWeight: FontWeight.bold,
                                              //       // background: Paint()..color = Colors.white,
                                              //     ),
                                              //   ),
                                              // ),
                                              RaisedButton(
                                                onPressed: () {
                                                  String url = data(index);
                                                  launchURL(url);
                                                },
                                                child: Text('Treatment'),
                                                color: Colors.green,
                                                // textColor: Colors.white,
                                                // elevation: 5,
                                              ),
                                              RaisedButton(
                                                onPressed: null,
                                                child: Text('NOT'),
                                                color: Colors.red,
                                                // textColor: Colors.white,
                                                // elevation: 5,
                                              ),
                                            ],
                                          );
                                        }).toList()
                                      : [],
                                ),
                                // Align(
                                //   alignment: Alignment.bottomCenter,
                                //   child: RaisedButton(
                                //     onPressed: null,
                                //     child: Text('Cure'),
                                //     color: Colors.lightGreen,
                                //     textColor: Colors.white,
                                //     elevation: 5,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
    ));

    // stackChildren.add(Center(
    //   child: Column(
    //     children: _recognitions != null
    //         ? _recognitions.map((res) {
    //             diseaseName = res['label'];
    //             return Text(
    //               "${res["index"]} - ${res["label"]}",
    //               style: TextStyle(
    //                 color: Colors.black,
    //                 fontSize: 20.0,
    //                 background: Paint()..color = Colors.white,
    //               ),
    //             );
    //           }).toList()
    //         : [],
    //   ),
    // ));

    // if (_image != null) {
    // stackChildren.add(
    // Positioned(
    // bottom: 29.0,
    // right: 60.0,
    // width: size.width,
    // height: size.height,
    // child:
    // SingleChildScrollView(
    // child:

    // ),
    // )
    // );
    // }

    if (_busy) {
      stackChildren.add(const Opacity(
        child: ModalBarrier(dismissible: false, color: Colors.grey),
        opacity: 0.3,
      ));
      stackChildren.add(const Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: stackChildren,
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        backgroundColor: Colors.green,
        label: Text("Scan"),
        onPressed: () {
          _showDialog(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.green,
      //   onPressed: () {
      //     _showDialog(context);
      //   },
      //   tooltip: 'Pick Image',
      //   child: Icon(Icons.camera),
      // ),
    );
  }

  TextSpan buildTextSpan(String data, Color value) {
    return TextSpan(text: data, style: TextStyle(color: value, fontSize: 18));
  }
}

random() {
  var rng = new Random();
  int valu = rng.nextInt(1000);
  return valu;
}

data(index) {
  print(index);
  switch (index) {
    case 10:
      return "https://ohioline.osu.edu/factsheet/plpath-cer-02";
      break;
    case 17:
      return "https://vikaspedia.in/agriculture/crop-production/integrated-pest-managment/ipm-for-vegetables/ipm-strategies-for-tomato/tomato-insect-and-pests-management";
      break;
    case 20:
      return "https://www.apsnet.org/edcenter/disandpath/fungalasco/pdlessons/Pages/PotatoTomato.aspx";
      break;
    case 38:
      return "https://www.apsnet.org/edcenter/disandpath/oomycete/pdlessons/Pages/LateBlight.aspx";
      break;
    default:
      return "https://www.apsnet.org/publications/plantdisease/Pages/default.aspx";
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
