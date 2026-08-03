import 'package:flutter/material.dart';
import '../core/l10n/app_localizations.dart';

enum UserCategory { agniveer, jco, officers }

class SignupProvider extends ChangeNotifier {
  final armyNumberController = TextEditingController();
  final fullNameController = TextEditingController();
  final dobController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  UserCategory _category = UserCategory.agniveer;
  bool _obscurePassword = true;
  bool _agreedToTerms = false;
  bool _isLoading = false;
  String? _errorMessage;
  DateTime? _dateOfBirth;

  UserCategory get category => _category;
  bool get obscurePassword => _obscurePassword;
  bool get agreedToTerms => _agreedToTerms;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  DateTime? get dateOfBirth => _dateOfBirth;

  String get armyNumberHint {
    switch (_category) {
      case UserCategory.agniveer:
        return 'e.g. A5603686K';
      case UserCategory.jco:
        return 'e.g. JC-561278';
      case UserCategory.officers:
        return 'e.g. IC-24573';
    }
  }

  String get categoryFormatExample {
    switch (_category) {
      case UserCategory.agniveer:
        return 'A5603686K';
      case UserCategory.jco:
        return 'JC-561278';
      case UserCategory.officers:
        return 'IC-24573';
    }
  }

  void setCategory(UserCategory value) {
    _category = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void setAgreedToTerms(bool value) {
    _agreedToTerms = value;
    notifyListeners();
  }

  void setDateOfBirth(DateTime date) {
    _dateOfBirth = date;
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    final y = date.year.toString();
    dobController.text = '$d/$m/$y';
    notifyListeners();
  }

  bool validate(AppLocalizations l10n) {
    if (armyNumberController.text.trim().isEmpty) {
      _errorMessage = l10n.pleaseEnterArmyNumberSignup;
      notifyListeners();
      return false;
    }
    if (fullNameController.text.trim().isEmpty) {
      _errorMessage = l10n.pleaseEnterFullName;
      notifyListeners();
      return false;
    }
    if (dobController.text.trim().isEmpty) {
      _errorMessage = l10n.pleaseSelectDob;
      notifyListeners();
      return false;
    }
    if (mobileController.text.trim().length < 10) {
      _errorMessage = l10n.pleaseEnterValidMobile;
      notifyListeners();
      return false;
    }
    if (emailController.text.trim().isEmpty ||
        !emailController.text.contains('@')) {
      _errorMessage = l10n.pleaseEnterValidEmail;
      notifyListeners();
      return false;
    }
    if (passwordController.text.length < 8) {
      _errorMessage = l10n.passwordMin8Long;
      notifyListeners();
      return false;
    }
    if (!_agreedToTerms) {
      _errorMessage = l10n.pleaseAgreeTerms;
      notifyListeners();
      return false;
    }
    _errorMessage = null;
    notifyListeners();
    return true;
  }

  Future<bool> createAccount(AppLocalizations l10n) async {
    if (!validate(l10n)) return false;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1400));

    _isLoading = false;
    notifyListeners();
    return true;
  }

  @override
  void dispose() {
    armyNumberController.dispose();
    fullNameController.dispose();
    dobController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
