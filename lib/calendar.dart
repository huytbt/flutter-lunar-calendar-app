import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    int _date = 1;
    return Table(
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
              child: showDate(28, otherMonth: true),
            ),
            TableCell(
              child: showDate(29, otherMonth: true),
            ),
            TableCell(
              child: showDate(30, otherMonth: true),
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
              child: showDate(_date++, today: true, selected: true),
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
              child: showDate(_date++, selected: true),
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
              child: showDate(1, otherMonth: true),
            ),
            TableCell(
              child: showDate(2, otherMonth: true),
            ),
          ],
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

  Widget showDate(
    int date, {
    bool today = false,
    bool otherMonth = false,
    bool selected = false,
  }) {
    bool _darkMode = Theme.of(context).brightness == Brightness.dark;
    Color _background = _darkMode ? Colors.white : Colors.black;
    Color backgroundColor =
        selected ? (today ? Colors.red : _background) : Colors.transparent;
    Color _textColor = _darkMode ? Colors.black : Colors.white;
    Color _color = otherMonth
        ? Colors.grey[!_darkMode ? 300 : 800]
        : (selected
            ? (today ? Colors.white : _textColor)
            : (today
                ? Colors.red
                : Theme.of(context).textTheme.bodyText1.color));
    return Container(
      padding: EdgeInsets.all(3),
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ((date - 10) % 30 + 1).toString(),
                style: TextStyle(
                  color: _color,
                  fontSize: 14,
                ),
              ),
              Text(
                date.toString(),
                style: TextStyle(
                  color: _color,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
