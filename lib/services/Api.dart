// ignore_for_file: file_names
// import 'package:pretty_json/pretty_json.dart';
import 'dart:convert';

import '../constants/url.dart' show Url;
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

// const storage = FlutterSecureStorage();

class Api {
  Future<String?> login(String username, String password) async {
    var res = await http.post(Uri.parse(Url.LOGIN),
        body: {"username": username, "password": password});
    print(res.body);
    if (res.statusCode == 200) return res.body;
    return null;
  }


}
String prettyJson(dynamic json) {
  var spaces = ' ' * 4;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}