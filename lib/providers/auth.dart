import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class Auth with ChangeNotifier {
  String _token = '';
  String _userId = '';
  DateTime _expireDate = DateTime(1970);
  Timer authTimer = Timer(const Duration(seconds: 0), () {});

  bool get isAuth {
    //print(token);
    return token != null;
  }

  String? get token {
    // print(_token);
    if (_expireDate != null &&
        _expireDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> signup(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCji4k5XGF9LEl7d_kFeu6e4ei0kdteCFs';
    //try {
    try {
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final resData = json.decode(res.body);
      if (resData['error'] != null) {
        throw HttpException(resData['error']['message']);
      }
      _token = resData['idToken'];
      _userId = resData['localId'];
      _expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(resData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCji4k5XGF9LEl7d_kFeu6e4ei0kdteCFs';
    try {
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final resData = json.decode(res.body);
      if (resData['error'] != null) {
        throw HttpException(resData['error']['message']);
      }

      _token = resData['idToken'];
      _userId = resData['localId'];
      _expireDate = DateTime.now()
          .add(Duration(seconds: int.parse(resData['expiresIn'])));
      _autologout();
      notifyListeners();
      //step 1 arrive to shared prefs
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expireDate': _expireDate.toIso8601String()
      }); //for complex data
      //print(userData);
      prefs.setString('userData', userData); //to write read data
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expireDate =
        DateTime.parse(extractedUserData['expireDate'].toString());
    if (expireDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'].toString();
    _userId = extractedUserData['userId'].toString();
    _expireDate = expireDate;
    notifyListeners();
    _autologout();
    return true;
  }

  Future<void> logout() async {
    _token = '';
    _expireDate = DateTime(1970);
    _userId = '';
    if (authTimer != Timer(const Duration(seconds: 0), () {})) {
      authTimer.cancel();
      authTimer = Timer(const Duration(seconds: 0), () {});
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autologout() {
    if (authTimer != Timer(const Duration(seconds: 0), () {})) {
      authTimer.cancel();
    }
    final timeToExpire = _expireDate.difference(DateTime.now()).inSeconds;
    //print(timeToExpire);
    authTimer = Timer(Duration(seconds: timeToExpire), logout);
  }
}
