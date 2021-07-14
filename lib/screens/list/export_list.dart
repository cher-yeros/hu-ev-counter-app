import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';
import 'package:sampling/models/tesebaki_model.dart';
import 'package:sampling/utils/call_api.dart';
import 'package:sampling/utils/db_helpers.dart';
import 'package:sampling/utils/util.dart';
import 'package:sampling/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page.dart';

class ExportList extends StatefulWidget {
  @override
  _ExportListState createState() => _ExportListState();
}

class _ExportListState extends State<ExportList> {
  List<Tesebaki> tesebakis;
  int count = 0;
  DBHelper _dbHelper;
  bool _exporting;
  @override
  void initState() {
    super.initState();
    _dbHelper = DBHelper();
    _setListValue();
  }

  _setListValue() async {
    // Database dbfuture = await _dbHelper.initializeDatabase();
    List<Tesebaki> list = await _dbHelper.getUnSentTesebakisList();

    // print(list[0].date);

    setState(() {
      tesebakis = list;
      count = tesebakis.length;
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
    _exporting = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Export List'),
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
          (count != 0)
              ? _dataBody()
              : Center(child: Text('No unexported list is found!')),
          _exporting
              ? Container(
                  width: size.width,
                  height: size.height,
                  color: Colors.black.withOpacity(0.8),
                  child: Center(child: CircularProgressIndicator()),
                )
              : Container(),
        ],
      ),
      bottomSheet: Container(
        color: Colors.grey.withOpacity(0.2),
        height: 70,
        width: size.width,
        child: Center(
            child: InkWell(
          splashColor: Colors.blue,
          onTap: _performExport,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple[800]),
                borderRadius: BorderRadius.circular(10)),
            child: Text(_exporting ? 'Exporting' : 'Export',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[800])),
          ),
        )),
      ),
      drawer: Drawer(child: HomeDrawer(context: context)),
    );
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

  void _performExport() async {
    if (count == 0) {
      await Utility.makeToast('No unexported list is found!');
      return;
    }

    await CallApi().refreshAccount();

    SharedPreferences lS = await SharedPreferences.getInstance();
    if (!lS.getBool('approved')) {
      _errorDialog(context, 'You are not approved!');
      return;
    }

    setState(() {
      _exporting = true;
    });

    var resSqlite, resApi;

    tesebakis.forEach((tesebaki) async {
      tesebaki.setIsSent(1);
      resSqlite = await _dbHelper.updateStatus(tesebaki);
      resApi = await CallApi().addTesebaki(tesebaki.toBeSent());
    });

    setState(() {
      _exporting = false;
    });

    _setListValue();
    print('Result Sqlite : $resSqlite');
    print('Result Api : $resApi');

    await Utility.makeToast('List Exported Successfully!');
  }

  _dataBody() {
    var tableHeaderStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    return DataTable(
        // sortColumnIndex: colI,
        // sortAscending: sort,
        // dividerThickness: 2,
        // columnSpacing: 30.0,
        // showCheckboxColumn: true,
        columns: [
          DataColumn(
              label: Text(
                'Name',
                style: tableHeaderStyle,
              ),
              numeric: false,
              onSort: (i, a) {
                setState(() {
                  // sort = !sort;
                  // colI = i;
                });
                // sortColumn(i, a);
              },
              tooltip: "Name, if registered"),
          DataColumn(
              label: Text(
                'Status',
                style: tableHeaderStyle,
              ),
              numeric: false,
              onSort: (i, a) {},
              tooltip: 'Status wether sent to server or not'),
          DataColumn(
              label: Text(
                'Date',
                style: tableHeaderStyle,
              ),
              numeric: false,
              onSort: (i, a) {}),
          DataColumn(
              label: Text(
                'Phone',
                style: tableHeaderStyle,
              ),
              numeric: false,
              onSort: (i, a) {}),
        ],
        rows: tesebakis.map((tesebaki) {
          EtDatetime etD = Utility.toEtc(DateTime.parse(tesebaki.date));
          String date = '${etD.monthGeez} ${etD.day}, ${etD.year}';
          return DataRow(cells: <DataCell>[
            DataCell(Text(Utility.setName(tesebaki.name))),
            DataCell(Text(_checkSent(tesebaki.isSent))),
            DataCell(Text(date)),
            DataCell(Text(Utility.setPhone(tesebaki.phone))),
          ]);
        }).toList());
  }
}
