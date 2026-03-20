import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bharatnxt/core/di/injector.dart';
import 'package:bharatnxt/core/local/local_storage_service.dart';
import 'package:bharatnxt/core/navigation/app_shell.dart';
import 'package:bharatnxt/core/theme/app_theme.dart';
import 'package:bharatnxt/core/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (_) => ThemeCubit(sl<LocalStorageService>()),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'BharatNxt',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            home: const AppShell(),
          );
        },
      ),
    );
  }
}
