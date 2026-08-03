import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';
import '../models/working_principle.dart';

class WorkingPrincipleProvider extends ChangeNotifier {
  static const L10nText title = L10nText(
    'Working Principle',
    'कार्य सिद्धांत',
  );
  static const L10nText subtitle = L10nText(
    'Engine System – ALS',
    'इंजन सिस्टम – ALS',
  );
  static const L10nText overview = L10nText(
    'The ALS engine converts chemical energy in fuel into mechanical work through a controlled four-stroke combustion cycle. Understanding each stroke and supporting systems is essential for diagnosis and maintenance.',
    'ALS इंजन नियंत्रित चार-स्ट्रोक दहन चक्र के माध्यम से ईंधन की रासायनिक ऊर्जा को यांत्रिक कार्य में बदलता है। प्रत्येक स्ट्रोक और सहायक सिस्टम को समझना निदान और रखरखाव के लिए आवश्यक है।',
  );

  int _selectedTopicIndex = 0;
  int _selectedCycleIndex = 0;
  bool _bookmarked = false;

  int get selectedTopicIndex => _selectedTopicIndex;
  int get selectedCycleIndex => _selectedCycleIndex;
  bool get bookmarked => _bookmarked;

  final List<PrincipleSection> topics = const [
    PrincipleSection(
      id: 'intro',
      title: L10nText('Introduction', 'परिचय'),
      body: L10nText(
        'The ALS powerplant is a multi-cylinder, water-cooled diesel engine designed for heavy vehicle logistics and operational mobility. It delivers reliable torque across a wide RPM range.',
        'ALS पावरप्लांट एक मल्टी-सिलेंडर, जल-शीतित डीजल इंजन है जो भारी वाहन रसद और संचालन गतिशीलता के लिए डिज़ाइन किया गया है। यह व्यापक RPM रेंज में विश्वसनीय टॉर्क देता है।',
      ),
      icon: Icons.info_outline,
    ),
    PrincipleSection(
      id: 'combustion',
      title: L10nText('Combustion Process', 'दहन प्रक्रिया'),
      body: L10nText(
        'Air is compressed to high temperature and pressure. Fuel is injected near TDC, ignites spontaneously, and expanding gases drive the piston downward on the power stroke.',
        'वायु को उच्च तापमान और दबाव तक संपीड़ित किया जाता है। TDC के पास ईंधन इंजेक्ट होता है, स्वतः प्रज्वलित होता है, और फैलती गैसें पावर स्ट्रोक पर पिस्टन को नीचे धकेलती हैं।',
      ),
      icon: Icons.local_fire_department_outlined,
    ),
    PrincipleSection(
      id: 'fuel_air',
      title: L10nText('Fuel–Air Mixing', 'ईंधन–वायु मिश्रण'),
      body: L10nText(
        'Clean filtered air enters via the intake manifold. High-pressure injectors atomize diesel for efficient mixing, ensuring complete combustion and controlled emissions.',
        'साफ फ़िल्टर की गई वायु इनटेक मैनिफ़ोल्ड से प्रवेश करती है। उच्च-दबाव इंजेक्टर कुशल मिश्रण के लिए डीजल को परमाणुकृत करते हैं, जिससे पूर्ण दहन और नियंत्रित उत्सर्जन सुनिश्चित होता है।',
      ),
      icon: Icons.air,
    ),
    PrincipleSection(
      id: 'power_flow',
      title: L10nText('Power Transmission', 'शक्ति संचरण'),
      body: L10nText(
        'Linear piston motion is converted to rotary motion by the crankshaft, then transferred through the clutch and gearbox to the driveline.',
        'पिस्टन की रैखिक गति को क्रैंकशाफ्ट घूर्णन गति में बदलता है, फिर क्लच और गियरबॉक्स के माध्यम से ड्राइवलाइन तक स्थानांतरित होती है।',
      ),
      icon: Icons.settings_suggest_outlined,
    ),
    PrincipleSection(
      id: 'cooling_lube',
      title: L10nText('Cooling & Lubrication', 'शीतलन और स्नेहन'),
      body: L10nText(
        'Coolant circulates through block and head passages to remove heat. Pressurized oil lubricates bearings, cams and journals to reduce friction and wear.',
        'शीतलक ब्लॉक और हेड पथों से घूमकर ऊष्मा हटाता है। दबावयुक्त तेल बियरिंग, कैम और जर्नल को स्नेहित कर घर्षण और घिसाव कम करता है।',
      ),
      icon: Icons.water_drop_outlined,
    ),
  ];

