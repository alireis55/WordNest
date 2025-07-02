import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_nest/core/cubits/favorite_cubit.dart';
import 'package:word_nest/ui/views/root/root_view.dart';
import 'package:word_nest/ui/widgets/custom_global_loader_overlay.dart';
import 'package:word_nest/core/cubits/cache_cubit.dart';
import 'package:word_nest/core/cubits/word_cubit.dart';
import 'package:word_nest/core/cubits/authorization_cubit.dart';
import 'package:word_nest/core/cubits/connection_cubit.dart';

void main() {
  runApp(
    const MyApp(),
  );
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
        BlocProvider(create: (context) => CacheCubit()),
        BlocProvider(create: (context) => FavoriteCubit()),
      ],
      child: CustomGlobalLoaderOverlay(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: false,
          ),
          home: const RootView(),
        ),
      ),
    );
  }
}
