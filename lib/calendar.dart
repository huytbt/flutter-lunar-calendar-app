import 'package:flutter/material.dart';
import 'package:lunar_calendar/month.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
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
        Month(),
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
