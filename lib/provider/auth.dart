import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Utils/httpEx.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _time;
  String _userId;

  bool get isIn {
    return _token != null;
  }

  String get users {
    return _userId;
  }

  String get token {
    if (_time != null && _time.isAfter(DateTime.now()) && _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> singup(String email, String password) async {
    try {
      final url =
          "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAsuI4OjNyKsjN2a5NX6pXe9IOtjWsLn_c";

      final response = await http.post(
        Uri.parse(url),
        // headers: map,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final resposeData = (json.decode(response.body));
      if (resposeData["error"] != null) {
        throw HttpExc(resposeData["error"]["message"]);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> singin(String email, String password) async {
    try {
      final url =
          "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAsuI4OjNyKsjN2a5NX6pXe9IOtjWsLn_c";

      final response = await http.post(
        Uri.parse(url),
        //  headers: map,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final resposeData = (json.decode(response.body));
      if (resposeData["error"] != null) {
        throw HttpExc(resposeData["error"]["message"]);
      }
      _token = resposeData["idToken"];
      print(resposeData["idToken"]);
      _userId = resposeData["localId"];
      _time = DateTime.now().add(
        Duration(
          seconds: int.parse(
            resposeData["expiresIn"],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
