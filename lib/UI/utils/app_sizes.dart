import 'package:flutter/material.dart';
import 'device_info.dart';

class AppSizes {
  static const double singleChildScrollPadding = 20;
  static const double logoSize = 160;

  //space

  static const double spaceXSmall = 4;
  static const double spaceSmall = 8;
  static const double spaceMedium = 16;
  static const double spaceLarge = 24;
  static const double spaceXLarge = 32;
  static const double spaceXXLarge = 40;
  static const double spaceXXXLarge = 48;

  //font size

  static const double fontSizeSmall = 8;
  static const double fontSizeMedium = 12;
  static const double fontSizeLarge = 16;
  static const double fontSizeXLarge = 20;
  static const double fontSizeXXLarge = 24;
  static const double fontSizeXXXLarge = 28;

  //card

  static const double cardSwipperSize = 330;
  static const double cardSwipperOffset = 30;
  static const double cardPadding = 8;
  static const double cardBorderRadius = 20;
  static const double cardTextSize = 18;
  static const double cardBorderWidth = 3;
  static const double cardBlurSigma = 50;

  //dismissible card

  static const double dismissibleCardPadding = 15;
  static const double dismissibleCardVerticalPadding = 8;
  static const double dismissibleCardHerizontalPadding = 16;
  static const double dismissibleRadius = 16;
  static const double dismissibleIconSize = 28;
  static const double dismissiblePaddingRight = 24;

  //button

  static const double buttonHeight = 54;
  static const double buttonBorderRadius = 30;

  //fab

  static const double fabIconSize = 35;
  static const double fabBorderRadius = 16;
  static const double fabElevation = 7;
  static const double fabFocusElevation = 0;
  static const double fabHighLightElevation = 0;

  //icon

  static const double iconSizeLarge = 80;
  static const double iconSizeMedium = 32;
  static const double iconSizeSmall = 15;

  //textfield

  static const double textFieldBorderRadius = 30;
  static const double textFieldPadding = 3;
  static const double textFieldBorderWidth = 1;

  //refresh indicator

  static const double refreshIndicatorSize = 36;
  static const double refreshIndicatorStroke = 5;

  //snackBar

  static const double snackBarRadius = 20;

  static double getMinConstraintsHeight(BuildContext context) {
    final deviceInfo = DeviceInfo(context);
    return deviceInfo.screenHeight -
        deviceInfo.appBarHeight -
        deviceInfo.statusBarHeight -
        deviceInfo.bottomBarHeight -
        deviceInfo.bottomNavigationBarHeight;
  }
}
