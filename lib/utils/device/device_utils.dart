import 'package:flutter/material.dart';

class DeviceUtils {
  DeviceUtils._();

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
