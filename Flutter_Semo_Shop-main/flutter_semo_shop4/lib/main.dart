import 'package:flutter/material.dart';
import 'package:flutter_semo_shop4/Screens/LoginScreen.dart';

import 'giris.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
