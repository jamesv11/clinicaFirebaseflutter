import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parcialclinicafirebase/src/screens/userPreference/userPreference.dart';

class UserAuth {
  final String _fireBaseToken = 'AIzaSyBKmH6F287GXxZskydqK0sigySMmWvxsD8';

  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'rol': 'admin',
      'returnSecureToken': true
    };

    final resp = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_fireBaseToken'),
        body: json.encode(authData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      _prefs.token = decodeResp['idToken'];
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'message': decodeResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> newAdmin(String email, String password) async {
    final authData = {
      'email': email,
      'rol': 'admin',
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_fireBaseToken'),
        body: json.encode(authData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      _prefs.token = decodeResp['idToken'];
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'message': decodeResp['error']['message']};
    }
  }
}
