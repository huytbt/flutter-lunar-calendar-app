import 'package:flutter/material.dart';
import 'package:date_util/date_util.dart';
import 'package:lunar_calendar/calendar.dart';
import 'package:lunar_calendar/lunar-date.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _displayedDateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    LunarDate lunarDate = LunarDate.fromDateTime(_displayedDateTime);
    DateUtil dateUtility = new DateUtil();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dateUtility.month(lunarDate.month) +
                (lunarDate.leap > 0 ? ' (Leap)' : '')),
            Text(
              '${lunarDate.year}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Calendar(
          onDisplayDateTime: (dateTime) {
            setState(() {
              _displayedDateTime = dateTime;
            });
          },
        ),
      ),
    );
  }
}
