import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthException implements Exception {
  final String message;

  AuthException([this.message]);

  @override
  String toString() => this.message;
}

class Auth with ChangeNotifier {
  static const _API_KEY = "AIzaSyAkR6XYADIhFyeYfIIVT9nxGmLqh8ep3TM";
  static const BASE_URL = "https://identitytoolkit.googleapis.com/v1/accounts";

  static const LOGIN_URL =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_API_KEY";

  String _token;
  DateTime _expireDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth => token != null;

  String get userId => _userId;

  String get token {
    if (_expireDate != null &&
        _expireDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String method) async {
    final url = Uri.parse('$BASE_URL:$method?key=$_API_KEY');
    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
    if (jsonResponse['error'] != null) {
      throw AuthException(jsonResponse['error']['message']);
    }

    if (response.statusCode >= 400) return Future.error('Error during signup');

    _token = jsonResponse['idToken'];
    _userId = jsonResponse['localId'];
    _expireDate = DateTime.now()
        .add(Duration(seconds: int.parse(jsonResponse['expiresIn'])));
    _storeCredentials();
    _autoLogout();
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expireDate = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) _authTimer.cancel();

    final timeToExpire = _expireDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer.periodic(Duration(seconds: timeToExpire), (timer) {
      timer.cancel();
      logout();
    });
  }

  Future<bool> tryAutoLogin() async {
    return _loadCrendentials();
  }

  Future<bool> _storeCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(
      'credentials',
      json.encode({
        'token': _token,
        'userId': _userId,
        'expireDate': _expireDate.toIso8601String(),
      }),
    );
  }

  Future<bool> _loadCrendentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('credentials')) {
      final credentials = json.decode(prefs.getString('credentials'));
      final expireDate = DateTime.parse(credentials['expireDate']);

      if (expireDate.isAfter(DateTime.now())) {
        _token = credentials['token'];
        _userId = credentials['userId'];
        _expireDate = expireDate;
        notifyListeners();
      }
    }
    return false;
  }
}
