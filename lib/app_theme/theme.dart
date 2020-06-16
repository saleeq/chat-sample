import 'package:flutter/material.dart';

/***
 * Dynamic App theme handler classes
 *
 */
class AppTheme {
  Color appPrimaryColor;
  Color appBackgroundColor;
  Color textColorDark;
  Color textColorLight;
  Color messageBackgroundColor;
}


class AppDarkTheme extends AppTheme{
  AppDarkTheme(){
    appPrimaryColor = Colors.black;
    appBackgroundColor = Colors.black54;
    textColorDark = Colors.white;
    textColorLight = Colors.grey.shade50;
    messageBackgroundColor = Colors.grey;
  }
}

class AppLightTheme extends AppTheme{
  AppLightTheme(){
    appPrimaryColor = Colors.red.shade800;
    appBackgroundColor = Colors.grey.shade100;
    textColorDark = Colors.black;
    textColorLight = Colors.black54;
    messageBackgroundColor = Colors.white;
  }
}