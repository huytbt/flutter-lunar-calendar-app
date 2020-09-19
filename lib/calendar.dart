import 'package:flutter/material.dart';
import 'package:lunar_calendar/month.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  static int _midIndex = 10000;
  PageController _pageController = PageController(initialPage: _midIndex);
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
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: _midIndex * 2,
            itemBuilder: (BuildContext context, int index) {
              DateTime dateTime = DateTime(
                _dateTime.year,
                _dateTime.month - (_midIndex - index),
                _dateTime.day,
              );
              return Month(
                dateTime: dateTime,
                selectedDateTime: dateTime,
                onSelectDateTime: (dateTime) {
                  _dateTime = dateTime;
                },
                onSelectPrevMonth: (DateTime dateTime) {
                  _pageController.animateToPage(
                    index - 1,
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 500),
                  );
                },
                onSelectNextMonth: (DateTime dateTime) {
                  _pageController.animateToPage(
                    index + 1,
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 500),
                  );
                },
              );
            },
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
