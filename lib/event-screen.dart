import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  EventScreen({Key key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        leading: Container(),
        actions: [
          SizedBox(
            width: 70,
            child: IconButton(
              icon: Text('Done'),
              onPressed: () => Navigator.of(context).pop(null),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
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
        ),
      ),
    );
  }
}
