import 'package:flutter/material.dart';
import 'package:lunar_calendar/lunar-date.dart';

class Month extends StatefulWidget {
  Month({
    Key key,
    @required this.dateTime,
    this.selectedDateTime,
    this.onSelectDateTime,
    this.onSelectPrevMonth,
    this.onSelectNextMonth,
  }) : super(key: key);
  final DateTime dateTime;
  final DateTime selectedDateTime;
  final Function onSelectDateTime;
  final Function onSelectPrevMonth;
  final Function onSelectNextMonth;

  @override
  _MonthState createState() => _MonthState();
}

class _MonthState extends State<Month> {
  List<LunarDate> _monthDays = new List();
  LunarDate _lunarDate;
  DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    getMonthDays();
  }

  void getMonthDays() {
    List<LunarDate> monthDays = new List();
    _selectedDateTime = widget.selectedDateTime != null
        ? widget.selectedDateTime
        : DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          );

    _lunarDate = LunarDate.fromDateTime(widget.dateTime);

    DateTime startDate = _lunarDate.firstDayOfMonth().toDateTime();
    startDate = startDate.subtract(Duration(days: startDate.weekday % 7));

    DateTime endDate = _lunarDate.lastDayOfMonth().toDateTime();
    endDate = endDate.add(Duration(days: 6 - endDate.weekday % 7));

    while (endDate.difference(startDate).inDays >= 0) {
      monthDays.add(LunarDate.fromDateTime(startDate));
      startDate = startDate.add(Duration(days: 1));
    }

    setState(() {
      _monthDays = monthDays;
    });
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
    bool selected = dateTime.difference(_selectedDateTime).inDays == 0;
    bool today = dateTime.difference(now).inDays == 0;
    bool otherMonth =
        lunarDate.month != LunarDate.fromDateTime(widget.dateTime).month ||
            lunarDate.leap != LunarDate.fromDateTime(widget.dateTime).leap;
    bool hasEvents = lunarDate.day == 15;

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
        if (widget.onSelectDateTime != null) {
          widget.onSelectDateTime(dateTime);
        }
        if (otherMonth) {
          if (widget.onSelectPrevMonth != null &&
              !widget.dateTime.difference(dateTime).isNegative) {
            widget.onSelectPrevMonth(dateTime);
          }
          if (widget.onSelectNextMonth != null &&
              widget.dateTime.difference(dateTime).isNegative) {
            widget.onSelectNextMonth(dateTime);
          }
        } else {
          setState(() {
            _selectedDateTime = dateTime;
          });
        }
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(),
            child: CircleAvatar(
              backgroundColor: backgroundColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dateTime.day.toString() +
                          (dateTime.day == 1 ? '/${dateTime.month}' : ''),
                      style: TextStyle(
                        color: _color,
                        fontSize: 15,
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
          Container(
            width: double.infinity,
            decoration: BoxDecoration(),
            child: Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: hasEvents
                    ? Colors.grey[!_darkMode ? 400 : 800]
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            height: 10,
            decoration: BoxDecoration(),
          ),
        ],
      ),
    );
  }
}
