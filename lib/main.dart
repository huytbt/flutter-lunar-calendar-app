import 'package:flutter/material.dart';
import 'package:lunar_calendar/calendar-screen.dart';

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
        primaryColor: Color(0xFF090909),
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarColor: Color(0xFF090909),
      ),
      home: CalendarScreen(),
    );
  }
}
