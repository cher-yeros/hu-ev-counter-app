import 'package:flutter/material.dart';
import 'package:sampling/models/tesebaki_model.dart';
import 'package:sampling/utils/call_api.dart';
import 'package:sampling/utils/db_helpers.dart';
import 'package:sampling/utils/util.dart';
import 'package:sampling/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import '../constant/constants.dart';

class AddTesebaki extends StatefulWidget {
  @override
  _AddTesebakiState createState() => _AddTesebakiState();
}

class _AddTesebakiState extends State<AddTesebaki> {
  List<String> _types, _genders;
  String _type, _gender;
  bool _isLoading = false;
  TextEditingController _forName = TextEditingController();
  TextEditingController _forPhone = TextEditingController();

  DBHelper _dbHelper;
  @override
  void initState() {
    super.initState();
    _dbHelper = DBHelper();
    _types = ['yetekebele', 'yetemelese', 'tesfa_yesete'];
    _type = _types[0];

    _genders = ['female', 'male'];
    _gender = _genders[0];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text('Add new'),
          actions: <Widget>[
            IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext ctx) => HomeLanding()));
                })
          ],
        ),
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
                        Text('Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1)),
                        SizedBox(height: 30),
                        Container(
                            width: size.width,
                            height: 50,
                            decoration: ktfDecoration,
                            child: TextField(
                              controller: _forName,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: kLabelText,
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  )),
                            )),
                        SizedBox(height: 20),
                        Container(
                            width: size.width,
                            height: 50,
                            decoration: ktfDecoration,
                            child: TextField(
                              controller: _forPhone,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  labelText: 'Phone',
                                  labelStyle: kLabelText,
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  )),
                            )),
                        SizedBox(height: 20),
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
                              value: _gender,
                              disabledHint: Text('Choose Type...'),
                              dropdownColor: Colors.blue[800],
                              items: _genders
                                  .map((gender) => DropdownMenuItem(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.skip_next,
                                                color: Colors.white),
                                            SizedBox(width: 12),
                                            Text(gender,
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        value: gender,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              }),
                        ),
                        SizedBox(height: 20),
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
                              value: _type,
                              disabledHint: Text('Choose Type...'),
                              dropdownColor: Colors.blue[800],
                              items: _types
                                  .map((type) => DropdownMenuItem(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.merge_type,
                                                color: Colors.white),
                                            SizedBox(width: 12),
                                            Text(type,
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        value: type,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _type = value;
                                });
                              }),
                        ),
                        SizedBox(height: 40),
                        Container(
                          width: size.width,
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 9),
                            elevation: 5,
                            splashColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            onPressed: _performRegister,
                            child: Text(_isLoading ? 'Proccesing...' : 'Add',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ],
                    )))),
        drawer: Drawer(
          child: HomeDrawer(context: context),
        ));
  }

  _performRegister() async {
    //check connection
    //check wether approved or not
    //

    if (await Utility.checkConnection()) {
      await CallApi().refreshAccount();
    }

    SharedPreferences ls = await SharedPreferences.getInstance();
    bool approved = ls.getBool('approved');

    if (!approved) {
      Utility.flutterToast("You are not approved, wait for your approval!");
      return;
    }

    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var resSqlite, resApi;

    var campusId = ls.getInt('campusId');
    var sebakiId = ls.getInt('id');

    bool iCon = await Utility.checkConnection();

    String date = DateTime.now().toString();
    Tesebaki tesebaki = Tesebaki(
      name: _forName.text,
      phone: _forPhone.text.isEmpty
          ? DateTime.now().millisecondsSinceEpoch.toString()
          : _forPhone.text,
      type: _type,
      gender: _gender,
      campusId: campusId,
      sebakiId: sebakiId,
      isSent: 0,
      date: date,
    );
    if (iCon) {
      // if internet connection is available
      tesebaki.setIsSent(1);

      print('object ${tesebaki.type}');
      resSqlite = await _dbHelper.updateStatus(tesebaki);
      resApi = await CallApi().addTesebaki(tesebaki.toBeSent());

      setState(() {
        _isLoading = false;
      });

      if (resApi['success']) {
        Utility.flutterToast("Successfully Registerd to database!");
      } else {
        Utility.flutterToast("Not Successfully Registerd to database!");
      }

      print('Red api : $resApi');
      print('Red Sqlite : $resSqlite');
    } else {
      var result = await _dbHelper.insertTesebaki(tesebaki);

      setState(() {
        _isLoading = false;
      });

      if (result != 0) {
        await Utility.makeToast('Added Successfully!');
      } else {
        await Utility.makeToast('Oops! Something went wrong!');
      }
    }
  }
}
