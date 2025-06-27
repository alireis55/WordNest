import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_nest/UI/view/root/root_view.dart';
import 'package:word_nest/core/Cubit/word_cubit.dart';
import 'package:word_nest/core/Cubit/authorization_cubit.dart';
import 'package:word_nest/core/Cubit/connection_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WordCubit()),
        BlocProvider(create: (context) => AuthorizationCubit()),
        BlocProvider(create: (context) => ConnectionCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 227, 221, 239)),
          useMaterial3: true,
        ),
        home: const RootView(),
      ),
    );
  }
}
