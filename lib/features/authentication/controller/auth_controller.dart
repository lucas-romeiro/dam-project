import 'package:dam_project/features/authentication/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  bool _isChecked = false;
  bool get isChecked => _isChecked;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  bool isInitialized = false;

  late SharedPreferences storage;

  // Alternar o checkbox "lembrar-me"
  void toogleCheck() {
    _isChecked = !_isChecked;
    notifyListeners();
  }

  // Quando faz login e escolhe lembrar
  void setRememberMe() {
    _rememberMe = true;
    storage.setBool("rememberMe", _rememberMe);
    notifyListeners();
  }

  // Quando faz logout
  void logout(context) {
    _rememberMe = false;
    storage.setBool("rememberMe", _rememberMe);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    notifyListeners();
  }

  // Inicializar SharedPreferences e carregar o rememberMe
  Future<void> initStorage() async {
    storage = await SharedPreferences.getInstance();
    _rememberMe = storage.getBool("rememberMe") ?? false;
    isInitialized = true;
    notifyListeners();
  }
}
