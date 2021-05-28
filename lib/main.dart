import 'package:adminapp/pages/categoryAddPage.dart';
import 'package:adminapp/pages/itemEditPage.dart';
import 'package:flutter/material.dart';
import 'package:adminapp/pages/entryPage.dart';
import 'package:adminapp/pages/homePage.dart';
import 'package:adminapp/pages/loginPage.dart';
import 'package:adminapp/pages/splashPage.dart';
import 'package:adminapp/providers/homePageSubTabChange.dart';
import 'package:adminapp/providers/homePageTabChange.dart';
import 'package:adminapp/utils/assets/styles.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomePageTabChange(),
      child: ChangeNotifierProvider(
        create: (_) => HomePageSubTabChange(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: new AppColors().backgroundColor,
            accentColor: new AppColors().borderColor,
            fontFamily: 'Kalam',
          ),
          routes: {
            '/': (context) => SplashScreen(),
            '/homePage': (context) => HomePage(),
            '/entryPage': (context) => EntryPage(),
            '/loginPage': (context) => LoginPage(),
            '/itemEditPage': (context) => ItemEditPage(),
            '/categoryAddPage': (context) => CategoryAdd(),
          },
        ),
      ),
    );
  }
}
