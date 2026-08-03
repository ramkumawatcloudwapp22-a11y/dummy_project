import 'package:flutter/material.dart';
import '../core/l10n/app_localizations.dart';

class AuthProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final armyNumberController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  bool get obscurePassword => _obscurePassword;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  bool validate(AppLocalizations l10n) {
    if (emailController.text.trim().isEmpty) {
      _errorMessage = l10n.pleaseEnterEmail;
      notifyListeners();
      return false;
    }
    if (armyNumberController.text.trim().isEmpty) {
      _errorMessage = l10n.pleaseEnterArmyNumber;
      notifyListeners();
      return false;
    }
    if (passwordController.text.length < 8) {
      _errorMessage = l10n.passwordMin8;
      notifyListeners();
      return false;
    }
    _errorMessage = null;
    notifyListeners();
    return true;
  }

  Future<bool> login(AppLocalizations l10n) async {
    if (!validate(l10n)) return false;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Simulated auth delay
    await Future.delayed(const Duration(milliseconds: 1200));

    _isLoading = false;
    notifyListeners();
    return true;
  }

  @override
  void dispose() {
    emailController.dispose();
    armyNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
