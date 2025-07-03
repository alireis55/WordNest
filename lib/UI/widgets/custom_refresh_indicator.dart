import 'package:flutter/material.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:word_nest/ui/utils/app_colors.dart';
import 'package:word_nest/ui/utils/app_sizes.dart';

class MyCustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const MyCustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: onRefresh,
      builder:
          (BuildContext context, Widget child, IndicatorController controller) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            child,
            if (controller.isLoading || controller.value > 0)
              Positioned(
                top: AppSizes.spaceMedium,
                child: Opacity(
                  opacity: controller.value.clamp(0.0, 1.0),
                  child: SizedBox(
                    height: AppSizes.refreshIndicatorSize,
                    width: AppSizes.refreshIndicatorSize,
                    child: CircularProgressIndicator(
                      value: controller.isLoading ? null : controller.value,
                      strokeWidth: AppSizes.refreshIndicatorStroke,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
      child: child,
    );
  }
}
