import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunar_calendar/lunar-date.dart';

class CalendarEvent extends StatefulWidget {
  CalendarEvent({
    Key key,
    this.selectedDateTime,
  }) : super(key: key);
  final DateTime selectedDateTime;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<CalendarEvent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    String dateLabel = widget.selectedDateTime.difference(now).inDays == 0
        ? 'Today'
        : (DateFormat('yyyy-MM-dd').format(widget.selectedDateTime) +
            ' / ' +
            LunarDate.fromDateTime(widget.selectedDateTime).toString());
    return Column(
      children: [
        ListTile(
          title: Text(dateLabel),
          subtitle: Text('3 Events'),
        ),
        Expanded(
          child: ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(
                  title: Text('Mon\'s birthday'),
                  trailing: Text('Yearly'),
                  leading: Icon(Icons.cake),
                ),
                ListTile(
                  title: Text('Design review'),
                  trailing: Text('Once'),
                  leading: Icon(Icons.event),
                ),
                ListTile(
                  title: Text('Implement code'),
                  trailing: Text('Once'),
                  leading: Icon(Icons.event),
                ),
              ],
            ).toList(),
          ),
        ),
      ],
    );
  }
}
