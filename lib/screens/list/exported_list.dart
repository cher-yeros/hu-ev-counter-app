import 'package:flutter/material.dart';
import 'package:sampling/models/tesebaki_model.dart';
import 'package:sampling/utils/db_helpers.dart';
import 'package:sampling/widgets/drawer.dart';

import '../home_page.dart';

class ExportedList extends StatefulWidget {
  @override
  _ExportListState createState() => _ExportListState();
}

class _ExportListState extends State<ExportedList> {
  List<Tesebaki> tesebakis;
  int count = 0;
  DBHelper _dbHelper;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _dbHelper = DBHelper();
    _setListValue();
  }

  _setListValue() async {
    List<Tesebaki> list = await _dbHelper.getSentTesebakisList();

    setState(() {
      tesebakis = list;
      count = tesebakis.length;
      _isLoading = false;
    });
  }

  _checkSent(val) {
    switch (val) {
      case 0:
        return 'Not sent';

      case 1:
        return 'Sent';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Exported List'),
        actions: <Widget>[
          CircleAvatar(child: Text(count.toString())),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => HomeLanding()));
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: ListView.builder(
                itemCount: count,
                itemBuilder: (BuildContext ctx, i) {
                  return ListTile(
                      title: Text('tesebakis[i].date'),
                      subtitle: Text(_checkSent(tesebakis[i].isSent)));
                }),
          ),
          _isLoading
              ? Container(
                  width: size.width,
                  height: size.height,
                  color: Colors.black.withOpacity(0.8),
                  child: Center(child: CircularProgressIndicator()),
                )
              : Container()
        ],
      ),
      drawer: Drawer(child: HomeDrawer(context: context)),
    );
  }
}
