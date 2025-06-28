import 'package:flutter/material.dart';
import 'package:word_nest/core/cubits/authorization_cubit.dart';
import 'package:word_nest/core/cubits/connection_cubit.dart';
import 'package:word_nest/ui/views/auth/auth_view.dart';
import 'package:word_nest/ui/views/auth/not_connection_view.dart';
import 'package:word_nest/ui/views/home/navigation_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  @override
  void initState() {
    super.initState();
    context.read<ConnectionCubit>().checkConnection();
    context.read<AuthorizationCubit>().checkAuthorization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<ConnectionCubit, bool>(
        builder: (context, isConnected) {
          if (!isConnected) {
            return const NotConnectionView();
          } else {
            return BlocBuilder<AuthorizationCubit, bool>(
              builder: (context, authorized) {
                if (authorized) {
                  return const NavigationView();
                } else {
                  return const AuthView();
                }
              },
            );
          }
        },
      ),
    );
  }
}
