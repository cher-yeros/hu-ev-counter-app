import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';
import 'package:sampling/models/tesebaki_model.dart';
import 'package:sampling/utils/db_helpers.dart';
import 'package:sampling/utils/util.dart';
import 'package:sampling/widgets/drawer.dart';

import '../home_page.dart';

class AllList extends StatefulWidget {
  @override
  _AllListState createState() => _AllListState();
}

class _AllListState extends State<AllList> {
  List<Tesebaki> tesebakis = List<Tesebaki>();
  int count = 0;
  DBHelper _dbHelper;
  bool sort = true;
  int colI = 0;

  @override
  void initState() {
    super.initState();
    _dbHelper = DBHelper();
    _setListValue();
  }

  _setListValue() async {
    // Database dbfuture = await _dbHelper.initializeDatabase();
    List<Tesebaki> list = await _dbHelper.getTesebakiList();

    setState(() {
      tesebakis = list;
      count = tesebakis.length;
    });
  }

  @override
  void dispose() {
    super.dispose();
    // tesebakis.dispose();
  }

  _checkSent(val) {
    switch (val) {
      case 0:
        return 'Not sent';

      case 1:
        return 'Sent';
    }
  }

  _setName(name) {
    if (name == '') {
      return 'No-name';
    }
    return name;
  }

  _setPhone(phone) {
    if (phone == '') {
      return 'no-phone';
    }
    return phone;
  }

  sortColumn(index, asc) {
    if (index == 1) {
      if (asc) {}
    }
    tesebakis.sort((a, b) {
      return a.name.compareTo(a.name);
    });
  }

  _dataBody() {
    var tableHeaderStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    return DataTable(
      sortColumnIndex: colI,
      sortAscending: sort,
      dividerThickness: 2,
      columnSpacing: 30.0,
      showCheckboxColumn: true,
      columns: [
        DataColumn(
            label: Text(
              'Name',
              style: tableHeaderStyle,
            ),
            numeric: false,
            onSort: (i, a) {
              setState(() {
                sort = !sort;
                colI = i;
              });
              sortColumn(i, a);
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
          DataCell(Text(_setName(tesebaki.name))),
          DataCell(Text(_checkSent(tesebaki.isSent))),
          DataCell(Text(date)),
          DataCell(Text(_setPhone(tesebaki.phone))),
        ]);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _setListValue();

    return Scaffold(
      appBar: AppBar(
        title: Text('All list'),
        actions: <Widget>[
          CircleAvatar(child: Text(count.toString())),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => HomeLanding()));
              // Navigator.pushNamed(context, '/home');
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: _dataBody(),
        // ListView.builder(
        //     itemCount: count,
        //     itemBuilder: (BuildContext ctx, i) {
        //       return Card(
        //         child: ExpansionTile(
        //           key: Key(tesebakis[i].id.toString()),
        //           leading: Icon(Icons.brightness_4),
        //           title: Text('${_setName(tesebakis[i].name)} '),
        //           subtitle: Text('${_checkSent(tesebakis[i].isSent)}'),
        //           children: <Widget>[
        //             Text('Name : ${_setName(tesebakis[i].name)}'),
        //             Text('Gender : ${tesebakis[i].gender}'),
        //             Text('Phone : ${_setPhone(tesebakis[i].phone)}'),
        //           ],
        //         ),
        //       );
        //     }),
      ),
      drawer: Drawer(child: HomeDrawer(context: context)),
    );
  }
}
