import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiringDate;
  String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCAHsAS0R8-Hsw9r8VATQ91R-aEP5r96Ns';

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
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
   return _authenticate(email, password, 'signInWithPassword');
  }
}
