import 'dart:async';
import 'dart:convert';

import 'package:flutter_ecommerce/models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiringDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiringDate != null &&
        _expiringDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }



  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCAHsAS0R8-Hsw9r8VATQ91R-aEP5r96Ns';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiringDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  void logout() {
    _userId = null;
    _token = null;
    _expiringDate = null;
    if(_authTimer!=null){
      _authTimer.cancel();
      _authTimer=null;
    }
    notifyListeners();
  }

  void _autoLogout() {
    if(_authTimer!=null){
      _authTimer.cancel();
    }
    final timeToExpiry = _expiringDate.difference(DateTime.now()).inSeconds;
    _authTimer= Timer(
      Duration(seconds: timeToExpiry),
      logout,
    );
  }
}
