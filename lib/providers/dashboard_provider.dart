import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';
import '../models/dashboard_models.dart';

class DashboardProvider extends ChangeNotifier {
  final String userName = 'Subedar Arjun Singh';
  final L10nText unit = const L10nText(
    'Unit: 17 Armoured Regiment',
    'यूनिट: 17 आर्मर्ड रेजिमेंट',
  );
  final int notificationCount = 3;

  L10nText get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return const L10nText('Good Morning,', 'सुप्रभात,');
    }
    if (hour < 17) {
      return const L10nText('Good Afternoon,', 'नमस्कार,');
    }
    return const L10nText('Good Evening,', 'शुभ संध्या,');
  }

  final List<StatItem> stats = const [
    StatItem(
      label: L10nText('Manuals', 'मैनुअल'),
      value: '120+',
      icon: Icons.menu_book_outlined,
    ),
    StatItem(
      label: L10nText('Videos', 'वीडियो'),
      value: '85+',
      icon: Icons.videocam_outlined,
    ),
    StatItem(
      label: L10nText('SOPs', 'SOPs'),
      value: '45+',
      icon: Icons.description_outlined,
    ),
    StatItem(
      label: L10nText('Policies', 'नीतियाँ'),
      value: '25+',
      icon: Icons.verified_user_outlined,
    ),
  ];

  final List<TechnicalSection> sections = const [
    TechnicalSection(id: 'a_veh', label: 'A Veh', icon: Icons.directions_car),
    TechnicalSection(id: 'b_veh', label: 'B Veh', icon: Icons.local_shipping),
    TechnicalSection(id: 'c_veh', label: 'C Veh', icon: Icons.agriculture),
    TechnicalSection(id: 'opto', label: 'OPTO', icon: Icons.visibility),
    TechnicalSection(
      id: 'tcm',
      label: 'TCM',
      icon: Icons.settings_input_component,
    ),
    TechnicalSection(id: 'sa', label: 'SA', icon: Icons.gps_fixed),
    TechnicalSection(id: 'gce', label: 'GCE', icon: Icons.construction),
    TechnicalSection(id: 'ror', label: 'ROR', icon: Icons.radar),
    TechnicalSection(id: 'armd', label: 'ARMD', icon: Icons.security),
    TechnicalSection(id: 'nsg', label: 'NSG', icon: Icons.shield),
  ];

  final List<ActivityItem> activities = const [
    ActivityItem(
      title: L10nText(
        'Engine System manual uploaded',
        'इंजन सिस्टम मैनुअल अपलोड हुआ',
      ),
      timeAgo: L10nText('2 min ago', '2 मिनट पहले'),
      icon: Icons.upload_file,
    ),
    ActivityItem(
      title: L10nText(
        'Brake System video viewed',
        'ब्रेक सिस्टम वीडियो देखा गया',
      ),
      timeAgo: L10nText('15 min ago', '15 मिनट पहले'),
      icon: Icons.play_circle_outline,
    ),
    ActivityItem(
      title: L10nText(
        'Fuel System SOP downloaded',
        'फ्यूल सिस्टम SOP डाउनलोड हुआ',
      ),
      timeAgo: L10nText('1 hr ago', '1 घंटे पहले'),
      icon: Icons.download_outlined,
    ),
    ActivityItem(
      title: L10nText(
        'Electrical fault updated',
        'इलेक्ट्रिकल फॉल्ट अपडेट हुआ',
      ),
      timeAgo: L10nText('3 hr ago', '3 घंटे पहले'),
      icon: Icons.warning_amber_outlined,
    ),
  ];

  final double usedStorageGb = 45.6;
  final double totalStorageGb = 100.0;

  double get storagePercent => usedStorageGb / totalStorageGb;

  String get storageLabel =>
      '${usedStorageGb.toStringAsFixed(1)} GB / ${totalStorageGb.toStringAsFixed(0)} GB';

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }
}
