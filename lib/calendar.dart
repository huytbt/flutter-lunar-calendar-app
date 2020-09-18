import 'package:flutter/material.dart';
import 'package:lunar_calendar/month.dart';
import 'package:swipedetector/swipedetector.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  bool _swipeDirection = false;
  DateTime _dateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          children: [
            TableRow(
              children: [
                TableCell(
                  child: showHeader('SUN'),
                ),
                TableCell(
                  child: showHeader('MON'),
                ),
                TableCell(
                  child: showHeader('TUE'),
                ),
                TableCell(
                  child: showHeader('WED'),
                ),
                TableCell(
                  child: showHeader('THU'),
                ),
                TableCell(
                  child: showHeader('FRI'),
                ),
                TableCell(
                  child: showHeader('SAT'),
                ),
              ],
            ),
          ],
        ),
        SwipeDetector(
          onSwipeLeft: () {
            setState(() {
              _swipeDirection = true;
              _dateTime = _dateTime.add(Duration(days: 30));
            });
          },
          onSwipeRight: () {
            setState(() {
              _swipeDirection = false;
              _dateTime = _dateTime.subtract(Duration(days: 30));
            });
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              final inAnimation =
                  Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                      .animate(animation);
              final outAnimation =
                  Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                      .animate(animation);

              if (child.key == ValueKey(_dateTime.toIso8601String())) {
                return ClipRect(
                  child: SlideTransition(
                    position: _swipeDirection ? inAnimation : outAnimation,
                    child: child,
                  ),
                );
              } else {
                return ClipRect(
                  child: SlideTransition(
                    position: !_swipeDirection ? inAnimation : outAnimation,
                    child: child,
                  ),
                );
              }
            },
            child: Month(
              key: ValueKey<String>(_dateTime.toIso8601String()),
              dateTime: _dateTime,
              onSelectPrevMonth: (DateTime dateTime) {
                setState(() {
                  _swipeDirection = true;
                  _dateTime = dateTime;
                });
              },
              onSelectNextMonth: (DateTime dateTime) {
                setState(() {
                  _swipeDirection = false;
                  _dateTime = dateTime;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget showHeader(String name) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
