import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_nest/core/cubits/connection_cubit.dart';
import 'package:word_nest/ui/widgets/custom_button.dart';
import 'package:word_nest/ui/utils/app_colors.dart';
import 'package:word_nest/ui/utils/app_sizes.dart';

class NotConnectionView extends StatelessWidget {
  const NotConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.singleChildScrollPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off,
                  size: AppSizes.iconSizeLarge, color: AppColors.grey),
              const SizedBox(
                height: AppSizes.spaceMedium,
              ),
              const Text(
                'No Connection',
                style: TextStyle(
                    fontSize: AppSizes.fontSizeXLarge,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: AppSizes.spaceMedium,
              ),
              const Text(
                'Please check your internet connection',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: AppSizes.fontSizeLarge, color: AppColors.grey),
              ),
              const SizedBox(
                height: AppSizes.spaceMedium,
              ),
              CustomButton(
                text: 'Retry',
                onPressed: () async {
                  await context.read<ConnectionCubit>().checkConnection();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
