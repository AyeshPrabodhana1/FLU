import 'package:flutter/material.dart';
import 'package:med_reminder/ui/splash_screen.dart';

void main() {
  runApp(MedReminder());
}

class MedReminder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      theme: ThemeData(primarySwatch: Colors.teal),
    );
  }
}
