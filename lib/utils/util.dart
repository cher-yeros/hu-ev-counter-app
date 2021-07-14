import 'package:flutter/services.dart';
import 'package:abushakir/abushakir.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sampling/models/tesebaki_model.dart';
import 'package:sampling/models/yesema_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'call_api.dart';
import 'db_helpers.dart';

class Utility {
  static const MethodChannel channel = MethodChannel('evange.counter');

  static makeToast(String text) async {
    var arg = Map();

    arg = {'text': text};

    try {
      await channel.invokeMethod('makeToast', arg);
    } catch (e) {
      print('something goes wrong');
    }
  }

  static flutterToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static checkSent(val) {
    switch (val) {
      case 0:
        return 'Not sent';

      case 1:
        return 'Sent';
    }
  }

  static setName(name) {
    if (name == '') {
      return 'No-name';
    }
    return name;
  }

  static setPhone(phone) {
    if (phone == '') {
      return 'no-phone';
    }
    return phone;
  }

  static EtDatetime toEtc(gregDate) {
    int epoch = gregDate.millisecondsSinceEpoch;
    EtDatetime etDate = EtDatetime.fromMillisecondsSinceEpoch(epoch);
    return etDate;
  }

  static Future<bool> checkConnection() async {
    var response;
    try {
      response = await http.get("https://www.google.com");
      return true;
    } catch (e) {
      return false;
    }

    if (response.statusCode == 200) {
      return true;
      // if (response.body != null) {
      //   return true;
      // }
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
    // print(response.body);

    return false;
  }

  static exportOfflineData() async {
    var _dbHelper = DBHelper();
    if (!await Utility.checkConnection()) {
      return;
    }
    List<Tesebaki> tesebakis = await _dbHelper.getUnSentTesebakisList();
    List<Yesema> yesemus = await _dbHelper.getUnsentYesemuList();
    var resSqlite, resApi;

    if (tesebakis.length > 0) {
      tesebakis.forEach((tesebaki) async {
        tesebaki.setIsSent(1);
        resSqlite = await _dbHelper.updateStatus(tesebaki);
        resApi = await CallApi().addTesebaki(tesebaki.toBeSent());
      });
    }

    print(yesemus.length);

    if (yesemus.length > 0) {
      yesemus.forEach((yesema) async {
        var data = {
          'campusId': yesema.campusId,
          'sebakiId': yesema.sebakiId,
          'number': yesema.number
        };

        yesema.setIsSent(1);
        resApi = await new CallApi().AddYesema(data);
      });

      int yesemu = await _dbHelper.removeAllYesemu();

      await Utility.flutterToast('yesemu List Exported Successfully!');
    }

    // print('Result Sqlite : $resSqlite');

    // await Utility.flutterToast('List Exported Successfully!');
  }
}
