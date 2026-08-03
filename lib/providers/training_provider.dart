import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';
import '../models/training_models.dart';

class TrainingProvider extends ChangeNotifier {
  static const L10nText title = L10nText(
    'Training Center',
    'प्रशिक्षण केंद्र',
  );
  static const L10nText subtitle = L10nText(
    'Learn, Practice & Master',
    'सीखें, अभ्यास करें और निपुण बनें',
  );
  static const L10nText welcomeTitle = L10nText(
    'Welcome to Training Center',
    'प्रशिक्षण केंद्र में आपका स्वागत है',
  );
  static const L10nText welcomeBody = L10nText(
    'Access technical manuals, SOPs, training videos and policies to strengthen your knowledge and field readiness.',
    'अपने ज्ञान और फील्ड रेडीनेस को मजबूत करने के लिए तकनीकी मैनुअल, SOP, प्रशिक्षण वीडियो और नीतियाँ देखें।',
  );

  final List<TrainingCategory> categories = const [
    TrainingCategory(
      id: 'manuals',
      title: L10nText('Technical Manuals', 'तकनीकी मैनुअल'),
      description: L10nText(
        'Official system & component documentation',
        'आधिकारिक सिस्टम और घटक दस्तावेज़',
      ),
      icon: Icons.menu_book_outlined,
    ),
    TrainingCategory(
      id: 'sops',
      title: L10nText('SOP Documents', 'SOP दस्तावेज़'),
      description: L10nText(
        'Standard operating procedures',
        'मानक संचालन प्रक्रियाएँ',
      ),
      icon: Icons.description_outlined,
    ),
    TrainingCategory(
      id: 'videos',
      title: L10nText('Training Videos', 'प्रशिक्षण वीडियो'),
      description: L10nText(
        'Visual guides and walkthroughs',
        'दृश्य गाइड और वॉकथ्रू',
      ),
      icon: Icons.play_circle_outline,
    ),
    TrainingCategory(
      id: 'policies',
      title: L10nText('Policies', 'नीतियाँ'),
      description: L10nText(
        'Rules, directives and guidelines',
        'नियम, निर्देश और दिशानिर्देश',
      ),
      icon: Icons.verified_user_outlined,
    ),
    TrainingCategory(
      id: 'study',
      title: L10nText('Study Material', 'अध्ययन सामग्री'),
      description: L10nText(
        'Notes and reference sheets',
        'नोट्स और संदर्भ शीट',
      ),
      icon: Icons.school_outlined,
    ),
    TrainingCategory(
      id: 'presentations',
      title: L10nText(
        'Technical Presentations',
        'तकनीकी प्रस्तुतियाँ',
      ),
      description: L10nText(
        'Briefings and slide decks',
        'ब्रीफिंग और स्लाइड डेक',
      ),
      icon: Icons.slideshow_outlined,
    ),
  ];

  final List<QuickAccessItem> quickAccess = const [
    QuickAccessItem(
      label: L10nText('Manuals', 'मैनुअल'),
      value: '120+',
      icon: Icons.description_outlined,
      iconColor: Color(0xFFA4D43B),
    ),
    QuickAccessItem(
      label: L10nText('Videos', 'वीडियो'),
      value: '85+',
      icon: Icons.play_circle_fill,
      iconColor: Color(0xFF9C27B0),
    ),
    QuickAccessItem(
      label: L10nText('SOPs', 'SOPs'),
      value: '25+',
      icon: Icons.article_outlined,
      iconColor: Color(0xFFF9A825),
    ),
    QuickAccessItem(
      label: L10nText('Policies', 'नीतियाँ'),
      value: '45+',
      icon: Icons.shield_outlined,
      iconColor: Color(0xFF5E723C),
    ),
  ];

  String? _selectedCategoryId;
  String? get selectedCategoryId => _selectedCategoryId;

  void selectCategory(String id) {
    _selectedCategoryId = id;
    notifyListeners();
  }
}
