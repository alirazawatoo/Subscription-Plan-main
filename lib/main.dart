import 'package:flutter/material.dart';
import 'package:flutter_stacked_starter/constants/constants.dart';
import 'package:flutter_stacked_starter/utils/app_text.dart';
import 'package:flutter_stacked_starter/utils/shared/setup_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';

void main() {
  setupLocator();
  setupDialogUi();
  runApp(const MyApp());
}

ThemeData buildTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: kcSecondaryColor,
    brightness: Brightness.dark,
  ).copyWith(
    primary: kcSecondaryColor,
    onPrimary: kcPrimaryColor,
    secondary: kcAccentColor,
    surface: kcPrimaryColor,
    onSurface: kcTextColor,
  );
  return ThemeData(
    colorScheme: scheme,
    fontFamily: kFontFamily,
    scaffoldBackgroundColor: kcPrimaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: kcPrimaryColor,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: kFontFamily,
        fontSize: 17,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kcSecondaryColor,
        foregroundColor: kcPrimaryColor,
        disabledBackgroundColor: kcSurfaceColor,
        disabledForegroundColor: kcMutedTextColor,
        minimumSize: const Size(220, 48),
        textStyle: const TextStyle(
          fontFamily: kFontFamily,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subscription Plan',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
