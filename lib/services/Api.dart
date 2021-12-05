// ignore_for_file: file_names, non_constant_identifier_names, avoid_print
// import 'package:pretty_json/pretty_json.dart';
import 'dart:convert';

import 'package:dpkmobileflutter/model/document_response.dart';
import 'package:dpkmobileflutter/model/smu.dart';
import 'package:dpkmobileflutter/model/sugest_agen.dart';
import 'package:dpkmobileflutter/model/sugest_barang.dart';
import 'package:dpkmobileflutter/model/sugest_smu.dart';

import '../constants/url.dart' show Url;
import 'package:http/http.dart' as http;
import '../model/response_acceptance.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const storage = FlutterSecureStorage();

class Api {
  Future<String?> login(String username, String password) async {
    var res = await http.post(Uri.parse(Url.LOGIN),
        body: {"username": username, "password": password});
    // print(res.body);
    if (res.statusCode == 200) return res.body;
    return null;
  }

  Future<Response_acceptance?> acceptance_get() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    final res = await http.get(Uri.parse(Url.CHECKER_SMU_PROJECT),
        headers: {'x-access-token': jwt!});
    if (res.statusCode == 200)
      return Response_acceptance.fromJson(jsonDecode(res.body));
    else return null;
  }

  Future<List<Smu>> getSmuAcceptance(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    var res = await http.get(Uri.parse(Url.ACCEPTANCE_SMU_LIST + '/' + id),
        headers: {'x-access-token': jwt!});
    // print(res.body);
    if (res.statusCode == 200) return smuFromJson(res.body);
    return [];
  }

  Future<List<SuggestSmu>> getSuggestSmu(noSmu) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    var res = await http.post(Uri.parse(Url.ACCEPTANCE_SUGGEST_SMU),
        body: {"no_smu": noSmu}, headers: {'x-access-token': jwt!});
    // print(res.body);
    if (res.statusCode == 200) return suggestFromJson(res.body);
    return [];
  }

  Future<List<SuggestAgen>> getSuggestAgen(customer) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    var res = await http.post(Uri.parse(Url.ACCEPTANCE_SUGGEST_CUSTOMER),
        body: {"customer": customer}, headers: {'x-access-token': jwt!});
    // print(res.body);
    if (res.statusCode == 200) return suggesAgenFromJson(res.body);
    return [];
  }

  Future<List<SuggestBarang>> getSuggestBarang(namaBarang) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    var res = await http.post(Uri.parse(Url.ACCEPTANCE_SUGGEST_BARANG),
        body: {"nama_barang": namaBarang}, headers: {'x-access-token': jwt!});
    // print(res.body);
    if (res.statusCode == 200) return suggestFromJsonBarang(res.body);
    return [];
  }

  Future<Smu?> detaiSmuSuggest(smu) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    var res = await http.post(Uri.parse(Url.ACCEPTANCE_DETAIL_SMU_SUGGEST),
        body: {"smu": smu}, headers: {'x-access-token': jwt!});
    if (res.statusCode == 200) return Smu.fromJson(json.decode(res.body));
    return null;
  }

  Future<SuggestAgen?> detaiAgen(namaAgen) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    var res = await http.post(Uri.parse(Url.ACCEPTANCE_DETAIL_AGEN),
        body: {"nama_agen": namaAgen}, headers: {'x-access-token': jwt!});
    if (res.statusCode == 200)
      return SuggestAgen.fromJson(json.decode(res.body));
    return null;
  }

  Future<bool> createSmu(formdata) async {
    // print(formdata);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    var res = await http.post(Uri.parse(Url.ACCEPTANCE_SMU_CREATE),
        body: formdata, headers: {'x-access-token': jwt!});
    if (res.statusCode == 200) return true;
    return false;
  }

  Future<bool> selesaiSmuAcceptence(id) async {
    // print(formdata);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    var res = await http.get(Uri.parse(Url.ACCEPTANCE_SMU_SELESAI + "/${id}"),
        headers: {'x-access-token': jwt!});
    print(res.body);
    if (res.statusCode == 200) return true;
    return false;
  }
  Future<List<Smu?>> updateSmuChecker(id) async {
    // print(formdata);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    var res = await http.get(Uri.parse(Url.CHECKER_SMU_UPDATE + "/${id}"),
        headers: {'x-access-token': jwt!});
    print(res.body);
    if (res.statusCode == 200) return smuFromJson(res.body);
    return [];
  }
  Future<Response_acceptance?> checker_project() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    final res = await http.get(Uri.parse(Url.CHECKER_SMU_PROJECT),
        headers: {'x-access-token': jwt!});

    if (res.statusCode == 200) return Response_acceptance.fromJson(jsonDecode(res.body));
    return null;
  }
  Future<List<Smu>> checkerSmu(id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    final response = await http.get(
        Uri.parse("${Url.CHECKER_SMU_LIST}/${id.toString()}"),
        headers: {'x-access-token': jwt!});
    // print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // final parsed = json.
      return smuFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return [];
    }
  }

  Future<DocumentResponse?> documentDetail(id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    final response = await http.get(
        Uri.parse("${Url.DOCUMENT_CHECKER_DETAIL}/${id.toString()}"),
        headers: {'x-access-token': jwt!});

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // final parsed = json.
      return DocumentResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return null;
    }
  }
  Future<List<Smu>> documentSmuDetail(id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwt = preferences.getString('jwt');
    final response = await http.get(
        Uri.parse("${Url.DOCUMENT_SMU_DETAIL}/${id.toString()}"),
        headers: {'x-access-token': jwt!});
    print( response.body);
    if (response.statusCode == 200) return smuFromJson(response.body);
    return [];
  }
}

String prettyJson(dynamic json) {
  var spaces = ' ' * 4;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}
