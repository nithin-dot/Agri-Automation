import 'package:clippy_flutter/arrow.dart';
import 'package:control_pad/views/joystick_view.dart';
import 'package:flutter/material.dart';

class Drone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: JoystickView(
                      onDirectionChanged: (degrees, distance) =>
                          {print(degrees)},
                      size: 120,
                      iconsColor: Colors.white,
                      backgroundColor: Colors.white,
                      showArrows: false,
                      innerCircleColor: Colors.grey),
                ),
                SizedBox(
                  height: 240,
                ),
                InkWell(
                  onTap: () => {print("Down")},
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(right: 25.0),
                      child: Arrow(
                        clipShadows: [ClipShadow(color: Colors.black)],
                        edge: Edge.LEFT,
                        triangleHeight: 25.0,
                        rectangleClipHeight: 20.0,
                        child: Container(
                          width: 50.0,
                          height: 70.0,
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => {print("UP")},
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: 13.0),
                      child: Arrow(
                        clipShadows: [ClipShadow(color: Colors.black)],
                        triangleHeight: 25.0,
                        rectangleClipHeight: 20.0,
                        child: Container(
                          width: 50.0,
                          height: 70.0,
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 130,
          ),
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 2.2,
                child: JoystickView(
                    onDirectionChanged: (degrees, distance) => {print(degrees)},
                    size: 120,
                    iconsColor: Colors.white,
                    backgroundColor: Colors.white,
                    showArrows: false,
                    innerCircleColor: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
