import 'package:flutter/material.dart';
import 'package:date_util/date_util.dart';
import 'package:lunar_calendar/calendar.dart';
import 'package:lunar_calendar/event-screen.dart';
import 'package:lunar_calendar/event.dart';
import 'package:lunar_calendar/lunar-date.dart';
import 'package:lunar_calendar/setting-screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController = new CalendarController();
  DateTime _displayedDateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime _selectedDateTime = DateTime(
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Calendar(
              controller: _calendarController,
              onDisplayDateTime: (dateTime) {
                setState(() {
                  _displayedDateTime = dateTime;
                });
              },
              onSelectDateTime: (dateTime) {
                setState(() {
                  _selectedDateTime = dateTime;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: CalendarEvent(
                selectedDateTime: _selectedDateTime,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            children: [
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(),
                  child: Text('Today'),
                ),
                onTap: () {
                  _calendarController.goToday();
                },
              ),
              Spacer(),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(),
                  child: Text('Events'),
                ),
                onTap: () {
                  showBarModalBottomSheet(
                    context: context,
                    builder: (context, scrollController) {
                      return EventScreen();
                    },
                  );
                },
              ),
              Spacer(),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(),
                  child: Text('Settings'),
                ),
                onTap: () {
                  showBarModalBottomSheet(
                    context: context,
                    builder: (context, scrollController) {
                      return SettingScreen();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
