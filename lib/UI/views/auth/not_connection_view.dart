import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_nest/core/cubits/connection_cubit.dart';
import 'package:word_nest/ui/widgets/custom_button.dart';
import 'package:word_nest/ui/utils/app_colors.dart';

class NotConnectionView extends StatelessWidget {
  const NotConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 80, color: AppColors.grey),
              const SizedBox(height: 24),
              const Text(
                'No Connection',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Please check your internet connection',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.grey),
              ),
              const SizedBox(height: 32),
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
