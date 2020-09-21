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
        shadowColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        shadowColor: Colors.transparent,
        primaryColor: Color(0xFF101010),
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarColor: Color(0xFF101010),
        dialogBackgroundColor: Color(0xFF1F1F1F),
        accentColor: Colors.white,
        toggleableActiveColor: Colors.blue,
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
      ),
      home: CalendarScreen(),
    );
  }
}
