import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:upb_app/class/labor_social.dart';
import 'dart:io';
import 'package:upb_app/class/global.dart' as globals;


class ApiClient {

  static String urlApi = globals.urlApi;
  static String logeo = globals.logeo;
  static String urlLabor = globals.urlLabor;
  static Future<Map> loginRequest (String email, String password) async {
    var url = urlApi+logeo;
    final response = await http.post(url,
        body: jsonEncode({'email': email, 'password': password }),
        headers: { "Content-Type": "application/json", });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if( response.statusCode == 200 )
      return jsonDecode(response.body);
    else
      return null;

  }

  static Future<Map> LaborRequest () async {
    var url = urlApi+urlLabor;
    final response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader:"Bearer " + globals.token, "Content-Type": "application/json"});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final res = jsonDecode(response.body);
    List<LaborSocial> lstL = new List<LaborSocial>();
    List<dynamic> ls = res["message"];
    for(var obj in ls){
      LaborSocial l = new LaborSocial(obj["id"], obj["usuario"], obj["horas"], obj["documento"], obj["idUniversitario"], obj["nombreUsuario"]);
      lstL.add(l);
    }
    if( response.statusCode == 200 )
      return  jsonDecode(response.body);
    else
      return null;
  }

}