  final List<CycleStep> cycleSteps = const [
    CycleStep(
      title: L10nText('1. Intake Stroke', '1. इनटेक स्ट्रोक'),
      description: L10nText(
        'Inlet valve opens. Piston moves down, drawing fresh air into the cylinder.',
        'इनलेट वाल्व खुलता है। पिस्टन नीचे जाता है और सिलेंडर में ताज़ी वायु खींचता है।',
      ),
      icon: Icons.south,
    ),
    CycleStep(
      title: L10nText('2. Compression Stroke', '2. संपीड़न स्ट्रोक'),
      description: L10nText(
        'Both valves closed. Piston moves up, compressing air to high temperature.',
        'दोनों वाल्व बंद। पिस्टन ऊपर जाता है और वायु को उच्च तापमान तक संपीड़ित करता है।',
      ),
      icon: Icons.compress,
    ),
    CycleStep(
      title: L10nText('3. Power Stroke', '3. पावर स्ट्रोक'),
      description: L10nText(
        'Fuel injects and ignites. Expanding gases force the piston down, producing work.',
        'ईंधन इंजेक्ट होकर प्रज्वलित होता है। फैलती गैसें पिस्टन को नीचे धकेलकर कार्य उत्पन्न करती हैं।',
      ),
      icon: Icons.bolt,
    ),
    CycleStep(
      title: L10nText('4. Exhaust Stroke', '4. एग्ज़ॉस्ट स्ट्रोक'),
      description: L10nText(
        'Exhaust valve opens. Piston moves up, expelling burnt gases from the cylinder.',
        'एग्ज़ॉस्ट वाल्व खुलता है। पिस्टन ऊपर जाता है और जली हुई गैसें सिलेंडर से निकालता है।',
      ),
      icon: Icons.north,
    ),
  ];

  final List<PrincipleResource> resources = const [
    PrincipleResource(
      title: L10nText(
        'Working Principle Manual',
        'कार्य सिद्धांत मैनुअल',
      ),
      meta: '2.1 MB',
      icon: Icons.picture_as_pdf,
      iconColor: Color(0xFFE53935),
    ),
    PrincipleResource(
      title: L10nText(
        '4-Stroke Cycle Video',
        '4-स्ट्रोक चक्र वीडियो',
      ),
      meta: '11:20',
      icon: Icons.play_circle_fill,
      iconColor: Color(0xFF1E88E5),
    ),
    PrincipleResource(
      title: L10nText('Cycle Diagram', 'चक्र आरेख'),
      meta: '1.4 MB',
      icon: Icons.account_tree_outlined,
      iconColor: Color(0xFF43A047),
    ),
    PrincipleResource(
      title: L10nText('Study Notes', 'अध्ययन नोट्स'),
      meta: '960 KB',
      icon: Icons.sticky_note_2_outlined,
      iconColor: Color(0xFFF9A825),
    ),
  ];

  final List<L10nText> keyPoints = const [
    L10nText(
      'Diesel engines rely on compression ignition — no spark plug',
      'डीजल इंजन संपीड़न प्रज्वलन पर निर्भर करते हैं — कोई स्पार्क प्लग नहीं',
    ),
    L10nText(
      'Four strokes complete one full working cycle per cylinder',
      'प्रति सिलेंडर एक पूर्ण कार्य चक्र चार स्ट्रोक में पूरा होता है',
    ),
    L10nText(
      'Crankshaft turns twice for each four-stroke cycle',
      'प्रत्येक चार-स्ट्रोक चक्र के लिए क्रैंकशाफ्ट दो बार घूमता है',
    ),
    L10nText(
      'Correct timing of valves and injection is critical',
      'वाल्व और इंजेक्शन का सही टाइमिंग अत्यंत महत्वपूर्ण है',
    ),
    L10nText(
      'Cooling and lubrication protect the engine under load',
      'शीतलन और स्नेहन लोड के दौरान इंजन की रक्षा करते हैं',
    ),
  ];

  PrincipleSection get selectedTopic => topics[_selectedTopicIndex];

  void selectTopic(int index) {
    _selectedTopicIndex = index;
    notifyListeners();
  }

  void selectCycleStep(int index) {
    _selectedCycleIndex = index;
    notifyListeners();
  }

  void toggleBookmark() {
    _bookmarked = !_bookmarked;
    notifyListeners();
  }
}
