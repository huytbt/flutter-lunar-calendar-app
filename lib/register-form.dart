import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 15),
            child: Center(
              child: Text('Register'),
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.info),
                hintText: 'Name',
              ),
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Email',
              ),
            ),
          ),
          Container(
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Password',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            child: RaisedButton(
              child: Text('Register'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
