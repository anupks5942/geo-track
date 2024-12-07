import 'package:geo_track/services/functions/auth_service.dart';
import 'package:flutter/material.dart';

class AuthDataProvider extends ChangeNotifier {
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  AuthService authService = AuthService();

  setBusy() {
    _isBusy = true;
    notifyListeners();
  }

  setFree() {
    _isBusy = false;
    notifyListeners();
  }
}
