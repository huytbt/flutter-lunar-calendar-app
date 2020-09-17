import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    int _date = 1;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('September'),
            Text(
              '2020',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Table(
          children: [
            TableRow(
              children: [
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
                TableCell(
                  child: showHeader('SUN'),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: showDate(28),
                ),
                TableCell(
                  child: showDate(29),
                ),
                TableCell(
                  child: showDate(30),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++, today: true),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(_date++),
                ),
                TableCell(
                  child: showDate(1),
                ),
                TableCell(
                  child: showDate(2),
                ),
              ],
            ),
          ],
        ),
      ),
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

  Widget showDate(int date, {bool today = false}) {
    if (today) {
      return Container(
        padding: EdgeInsets.all(3),
        child: CircleAvatar(
          backgroundColor: Colors.red,
          child: Center(
            child: Text(
              date.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(15),
      child: Center(
        child: Text(date.toString()),
      ),
    );
  }
}
