import 'package:flutter/material.dart';
import 'package:sampling/models/campus.dart';
import 'package:sampling/utils/call_api.dart';
import '../constant/constants.dart';

import 'home_page.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isLoading = false;
  String _campus = '';
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _pwd = TextEditingController();
  TextEditingController _confirmPwd = TextEditingController();
  List<Text> errors = [];
  List<Campus> campuses = List<Campus>();
  @override
  void initState() {
    super.initState();
    campuses.add(Campus(slug: '1f', abbrev: 'HWU', name: 'Hawassa University'));
    // campuses
    //     .add(Campus(slug: '2a', abbrev: 'AAU', name: 'Addis Abeba University'));
    // campuses.add(Campus(slug: '3f', abbrev: 'JU', name: 'Jimma University'));

    // _campus = 'HWU';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: kGradientboxDecoration,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Text('SignUp',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1)),
                SizedBox(height: 30),
                _form(size, ktfDecoration, kLabelText),
                SizedBox(height: 20),
                Container(
                  width: size.width,
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 9),
                    elevation: 5,
                    splashColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    onPressed: _performSignUp,
                    child: Text(_isLoading ? 'Loading...' : 'Signup',
                        style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _form(Size size, BoxDecoration ktfDecoration, TextStyle kLabelText) {
    return Column(
      children: <Widget>[
        Container(
          width: size.width,
          height: 50,
          decoration: ktfDecoration,
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButton(
              underline: SizedBox(),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              value: _campus,
              disabledHint: Text('Choose Campus...'),
              dropdownColor: Colors.blue[800],
              // items: ['HWU', 'AAU', 'JU']
              //     .map((String value) => DropdownMenuItem(
              //         child: Row(
              //           children: <Widget>[
              //             Icon(Icons.school, color: Colors.white),
              //             SizedBox(width: 12),
              //             Text(value, style: TextStyle(color: Colors.white)),
              //           ],
              //         ),
              //         value: value))
              //     .toList(),
              items: campuses
                  .map((campus) => DropdownMenuItem(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.school, color: Colors.white),
                            SizedBox(width: 12),
                            Text(campus.name,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        value: campus.abbrev,
                      ))
                  .toList(),
              onChanged: (value) {
                print(value);
                setState(() {
                  // _campus = value;
                });
              }),
        ),
        // SizedBox(height: 10),
        // Container(
        //   child: Text(_usernameError, style: kerrorText),
        // ),
        SizedBox(height: 10),
        Container(
            width: size.width,
            height: 50,
            decoration: ktfDecoration,
            child: TextField(
              controller: _name,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  labelText: 'Full name',
                  labelStyle: kLabelText,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
            )),
        // SizedBox(height: 10),
        // Container(
        //   child: Text(_usernameError, style: kerrorText),
        // ),
        SizedBox(height: 10),
        Container(
            width: size.width,
            height: 50,
            decoration: ktfDecoration,
            child: TextField(
              controller: _phone,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  labelText: 'Phone',
                  labelStyle: kLabelText,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.white,
                  )),
            )),
        // SizedBox(height: 10),
        // Container(
        //   child: Text(_usernameError, style: kerrorText),
        // ),
        SizedBox(height: 10),
        Container(
            width: size.width,
            height: 50,
            decoration: ktfDecoration,
            child: TextField(
              controller: _username,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: kLabelText,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  prefixIcon: Icon(
                    Icons.supervised_user_circle,
                    color: Colors.white,
                  )),
            )),
        // SizedBox(height: 10),
        // Container(
        //   child: Text(_usernameError, style: kerrorText),
        // ),
        SizedBox(height: 10),
        Container(
            width: size.width,
            height: 50,
            decoration: ktfDecoration,
            child: TextField(
              controller: _pwd,
              obscureText: true,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  // prefixText: 'name',
                  labelText: 'Password',
                  labelStyle: kLabelText,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Colors.white,
                  )),
            )),
        SizedBox(height: 10),
        Container(
            width: size.width,
            height: 50,
            decoration: ktfDecoration,
            child: TextField(
              controller: _confirmPwd,
              obscureText: true,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  // prefixText: 'name',
                  labelText: 'Confirm Password',
                  labelStyle: kLabelText,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Colors.white,
                  )),
            )),

        SizedBox(height: 10),
      ],
    );
  }

  isNumeric(n) {
    try {
      double.tryParse(n);
      return true;
    } catch (e) {
      return false;
    }
  }

  _errorDialog(context, error) {
    showDialog(
        context: context,
        builder: (BuildContext ctxt) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(error),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context), child: Text('OK'))
            ],
          );
        });
  }

  _performSignUp() async {
    setState(() {
      // errors = [];
    });

    bool _login = true;

    var name = _name.text;
    var phone = _phone.text;
    var uname = _username.text;
    String pwd = _pwd.text;
    String cPwd = _confirmPwd.text;

    if (phone.length < 10 || !isNumeric(phone)) {
      _errorDialog(context, 'Please Enter a valid number!');
      return;
    }

    if (uname.length < 5) {
      _errorDialog(context, 'Username must be at least 5 character');
      return;
    }

    if (pwd.length < 8) {
      _errorDialog(context, 'Password must be at least 8 character');
      return;
    } else if (pwd != cPwd) {
      _errorDialog(context, 'Password does not match!');
      return;
    }

    var data = {
      'campus_id': 1,
      'name': name,
      'phone': phone,
      'username': uname,
      'password': pwd
    };

    setState(() {
      _isLoading = true;
    });

    var res = await CallApi().signUp(data);
    if (res != null) {
      setState(() {
        _login = false;
      });
      var errors = res['errors'] as Map;

      if (errors?.length != 0) {
        errors.forEach((key, value) {
          assert(key != null);
          _errorDialog(context, value[0]);
          return;
        });
      }
    }

    setState(() {
      _isLoading = false;
    });

    if (_login) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeLanding()));
    } else {
      setState(() {
        // _passwordError = res['error'];
      });
    }
  }
}
