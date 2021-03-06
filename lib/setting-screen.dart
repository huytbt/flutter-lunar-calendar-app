import 'package:flutter/material.dart';
import 'package:lunar_calendar/forgot-password-form.dart';
import 'package:lunar_calendar/login-form.dart';
import 'package:lunar_calendar/register-form.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
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
            Container(
              padding: EdgeInsets.all(15),
              child: Text('ACCOUNT'),
            ),
            Container(
              child: InkWell(
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green[100],
                    ),
                    child: Icon(
                      Icons.login,
                      color: Colors.green[800],
                    ),
                  ),
                  title: Text('Login'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: LoginForm(),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              child: InkWell(
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blue[100],
                    ),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.blue[800],
                    ),
                  ),
                  title: Text('Register'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: RegisterForm(),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              child: InkWell(
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.amber[100],
                    ),
                    child: Icon(
                      Icons.lock_open,
                      color: Colors.amber[800],
                    ),
                  ),
                  title: Text('Forgot Password'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: ForgotPasswordForm(),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text('LEGAL'),
            ),
            Container(
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                  child: Icon(
                    Icons.privacy_tip,
                    color: Colors.grey[800],
                  ),
                ),
                title: Text('Privacy Policy'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Container(
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.orange[100],
                  ),
                  child: Icon(
                    Icons.library_books,
                    color: Colors.orange[800],
                  ),
                ),
                title: Text('Terms of Use'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
