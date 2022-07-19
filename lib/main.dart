// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:medical_project/generated/codegen_loader.g.dart';
import 'package:medical_project/home_screen.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        path: 'assets/translation',
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        assetLoader: CodegenLoader(),
        fallbackLocale: Locale('en'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
