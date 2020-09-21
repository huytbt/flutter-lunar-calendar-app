import 'package:flutter/material.dart';

class EventForm extends StatefulWidget {
  EventForm({Key key}) : super(key: key);

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Event'),
        leading: SizedBox(
          width: 70,
          child: IconButton(
            icon: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(null),
          ),
        ),
        leadingWidth: 70,
        actions: [
          SizedBox(
            width: 70,
            child: IconButton(
              icon: Text('Save'),
              onPressed: () => Navigator.of(context).pop(null),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 20),
            ListTile(
              title: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Lunar Calendar'),
              trailing: Switch(
                value: true,
                onChanged: (bool value) {},
              ),
            ),
            ListTile(
              title: Text('Date'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: Text('Repeat'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
