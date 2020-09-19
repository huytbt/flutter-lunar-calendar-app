import 'package:flutter/material.dart';
import 'package:lunar_calendar/lunar-date.dart';
import 'package:lunar_calendar/month.dart';

class Calendar extends StatefulWidget {
  Calendar({
    Key key,
    this.controller,
    this.selectedDateTime,
    this.onSelectDateTime,
    this.onDisplayDateTime,
  }) : super(key: key);
  final DateTime selectedDateTime;
  final Function onSelectDateTime;
  final Function onDisplayDateTime;
  final CalendarController controller;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  static int _midIndex = 10000;
  PageController _pageController = PageController(initialPage: _midIndex);
  DateTime _fullMoonDay;
  DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    if (widget.selectedDateTime != null) {
      _selectedDateTime = widget.selectedDateTime;
    }
    if (widget.controller != null) {
      widget.controller.init(this);
    }
    setFullMoonDay();
  }

  void setFullMoonDay() {
    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    LunarDate lunarDate = LunarDate.fromDateTime(today);
    lunarDate.setDay(15);
    setState(() {
      _fullMoonDay = lunarDate.toDateTime();
    });
  }

  void goToday() {
    setState(() {
      _selectedDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
    });
    if (widget.onSelectDateTime != null) {
      widget.onSelectDateTime(_selectedDateTime);
    }
    _pageController.jumpToPage(_midIndex);
  }

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
              DateTime dateTime = _fullMoonDay.subtract(Duration(
                days: (29.530588853 * (_midIndex - index)).floor(),
              ));

              return Month(
                dateTime: dateTime,
                selectedDateTime: _selectedDateTime,
                onSelectDateTime: (dateTime) {
                  _selectedDateTime = dateTime;
                  if (widget.onSelectDateTime != null) {
                    widget.onSelectDateTime(_selectedDateTime);
                  }
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
            onPageChanged: (index) {
              if (widget.onDisplayDateTime != null) {
                DateTime dateTime = _fullMoonDay.subtract(Duration(
                  days: (29.530588853 * (_midIndex - index)).floor(),
                ));
                widget.onDisplayDateTime(dateTime);
              }
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

class CalendarController {
  _CalendarState _calendarState;

  void init(_CalendarState calendarState) {
    _calendarState = calendarState;
  }

  void goToday() {
    if (_calendarState != null) {
      _calendarState.goToday();
    }
  }
}
