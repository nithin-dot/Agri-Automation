import 'package:flutter/material.dart';
import 'package:agro/utilities/hex_color.dart';

ThemeData appTheme() => ThemeData(
      backgroundColor: Colors.black,
      primaryColor: HexColor('#E2EDF8'),
      accentColor: Colors.blue,
      cursorColor: Colors.blue,
      scaffoldBackgroundColor: HexColor('#E2EDF8'),
    );
