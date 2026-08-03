import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';
import '../models/technical_manual.dart';

class ManualProvider extends ChangeNotifier {
  static const L10nText title = L10nText(
    'Technical Manuals',
    'तकनीकी मैनुअल',
  );
  static const L10nText subtitle = L10nText(
    'Training Center',
    'प्रशिक्षण केंद्र',
  );
  static const L10nText heroDescription = L10nText(
    'Access detailed technical manuals for all systems and components. Learn, understand and maintain with official documentation.',
    'सभी सिस्टम और घटकों के विस्तृत तकनीकी मैनुअल देखें। आधिकारिक दस्तावेज़ों से सीखें और रखरखाव करें।',
  );
  static const L10nText listSubtitle = L10nText(
    'Select a manual to view details',
    'विवरण देखने के लिए मैनुअल चुनें',
  );

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  final List<TechnicalManual> _manuals = const [
    TechnicalManual(
      id: 'engine',
      title: L10nText('Engine System Manual', 'इंजन सिस्टम मैनुअल'),
      description: L10nText(
        'Complete guide covering engine construction, working principle, parts identification and servicing procedures.',
        'इंजन निर्माण, कार्य सिद्धांत, पार्ट्स पहचान और सर्विसिंग प्रक्रियाओं की पूर्ण गाइड।',
      ),
      fileSizeMb: 4.8,
      pageCount: 120,
      date: L10nText('May 2024', 'मई 2024'),
    ),
    TechnicalManual(
      id: 'transmission',
      title: L10nText(
        'Transmission System Manual',
        'ट्रांसमिशन सिस्टम मैनुअल',
      ),
      description: L10nText(
        'Detailed documentation on gearbox types, clutch assembly, gear ratios and maintenance schedules.',
        'गियरबॉक्स प्रकार, क्लच असेंबली, गियर अनुपात और रखरखाव अनुसूची पर विस्तृत दस्तावेज़।',
      ),
      fileSizeMb: 3.6,
      pageCount: 96,
      date: L10nText('May 2024', 'मई 2024'),
    ),
    TechnicalManual(
      id: 'brake',
      title: L10nText('Brake System Manual', 'ब्रेक सिस्टम मैनुअल'),
      description: L10nText(
        'Covers hydraulic brakes, air brakes, ABS components and inspection checklists for ALS vehicles.',
        'ALS वाहनों के लिए हाइड्रोलिक ब्रेक, एयर ब्रेक, ABS घटक और निरीक्षण चेकलिस्ट।',
      ),
      fileSizeMb: 2.9,
      pageCount: 84,
      date: L10nText('Apr 2024', 'अप्रैल 2024'),
    ),
    TechnicalManual(
      id: 'fuel',
      title: L10nText('Fuel System Manual', 'फ्यूल सिस्टम मैनुअल'),
      description: L10nText(
        'Fuel injection, filtration, tanks and delivery lines with troubleshooting and safety notes.',
        'ईंधन इंजेक्शन, फ़िल्ट्रेशन, टैंक और डिलीवरी लाइनें — समस्या निवारण और सुरक्षा नोट्स सहित।',
      ),
      fileSizeMb: 2.4,
      pageCount: 72,
      date: L10nText('Apr 2024', 'अप्रैल 2024'),
    ),
    TechnicalManual(
      id: 'electrical',
      title: L10nText(
        'Electrical System Manual',
        'इलेक्ट्रिकल सिस्टम मैनुअल',
      ),
      description: L10nText(
        'Battery, charging, lighting circuits, wiring diagrams and electrical fault diagnosis.',
        'बैटरी, चार्जिंग, लाइटिंग सर्किट, वायरिंग आरेख और इलेक्ट्रिकल फॉल्ट निदान।',
      ),
      fileSizeMb: 5.1,
      pageCount: 140,
      date: L10nText('Mar 2024', 'मार्च 2024'),
    ),
    TechnicalManual(
      id: 'electronic',
      title: L10nText(
        'Electronic System Manual',
        'इलेक्ट्रॉनिक सिस्टम मैनुअल',
      ),
      description: L10nText(
        'Sensors, ECUs, diagnostic procedures and electronic control module overview.',
        'सेंसर, ECU, डायग्नोस्टिक प्रक्रियाएँ और इलेक्ट्रॉनिक कंट्रोल मॉड्यूल अवलोकन।',
      ),
      fileSizeMb: 3.2,
      pageCount: 88,
      date: L10nText('Mar 2024', 'मार्च 2024'),
    ),
  ];

  List<TechnicalManual> get manuals {
    if (_searchQuery.trim().isEmpty) return _manuals;
    final q = _searchQuery.toLowerCase();
    return _manuals
        .where(
          (m) =>
              m.title.en.toLowerCase().contains(q) ||
              m.title.hi.toLowerCase().contains(q) ||
              m.description.en.toLowerCase().contains(q) ||
              m.description.hi.toLowerCase().contains(q),
        )
        .toList();
  }

  int get count => manuals.length;

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }
}
