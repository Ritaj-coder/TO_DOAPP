// import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app1/home/auth/login/login_screen.dart';
import 'package:to_do_app1/home/home_screen.dart';
import 'package:to_do_app1/my_theme_data.dart';
import 'package:to_do_app1/providers/appconfigprovider.dart';
import 'package:to_do_app1/providers/list_proivder.dart';

import 'home/auth/register/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyAibjls3GvWOWS-rxUOI3jFNC_D-f2vdGk',
              appId: 'com.example.to_do_app1',
              messagingSenderId: '871017324671',
              projectId: 'todo-app-88634'))
      : await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => AppConfigProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ListProvider(),
      )
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routename,
      routes: {
        LoginScreen.routename: (context) => LoginScreen(),
        RegisterScreen.routename: (context) => RegisterScreen(),
        HomeScreen.routename: (context) => HomeScreen()
      },
      theme: MyThemeData.LightTheme,
      darkTheme: MyThemeData.DarkTheme,
      themeMode: provider.apptheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.applanguage),
    );
  }
}
