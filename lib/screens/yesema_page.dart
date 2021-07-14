import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sampling/models/tesebaki_model.dart';
import 'package:sampling/models/yesema_model.dart';
import 'package:sampling/utils/call_api.dart';
import 'package:sampling/utils/db_helpers.dart';
import 'package:sampling/utils/util.dart';
import 'package:sampling/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import '../constant/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddYesema extends StatefulWidget {
  @override
  _AddYesemaState createState() => _AddYesemaState();
}

class _AddYesemaState extends State<AddYesema> {
  bool _isLoading = false;
  TextEditingController _forvalue = TextEditingController();

  DBHelper _dbHelper;
  @override
  void initState() {
    super.initState();

    _dbHelper = DBHelper();
    Utility.exportOfflineData();
    _forvalue.text = '0';
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
        body: Container(
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
                      height: 70,
                      decoration: ktfDecoration,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              _btnClicked('+');
                            },
                            child: Container(
                              width: 65,
                              height: 65,
                              child: Icon(
                                Icons.add,
                                size: 40,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                          Container(
                              width: 100,
                              height: 50,
                              decoration: ktfDecoration,
                              child: TextField(
                                controller: _forvalue,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  // labelText: 'Value',
                                  labelStyle: kLabelText,
                                  border: InputBorder.none,

                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  // prefixIcon: Icon(
                                  //   Icons.format_list_numbered,
                                  //   color: Colors.white,
                                  // )
                                ),
                              )),
                          InkWell(
                            onTap: () {
                              _btnClicked('-');
                            },
                            child: Container(
                              width: 65,
                              height: 65,
                              child: Icon(
                                Icons.remove,
                                size: 40,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
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
                ))),
        drawer: Drawer(
          child: HomeDrawer(context: context),
        ));
  }

  _btnClicked(action) async {
    if (action == '+') {
      setState(() {
        int v = int.parse(_forvalue.text);
        v++;
        _forvalue.text = v.toString();
      });
    } else {
      int v = int.parse(_forvalue.text);
      if (v <= 0) {
        Utility.flutterToast("Number cannot be lessthan 0");
        return;
      }
      setState(() {
        v--;
        _forvalue.text = v.toString();
      });
    }
  }

  _performRegister() async {
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

    if (int.parse(_forvalue.text) <= 0) {
      Utility.flutterToast("Enter valid number!");
      return;
    }

    var campusId = ls.getInt('campusId');
    var sebakiId = ls.getInt('id');

    var number = 0;
    try {
      number = int.parse(_forvalue.text);
    } catch (e) {
      Utility.flutterToast("the input must be valid number");
      return;
    }

    setState(() {
      _isLoading = true;
    });
    bool iCon = await Utility.checkConnection();
    if (!iCon) {
      String date = DateTime.now().toString();
      Yesema yesema = new Yesema(
          number: number,
          campusId: campusId,
          sebakiId: sebakiId,
          isSent: 0,
          date: date);

      var result = await _dbHelper.insertYesema(yesema);

      setState(() {
        _isLoading = false;
      });

      if (result != 0) {
        await Utility.makeToast('Added Successfully!');
        _forvalue.text = '0';
      } else {
        await Utility.makeToast('Oops! Something went wrong!');
      }
    } else {
      var data = {'campusId': campusId, 'sebakiId': sebakiId, 'number': number};

      var res = await new CallApi().AddYesema(data);

      print(res["success"]);

      setState(() {
        _isLoading = false;
      });

      if (res["success"]) {
        Utility.flutterToast("successfully sent!");
      } else {
        Utility.flutterToast("something went wrong");
      }
    }
    _forvalue.text = '0';
  }
}
