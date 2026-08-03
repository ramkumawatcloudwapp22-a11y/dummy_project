import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';
import '../models/download_item.dart';

class DownloadsProvider extends ChangeNotifier {
  static const L10nText title = L10nText('Downloads', 'डाउनलोड');
  static const L10nText subtitle = L10nText(
    'Access your downloaded resources offline',
    'डाउनलोड संसाधन ऑफ़लाइन देखें',
  );

  DownloadCategory _selectedTab = DownloadCategory.all;
  DownloadCategory get selectedTab => _selectedTab;

  final double usedGb = 2.45;
  final double totalGb = 10.0;

  double get availableGb => totalGb - usedGb;
  double get usedPercent => usedGb / totalGb;

  final List<DownloadItem> _items = const [
    DownloadItem(
      id: 'm1',
      title: L10nText('Engine System Manual', 'इंजन सिस्टम मैनुअल'),
      category: DownloadCategory.manuals,
      sizeOrDuration: '4.8 MB',
      meta: L10nText('120 Pages', '120 पृष्ठ'),
      date: L10nText(
        'Downloaded on 28 Jul 2026',
        '28 जुलाई 2026 को डाउनलोड',
      ),
      leadingIcon: Icons.picture_as_pdf,
      leadingColor: Color(0xFFE53935),
    ),
    DownloadItem(
      id: 'm2',
      title: L10nText('Brake System Manual', 'ब्रेक सिस्टम मैनुअल'),
      category: DownloadCategory.manuals,
      sizeOrDuration: '2.9 MB',
      meta: L10nText('84 Pages', '84 पृष्ठ'),
      date: L10nText(
        'Downloaded on 25 Jul 2026',
        '25 जुलाई 2026 को डाउनलोड',
      ),
      leadingIcon: Icons.picture_as_pdf,
      leadingColor: Color(0xFFE53935),
    ),
    DownloadItem(
      id: 'm3',
      title: L10nText('Fuel System Manual', 'फ्यूल सिस्टम मैनुअल'),
      category: DownloadCategory.manuals,
      sizeOrDuration: '2.4 MB',
      meta: L10nText('72 Pages', '72 पृष्ठ'),
      date: L10nText(
        'Downloaded on 20 Jul 2026',
        '20 जुलाई 2026 को डाउनलोड',
      ),
      leadingIcon: Icons.picture_as_pdf,
      leadingColor: Color(0xFFE53935),
    ),
    DownloadItem(
      id: 'v1',
      title: L10nText(
        'Engine Working Principle',
        'इंजन कार्य सिद्धांत',
      ),
      category: DownloadCategory.videos,
      sizeOrDuration: '18:45',
      meta: L10nText('1080p', '1080p'),
      date: L10nText(
        'Downloaded on 27 Jul 2026',
        '27 जुलाई 2026 को डाउनलोड',
      ),
      isVideo: true,
    ),
    DownloadItem(
      id: 'v2',
      title: L10nText(
        'Transmission Overview',
        'ट्रांसमिशन अवलोकन',
      ),
      category: DownloadCategory.videos,
      sizeOrDuration: '12:10',
      meta: L10nText('1080p', '1080p'),
      date: L10nText(
        'Downloaded on 22 Jul 2026',
        '22 जुलाई 2026 को डाउनलोड',
      ),
      isVideo: true,
    ),
    DownloadItem(
      id: 'v3',
      title: L10nText(
        'Brake Inspection Demo',
        'ब्रेक निरीक्षण डेमो',
      ),
      category: DownloadCategory.videos,
      sizeOrDuration: '09:30',
      meta: L10nText('720p', '720p'),
      date: L10nText(
        'Downloaded on 18 Jul 2026',
        '18 जुलाई 2026 को डाउनलोड',
      ),
      isVideo: true,
    ),
    DownloadItem(
      id: 's1',
      title: L10nText(
        'Engine Inspection SOP',
        'इंजन निरीक्षण SOP',
      ),
      category: DownloadCategory.sops,
      sizeOrDuration: '1.2 MB',
      meta: L10nText('PDF', 'PDF'),
      date: L10nText(
        'Downloaded on 26 Jul 2026',
        '26 जुलाई 2026 को डाउनलोड',
      ),
      leadingIcon: Icons.picture_as_pdf,
      leadingColor: Color(0xFFE53935),
    ),
    DownloadItem(
      id: 's2',
      title: L10nText(
        'Daily Maintenance SOP',
        'दैनिक रखरखाव SOP',
      ),
      category: DownloadCategory.sops,
      sizeOrDuration: '980 KB',
      meta: L10nText('PDF', 'PDF'),
      date: L10nText(
        'Downloaded on 15 Jul 2026',
        '15 जुलाई 2026 को डाउनलोड',
      ),
      leadingIcon: Icons.picture_as_pdf,
      leadingColor: Color(0xFFE53935),
    ),
    DownloadItem(
      id: 'd1',
      title: L10nText(
        'Engine Fault Codes Reference',
        'इंजन फॉल्ट कोड संदर्भ',
      ),
      category: DownloadCategory.documents,
      sizeOrDuration: '1.5 MB',
      meta: L10nText('DOC', 'DOC'),
      date: L10nText(
        'Downloaded on 24 Jul 2026',
        '24 जुलाई 2026 को डाउनलोड',
      ),
      leadingIcon: Icons.description,
      leadingColor: Color(0xFF1E88E5),
    ),
    DownloadItem(
      id: 'd2',
      title: L10nText(
        'ALS Wiring Reference',
        'ALS वायरिंग संदर्भ',
      ),
      category: DownloadCategory.documents,
      sizeOrDuration: '2.1 MB',
      meta: L10nText('DOC', 'DOC'),
      date: L10nText(
        'Downloaded on 12 Jul 2026',
        '12 जुलाई 2026 को डाउनलोड',
      ),
      leadingIcon: Icons.description,
      leadingColor: Color(0xFF1E88E5),
    ),
  ];

