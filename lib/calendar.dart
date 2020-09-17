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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
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

  Widget showDate(
    int date, {
    bool today = false,
    bool otherMonth = false,
    bool selected = false,
  }) {
    bool _darkMode = Theme.of(context).brightness == Brightness.dark;
    Color _backgroundColor = _darkMode ? Colors.white : Colors.black;
    Color _textColor = _darkMode ? Colors.black : Colors.white;
    return Container(
      padding: EdgeInsets.all(3),
      child: CircleAvatar(
        backgroundColor: selected
            ? (today ? Colors.red : _backgroundColor)
            : Colors.transparent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              otherMonth
                  ? Text(
                      ((date - 10) % 30 + 1).toString(),
                      style: TextStyle(
                        color: Colors.grey[!_darkMode ? 300 : 800],
                        fontSize: 14,
                      ),
                    )
                  : Text(
                      ((date - 10) % 30 + 1).toString(),
                      style: TextStyle(
                        color: selected
                            ? (today ? Colors.white : _textColor)
                            : (today
                                ? Colors.red
                                : Theme.of(context).textTheme.bodyText1.color),
                        fontSize: 14,
                      ),
                    ),
              otherMonth
                  ? Text(
                      date.toString(),
                      style: TextStyle(
                        color: Colors.grey[!_darkMode ? 300 : 800],
                        fontSize: 10,
                      ),
                    )
                  : Text(
                      date.toString(),
                      style: TextStyle(
                        color: selected
                            ? (today ? Colors.white : _textColor)
                            : (today
                                ? Colors.red
                                : Theme.of(context).textTheme.bodyText1.color),
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
