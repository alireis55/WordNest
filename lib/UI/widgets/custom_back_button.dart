import 'package:flutter/material.dart';
import 'package:word_nest/ui/utils/app_sizes.dart';
import 'package:word_nest/ui/utils/device_info.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? top;
  final double? left;

  const CustomBackButton({
    super.key,
    this.onPressed,
    this.top,
    this.left,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top ?? DeviceInfo(context).statusBarHeight,
      left: left ?? AppSizes.spaceMedium,
      child: IconButton(
        onPressed: onPressed ??
            () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
