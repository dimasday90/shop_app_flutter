import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//* utils
import '../util/apis/api_request.dart';
import '../util/constants/enum.dart';

//* models
import '../models/custom_http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  //* getters
  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, AuthMode authMode) async {
    try {
      http.Response response;
      if (authMode == AuthMode.login) {
        response = await APIRequest.login(email, password);
      } else {
        response = await APIRequest.signUp(email, password);
      }
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw CustomHttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        "userId": _userId,
        "expiryDate": _expiryDate.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    await _authenticate(email, password, AuthMode.signup);
    // final response = await _authenticate(email, password, AuthMode.signup);
    // final extractedData = json.decode(response.body);
  }

  Future<void> login(String email, String password) async {
    await _authenticate(email, password, AuthMode.login);
    // final response = await _authenticate(email, password, AuthMode.login);
    // final extractedData = json.decode(response.body);
  }

  Future<bool> autoLoginCheck() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedData['token'];
    _userId = extractedData['userId'];
    _expiryDate = expiryDate;
    autoLogout();
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
