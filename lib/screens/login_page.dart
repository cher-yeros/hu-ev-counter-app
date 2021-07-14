import 'package:flutter/material.dart';
import 'package:sampling/screens/signup_page.dart';
import 'package:sampling/utils/call_api.dart';
import 'package:sampling/utils/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _passwordError = '', _usernameError = '';
  bool _isLoading = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  _checkLoggedIn() async {
    // print('checked in login page');
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    bool loggedIn = sharedPref.getBool('loggedIn');

    // print("Logged IN : $loggedIn");

    if (loggedIn) {
      Navigator.pushNamed(context, '/home');
    } else {
      Navigator.pushNamed(context, '/login');
    }
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
                SizedBox(height: 30),
                Text('Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1)),
                SizedBox(height: 30),
                _form(size, ktfDecoration, kLabelText),
                // SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Forget Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: size.width,
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 9),
                    elevation: 5,
                    splashColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    onPressed: _performLogin,
                    child: Text(_isLoading ? 'Processing...' : 'Login',
                        style: TextStyle(fontSize: 20)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ));
                    },
                    child: Text(
                      'Didn\'ve been registered? Signup',
                      style: TextStyle(color: Colors.white),
                    ),
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
    var kerrorText = TextStyle(color: Colors.yellow, fontSize: 15);
    return Column(
      children: <Widget>[
        Container(
            width: size.width,
            height: 50,
            decoration: ktfDecoration,
            child: TextField(
              controller: _usernameController,
              cursorColor: Colors.white,
              // autofocus: true,
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
        SizedBox(height: 10),
        Container(
          child: Text(_usernameError, style: kerrorText),
        ),
        SizedBox(height: 10),
        Container(
            width: size.width,
            height: 50,
            decoration: ktfDecoration,
            child: TextField(
              controller: _passwordController,
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
          child: Text(_passwordError, style: kerrorText),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  _performLogin() async {
    bool conn = await Utility.checkConnection();

    if (!conn) {
      Utility.flutterToast("Please check your internet connection");
      return;
    }
    setState(() {
      _usernameError = '';
      _passwordError = '';
    });
    var uname = _usernameController.text;
    var pwd = _passwordController.text;

    if (uname.length < 5) {
      setState(() {
        _usernameError = 'Username must be at least 5 character';
      });
      return;
    }

    if (pwd.length < 8) {
      setState(() {
        _passwordError = 'Password must be at least 8 character';
      });
      return;
    }
    var data = {'username': uname, 'password': pwd};

    print(data);
    setState(() {
      _isLoading = true;
    });

    var res = await CallApi().login(data);

    print(res['success']);

    if (res['success']) {
      Navigator.pushNamed(context, '/home');
    } else {
      setState(() {
        _isLoading = false;
        _passwordError = res['error'];
      });
    }
  }
}