  // Display totals matching design (preview shows subset)
  final Map<DownloadCategory, int> categoryTotals = const {
    DownloadCategory.manuals: 32,
    DownloadCategory.videos: 18,
    DownloadCategory.sops: 12,
    DownloadCategory.documents: 25,
  };

  void setTab(DownloadCategory tab) {
    if (_selectedTab == tab) return;
    _selectedTab = tab;
    notifyListeners();
  }

  List<DownloadItem> itemsFor(DownloadCategory category) {
    return _items.where((i) => i.category == category).toList();
  }

  List<DownloadCategory> get visibleSections {
    if (_selectedTab == DownloadCategory.all) {
      return [
        DownloadCategory.manuals,
        DownloadCategory.videos,
        DownloadCategory.sops,
        DownloadCategory.documents,
      ];
    }
    return [_selectedTab];
  }

  L10nText tabLabel(DownloadCategory category) {
    switch (category) {
      case DownloadCategory.all:
        return const L10nText('All Downloads', 'सभी डाउनलोड');
      case DownloadCategory.manuals:
        return const L10nText('Manuals', 'मैनुअल');
      case DownloadCategory.videos:
        return const L10nText('Videos', 'वीडियो');
      case DownloadCategory.sops:
        return const L10nText('SOPs', 'SOPs');
      case DownloadCategory.documents:
        return const L10nText('Documents', 'दस्तावेज़');
    }
  }

  IconData sectionIcon(DownloadCategory category) {
    switch (category) {
      case DownloadCategory.manuals:
        return Icons.menu_book_outlined;
      case DownloadCategory.videos:
        return Icons.play_circle_outline;
      case DownloadCategory.sops:
        return Icons.article_outlined;
      case DownloadCategory.documents:
        return Icons.folder_outlined;
      case DownloadCategory.all:
        return Icons.download_outlined;
    }
  }

  int previewCount(DownloadCategory category) => itemsFor(category).length;

  int remainingCount(DownloadCategory category) {
    final total = categoryTotals[category] ?? 0;
    final shown = previewCount(category);
    return (total - shown).clamp(0, total);
  }
}
