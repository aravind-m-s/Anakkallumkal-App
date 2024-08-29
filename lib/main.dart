import 'package:anakallumkal_app/common/functions/get_theme_data.dart';
import 'package:anakallumkal_app/common/theme/theme_bloc.dart';
import 'package:anakallumkal_app/modules/furniture/view/furniture_screen.dart';
import 'package:anakallumkal_app/utils/app_colors.dart';
import 'package:anakallumkal_app/utils/observer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: BlocProvider(
        create: (context) => ThemeBloc()..add(GetThemeEvent()),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            if (state is SwitchThemeState) {
              return MaterialApp(
                theme: getThemeData(state.isDarkMode),
                debugShowCheckedModeBanner: false,
                home: const FurnitureScreen(),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
