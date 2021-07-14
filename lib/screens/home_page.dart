import 'package:flutter/material.dart';
import 'package:sampling/screens/list/export_list.dart';
import 'package:sampling/screens/list/exported_list.dart';
import 'package:sampling/screens/yesema_page.dart';
import 'package:sampling/utils/call_api.dart';
import 'package:sampling/utils/util.dart';
import 'package:sampling/widgets/drawer.dart';
import 'list/all_list_tesebaki.dart';
import 'register_tesebaki.dart';

class HomeLanding extends StatefulWidget {
  @override
  _HomeLandingState createState() => _HomeLandingState();
}

class _HomeLandingState extends State<HomeLanding> {
  // String _name = '', _username = '', _campus = '', _phone = '', _nameL = '';

  bool _started = false;
  String messege = "";
  @override
  void initState() {
    super.initState();
    _checkEvangeStatus();
    // setInfo();
  }

  _checkEvangeStatus() async {
    var res = await new CallApi().checkForEvangeWeek();
    print(res['evange']);
    if (res['evange']['started'] == 1) {
      setState(() {
        _started = true;
      });
    }

    setState(() {
      // messege = res['evange']['messege'];
    });

    print(messege);
  }

  // setInfo() async {
  //   SharedPreferences localS = await SharedPreferences.getInstance();
  //   List<String> user = localS.getStringList('user');
  //   setState(() {
  //     _name = user[1];
  //     _username = user[3];
  //     _campus = user[4];
  //     _phone = user[2];
  //     _nameL = user[1][0].toUpperCase();
  //   });
  //   // print('$_name - $_username - $_campus - $_phone - $_nameL');
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var kInfoBtnDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              offset: Offset(4, 4), blurRadius: 20, color: Colors.blue[800])
        ]);
    return Scaffold(
        appBar: AppBar(
          title: Text('Evange Counter'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
          height: size.height,
          width: size.width,
          child: Stack(children: [
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * .4,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 5),
                            color: Colors.blue[900],
                            blurRadius: 20)
                      ]),
                )),
            Column(children: [
              Container(
                width: double.infinity,
                height: 100,
                padding: EdgeInsets.all(15),
                // color: Colors.green,
                child: Text(
                  _started
                      ? 'um dolor sit amet, sea , at intuo. Est ne tollit ullamcorper, eu pro falli diceret perpetua, sea ferri numquam legendos ut.'
                      : messege,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _started
                  ? Column(
                      children: [
                        Text(
                          'Add Info Here',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              splashColor: Colors.blue,
                              hoverColor: Colors.blue,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext ctx) =>
                                            AddTesebaki()));
                              },
                              child: Container(
                                height: 50,
                                width: 130,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: kInfoBtnDecoration,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Add new',
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext ctx) =>
                                            AllList()));
                              },
                              child: Container(
                                height: 50,
                                width: 130,
                                padding: EdgeInsets.all(10),
                                decoration: kInfoBtnDecoration,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('All List',
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext ctx) =>
                                            ExportList()));
                              },
                              child: Container(
                                height: 50,
                                width: 130,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: kInfoBtnDecoration,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Export',
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext ctx) =>
                                            ExportedList()));
                              },
                              child: Container(
                                height: 50,
                                width: 130,
                                padding: EdgeInsets.all(10),
                                decoration: kInfoBtnDecoration,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Exported List',
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 130,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: kInfoBtnDecoration,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Unsent list',
                                      style: TextStyle(fontSize: 17)),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext ctx) =>
                                            AddYesema()));
                              },
                              child: Container(
                                height: 50,
                                width: 130,
                                padding: EdgeInsets.all(10),
                                decoration: kInfoBtnDecoration,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Yesema',
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : Center(
                      child: Text(
                        "Evange week doesn't start yet!",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
            ]),
          ]),
        )),
        drawer: Drawer(
          child: HomeDrawer(context: context),
        ));
  }
}
