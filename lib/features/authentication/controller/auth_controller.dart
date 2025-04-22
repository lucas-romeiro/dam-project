import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dam_project/features/authentication/data/auth_reposity.dart';
import 'package:dam_project/features/authentication/model/user_model.dart';
import 'package:dam_project/features/authentication/screen/login_screen.dart';

class AuthController extends ChangeNotifier {
  final AuthReposity _authRepository = AuthReposity();

  late SharedPreferences storage;

  // Form controllers
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final confirmPassword = TextEditingController();
  final diet = TextEditingController(text: 'None');
  final calories = ValueNotifier<int>(2000);

  // Estado geral
  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;
  bool _isChecked = false;
  bool get isChecked => _isChecked;
  bool isUserExist = false;
  User? _loggedUser;
  User? get loggedUser => _loggedUser;
  bool get isLoggedIn => _loggedUser != null;
  bool isInitialized = false;

  // Init SharedPreferences
  Future<void> initStorage() async {
    storage = await SharedPreferences.getInstance();
    _rememberMe = storage.getBool("rememberMe") ?? false;

    if (_rememberMe && storage.containsKey("user")) {
      String? userJson = storage.getString("user");
      if (userJson != null) {
        _loggedUser = User.fromJson(jsonDecode(userJson));
      }
    }

    isInitialized = true;
    notifyListeners();
  }

  // Alternar "Lembrar-me"
  void setRememberMe() {
    _rememberMe = true;
    storage.setBool("rememberMe", _rememberMe);
    notifyListeners();
  }

  void toogleChecked() {
    _isChecked = !_isChecked;
    notifyListeners();
  }

  // Salvar usuário no SharedPreferences
  Future<void> _saveUser() async {
    if (_rememberMe && _loggedUser != null) {
      await storage.setString("user", jsonEncode(_loggedUser!.toJson()));
    }
  }

  // LOGIN
  Future<bool> login(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return false;

    final user = await _authRepository.getUser(email.text);

    if (user != null) {
      _loggedUser = user;
      await _saveUser();
      return true;
    }

    return false;
  }

  // REGISTRO
  Future<bool> register(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return false;

    if (password.text != confirmPassword.text) {
      return false;
    }

    final exists = await _authRepository.emailExists(email.text);
    if (exists) {
      isUserExist = true;
      notifyListeners();
      return false;
    }

    final user = User(
      fullName: fullName.text,
      email: email.text,
      diet: diet.text,
      calories: calories.value,
      password: password.text,
    );

    final wasCreated = await _authRepository.createUser(user) > 0;

    if (wasCreated) {
      _loggedUser = user;
      await _saveUser();
      return true;
    }

    return false;
  }

  // LOGOUT
  void logout(BuildContext context) async {
    _rememberMe = false;
    _loggedUser = null;
    await storage.setBool("rememberMe", false);
    await storage.remove("user");

    notifyListeners();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  /// Limpa os campos (opcional)
  void clearForm() {
    fullName.clear();
    email.clear();
    password.clear();
    confirmPassword.clear();
    diet.text = 'None';
    calories.value = 2000;
    isUserExist = false;
    notifyListeners();
  }
}
