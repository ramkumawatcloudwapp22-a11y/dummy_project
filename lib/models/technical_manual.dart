import '../core/l10n/l10n_text.dart';

class TechnicalManual {
  final String id;
  final L10nText title;
  final L10nText description;
  final double fileSizeMb;
  final int pageCount;
  final L10nText date;
  final String author;

  const TechnicalManual({
    required this.id,
    required this.title,
    required this.description,
    required this.fileSizeMb,
    required this.pageCount,
    required this.date,
    this.author = 'Tech Yodha',
  });

  String get fileSizeLabel => '${fileSizeMb.toStringAsFixed(1)} MB';
}
