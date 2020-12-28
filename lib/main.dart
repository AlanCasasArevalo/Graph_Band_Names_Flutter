import 'package:flutter/material.dart';
import 'package:graphic_band_names/src/pages/home.dart';

import 'src/pages/status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: StatusPage.routeName,
        routes: {
          HomePage.routeName: (BuildContext context) => HomePage(),
          StatusPage.routeName: (BuildContext context) => StatusPage()
        },
    );
  }
}
