// import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  // String baseUrl = 'http://192.168.43.123:8000/api/';
  String baseUrl = 'https://58f48306236a.ngrok.io/api/';

  login(data) async {
    http.Response response = await http.post(baseUrl + 'login-sebaki',
        body: jsonEncode(data), headers: _setHeaders());

    var res = jsonDecode(response.body);

    if (res['success']) {
      _registerToLocalStorage(res);
    } else {
      print('won\'t be logged in');
    }

    return res;
  }

  _registerToLocalStorage(res) async {
    var lS = await SharedPreferences.getInstance();

    lS.setBool('logged_in', true);
    lS.setInt('id', res['sebaki']['id']);
    lS.setString('name', res['sebaki']['name']);
    lS.setString('phone', res['sebaki']['phone']);
    lS.setString('username', res['sebaki']['username']);
    lS.setString('campusName', res['sebaki']['campus']['name']);
    lS.setString('campusSlug', res['sebaki']['campus']['slug']);
    lS.setInt('campusId', res['sebaki']['campus']['id']);
    lS.setBool('approved', _approved(res['sebaki']['approved']));
  }

  _approved(no) {
    return no == 1 ? true : false;
  }

  signUp(data) async {
    http.Response response = await http.post(baseUrl + 'register-sebaki',
        body: jsonEncode(data), headers: _setHeaders());

    var res = jsonDecode(response.body);

    if (res['success'] != null) {
      _registerToLocalStorage(res);
    } else {
      return res;
    }
  }

  checkForEvangeWeek() async {
    String endpoint = baseUrl + 'evange';

    http.Response response = await http.get(endpoint, headers: _setHeaders());

    var res = jsonDecode(response.body);

    // print(res);
    return res;
  }

  refreshAccount() async {
    var lS = await SharedPreferences.getInstance();
    String endpoint = baseUrl + 'refresh-me/' + lS.getInt('id').toString();

    http.Response response = await http.get(endpoint, headers: _setHeaders());
    var res = jsonDecode(response.body);
    _registerToLocalStorage(res);
    // var data = {
    //   'username': lS.getString('username'),
    //   'password': lS.getString('password')
    // };
  }

  addTesebaki(data) async {
    http.Response response = await http.post(baseUrl + 'add-tesebaki',
        body: jsonEncode(data), headers: _setHeaders());

    var res = jsonDecode(response.body);

    // print(res);
    return res;
  }

  AddYesema(data) async {
    http.Response response = await http.post(baseUrl + 'add-yesema',
        body: jsonEncode(data), headers: _setHeaders());

    var res = jsonDecode(response.body);

    return res;
  }

  _setHeaders() =>
      {'content-type': 'application/json', 'Accept': 'application/json'};
}
