import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'locale_provider.dart';

/// Bilingual string used in models / mock content.
class L10nText {
  final String en;
  final String hi;

  const L10nText(this.en, [String? hi]) : hi = hi ?? en;

  String resolve(bool isHindi) => isHindi ? hi : en;

  String of(BuildContext context) =>
      resolve(context.watch<LocaleProvider>().isHindi);

  String read(BuildContext context) =>
      resolve(context.read<LocaleProvider>().isHindi);
}
