import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';

class ProfileMenuItem {
  final String id;
  final L10nText title;
  final L10nText? subtitle;
  final IconData icon;

  const ProfileMenuItem({
    required this.id,
    required this.title,
    required this.icon,
    this.subtitle,
  });
}

class ProfileProvider extends ChangeNotifier {
  final String name = 'Subedar Arjun Singh';
  final String rank = 'Subedar';
  final String armyNumber = 'IC-78421';
  final String email = 'arjun.singh@army.in';
  final L10nText unit = const L10nText(
    '17 Armoured Regiment',
    '17 आर्मर्ड रेजिमेंट',
  );
  final L10nText trade = const L10nText(
    'Vehicle Mechanic (B Veh)',
    'वाहन मैकेनिक (B Veh)',
  );
  final String station = 'Jaisalmer Cantt';

  final int manualsViewed = 48;
  final int videosWatched = 22;
  final int downloadsCount = 35;
  final int bookmarksCount = 12;

  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  final List<ProfileMenuItem> menuItems = const [
    ProfileMenuItem(
      id: 'edit',
      title: L10nText('Edit Profile', 'प्रोफ़ाइल संपादित करें'),
      subtitle: L10nText(
        'Update personal details',
        'व्यक्तिगत विवरण अपडेट करें',
      ),
      icon: Icons.edit_outlined,
    ),
    ProfileMenuItem(
      id: 'bookmarks',
      title: L10nText('My Bookmarks', 'मेरे बुकमार्क'),
      subtitle: L10nText(
        'Saved parts, manuals & faults',
        'सहेजे पार्ट्स, मैनुअल और फॉल्ट्स',
      ),
      icon: Icons.bookmark_outline,
    ),
    ProfileMenuItem(
      id: 'progress',
      title: L10nText('Training Progress', 'प्रशिक्षण प्रगति'),
      subtitle: L10nText(
        'Modules completed & scores',
        'पूर्ण मॉड्यूल और स्कोर',
      ),
      icon: Icons.insights_outlined,
    ),
    ProfileMenuItem(
      id: 'security',
      title: L10nText('Security & Privacy', 'सुरक्षा और गोपनीयता'),
      subtitle: L10nText(
        'Password and access controls',
        'पासवर्ड और पहुँच नियंत्रण',
      ),
      icon: Icons.shield_outlined,
    ),
    ProfileMenuItem(
      id: 'help',
      title: L10nText('Help & Support', 'सहायता और समर्थन'),
      subtitle: L10nText(
        'FAQs and contact support',
        'अक्सर पूछे जाने वाले प्रश्न और संपर्क',
      ),
      icon: Icons.help_outline,
    ),
    ProfileMenuItem(
      id: 'about',
      title: L10nText('About Tech Yodha', 'टेक योद्धा के बारे में'),
      subtitle: L10nText('Version 1.0.0', 'संस्करण 1.0.0'),
      icon: Icons.info_outline,
    ),
  ];

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }
}
