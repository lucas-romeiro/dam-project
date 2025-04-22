import 'package:flutter/material.dart';

class InputController extends ChangeNotifier {
  // Visibilidade de senha
  bool _isPasswordVisible = true;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // --------- VALIDATORS ---------- //

  // Validador para campos obrigatórios (como Nome)
  FormFieldValidator<String> validatorRequired(String label) {
    return (value) =>
        value == null || value.trim().isEmpty ? '$label is required' : null;
  }

  // Validador de email
  FormFieldValidator<String> validatorEmail() {
    return (value) {
      if (value == null || value.isEmpty) return 'Email is required';
      final regex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
      );
      if (!regex.hasMatch(value)) return 'Enter a valid email';
      return null;
    };
  }

  // Validador de senha
  FormFieldValidator<String> validatorPassword({int minLength = 6}) {
    return (value) {
      if (value == null || value.isEmpty) return 'Enter a password';
      if (value.length < minLength) return 'Minimum $minLength characters';
      return null;
    };
  }

  // Confirmação de senha
  FormFieldValidator<String> validatorConfirmPassword(
    TextEditingController original,
  ) {
    return (value) {
      if (value == null || value.isEmpty) return 'Confirm your password';
      if (value != original.text) return 'Passwords do not match';
      return null;
    };
  }

  // --------- UTILIDADES ---------- //

  void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(behavior: SnackBarBehavior.floating, content: Text(message)),
    );
  }

  void clearFields(List<TextEditingController> controllers) {
    for (var c in controllers) {
      c.clear();
    }
  }
}
