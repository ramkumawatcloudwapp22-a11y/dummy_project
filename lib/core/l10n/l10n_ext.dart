import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'app_localizations.dart';
import 'locale_provider.dart';

extension L10nContext on BuildContext {
  LocaleProvider get localeProvider => watch<LocaleProvider>();
  LocaleProvider get localeReader => read<LocaleProvider>();
  AppLocalizations get l10n => watch<LocaleProvider>().l10n;
  AppLocalizations get l10nRead => read<LocaleProvider>().l10n;
  bool get isHindi => watch<LocaleProvider>().isHindi;

  String tr(String en, String hi) => watch<LocaleProvider>().t(en, hi);
}
