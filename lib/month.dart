import 'package:flutter/material.dart';
import 'package:lunar_calendar/lunar-date.dart';

class Month extends StatefulWidget {
  Month({Key key, this.dateTime}) : super(key: key);
  final DateTime dateTime;

  @override
  _MonthState createState() => _MonthState();
}

class _MonthState extends State<Month> {
  List<LunarDate> _monthDays = new List();
  LunarDate _lunarDate;
  DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    getMonthDays();
  }

  void getMonthDays() {
    _dateTime = widget.dateTime != null
        ? widget.dateTime
        : DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          );
    _lunarDate = LunarDate.fromDateTime(_dateTime);
    _lunarDate.day = 1;

    DateTime startDate = _lunarDate.toDateTime();
    startDate = startDate.subtract(Duration(days: startDate.weekday));

    DateTime endDate = _lunarDate.toDateTime();
    endDate = endDate.add(Duration(days: 28));
    while (LunarDate.fromDateTime(endDate.add(Duration(days: 1))).month ==
        _lunarDate.month) {
      endDate = endDate.add(Duration(days: 1));
    }
    endDate = endDate.add(Duration(days: 6 - endDate.weekday));

    while (endDate.difference(startDate).inDays >= 0) {
      _monthDays.add(LunarDate.fromDateTime(startDate));
      startDate = startDate.add(Duration(days: 1));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = new List();
    for (int row = 0; row < _monthDays.length / 7; row++) {
      List<Widget> cells = new List();
      for (int index = 0; index < 7; index++) {
        cells.add(TableCell(
          child: showDate(_monthDays[row * 7 + index]),
        ));
      }
      rows.add(TableRow(children: cells));
    }
    return Table(
      children: rows,
    );
  }

  Widget showDate(LunarDate lunarDate) {
    DateTime now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    DateTime dateTime = lunarDate.toDateTime();
    bool selected = dateTime.difference(_dateTime).inDays == 0;
    bool today = dateTime.difference(now).inDays == 0;
    bool otherMonth =
        lunarDate.month != LunarDate.fromDateTime(_dateTime).month;

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
    return GestureDetector(
      onTap: () {
        setState(() {
          _dateTime = dateTime;
        });
      },
      child: Container(
        padding: EdgeInsets.all(3),
        child: CircleAvatar(
          backgroundColor: backgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lunarDate.toDateTime().day.toString(),
                  style: TextStyle(
                    color: _color,
                    fontSize: 14,
                  ),
                ),
                Text(
                  lunarDate.day.toString(),
                  style: TextStyle(
                    color: _color,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
