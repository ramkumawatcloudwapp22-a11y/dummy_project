import 'package:flutter/material.dart';
import 'app_localizations.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  bool get isHindi => _locale.languageCode == 'hi';
  AppLocalizations get l10n => AppLocalizations(isHindi);

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void toggle() {
    _locale = isHindi ? const Locale('en') : const Locale('hi');
    notifyListeners();
  }

  /// Pick English or Hindi string based on current locale.
  String t(String en, String hi) => isHindi ? hi : en;
}
