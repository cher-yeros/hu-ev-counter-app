import 'package:flutter/material.dart';
import 'package:sampling/screens/login_page.dart';
import 'package:sampling/utils/call_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    Key key,
    @required this.context,
  });
  final BuildContext context;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String _name = '', _username = '', _campus = '', _phone = '', _nameL = '';
  bool _approved = false;

  @override
  void initState() {
    super.initState();
    _checkApprove();
    // _setInfo();
  }

  _checkApprove() async {
    await CallApi().refreshAccount();
    _setInfo();
  }

  _setInfo() async {
    SharedPreferences lS = await SharedPreferences.getInstance();

    setState(() {
      _name = lS.getString('name');
      _username = lS.getString('username');
      _campus = lS.getString('campusName');
      _phone = lS.getString('phone');
      _nameL = lS.getString('name')[0].toUpperCase();
      _approved = lS.getBool('approved');
    });
  }

  @override
  Widget build(BuildContext context) {
    _setInfo();
    var style2 = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
    return Container(
      // color: Colors.blue[300],
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.only(top: 0.0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/pagetwo.jpg'),
                    fit: BoxFit.fill)),
            accountName: Text(_name),
            accountEmail: Text(_campus),
            currentAccountPicture: CircleAvatar(
                child: Text(_nameL,
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
          ),
          Container(
            color: _approved ? Colors.green[700] : Colors.red[700],
            child: ListTile(
              title: Text('Status', style: style2),
              subtitle: Text(_approved ? 'Approved' : 'Not - approved',
                  style: style2.copyWith(fontWeight: FontWeight.normal)),
              trailing: Icon(
                _approved ? Icons.verified_user : Icons.not_listed_location,
                color: Colors.white,
              ),
              onTap: () async {
                await CallApi().refreshAccount();
                _setInfo();
              },
            ),
          ),
          ListTile(
            title: Text('The Four(4) Lows'),
            trailing: Icon(Icons.event_note),
            onTap: () {
              Navigator.pushNamed(context, '/introduction');
            },
          ),
          ListTile(
            title: Text('Setting'),
            trailing: Icon(Icons.settings),
          ),
          Divider(),
          ListTile(
            onTap: () async {
              await _logout();
            },
            title: Text('Logout'),
            trailing: Icon(Icons.local_gas_station),
          ),
          ListTile(
            title: Text('Close'),
            trailing: Icon(Icons.close),
          )
        ],
      ),
    );
  }

  _logout() async {
    print("hey");
    SharedPreferences localS = await SharedPreferences.getInstance();
    // localS.remove('loggedIn');
    bool ranOnce = localS.getBool("ranOnce");
    var d = await localS.clear();

    print(d);
    localS.setBool('ranOnce', ranOnce);

    print('logged out already! and ${localS.getBool('logged_in')}');
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext ctx) => Login()));
  }
}
