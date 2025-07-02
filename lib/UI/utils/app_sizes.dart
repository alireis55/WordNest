import 'package:flutter/material.dart';
import 'device_info.dart';

class AppSizes {
  static double getMinConstraintsHeight(BuildContext context) {
    final deviceInfo = DeviceInfo(context);
    return deviceInfo.screenHeight -
        deviceInfo.appBarHeight -
        deviceInfo.statusBarHeight -
        56 -
        deviceInfo.bottomBarHeight -
        100;
  }
}
