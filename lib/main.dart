import 'package:flutter/material.dart';
import 'package:lunar_calendar/calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lunar Calendar',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.lightBlue[900],
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: CalendarScreen(),
    );
  }
}
