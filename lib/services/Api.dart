// ignore_for_file: file_names
// import 'package:pretty_json/pretty_json.dart';
import 'dart:convert';

import '../constants/url.dart' show Url;
import 'package:http/http.dart' as http;
import '../model/response_acceptance.dart';
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
  Future<Response_acceptance?> acceptance_get() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    final res = await http.get(
        Uri.parse(Url.ACCEPTANCE_PROJECT_GET),
        headers: {'x-access-token': jwt!});
    if (res.statusCode == 200) return Response_acceptance.fromJson(jsonDecode(res.body));
    // else return null;

  }


}
String prettyJson(dynamic json) {
  var spaces = ' ' * 4;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}