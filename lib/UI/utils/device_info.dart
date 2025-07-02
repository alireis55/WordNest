import 'package:flutter/material.dart';

class DeviceInfo {
  final BuildContext context;
  DeviceInfo(this.context);

  Size get screenSize => MediaQuery.of(context).size;
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  double get statusBarHeight => MediaQuery.of(context).padding.top;
  double get bottomBarHeight => MediaQuery.of(context).padding.bottom;
  double get appBarHeight => AppBar().preferredSize.height;
}
