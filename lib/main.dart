import 'package:flutter/material.dart';
import 'package:graphic_band_names/src/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (BuildContext context) => HomePage()
        },
    );
  }
}
