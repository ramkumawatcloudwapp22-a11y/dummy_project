import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';
import '../models/engine_part.dart';

class PartsProvider extends ChangeNotifier {
  String _searchQuery = '';
  int _selectedIndex = 0;
  int _imageIndex = 0;
  final Set<String> _bookmarkedIds = {'cylinder_block'};

  String get searchQuery => _searchQuery;
  int get selectedIndex => _selectedIndex;
  int get imageIndex => _imageIndex;

  final List<EnginePart> _allParts = const [
    EnginePart(
      id: 'cylinder_block',
      name: L10nText('Cylinder Block', 'सिलेंडर ब्लॉक'),
      icon: Icons.view_in_ar,
      overview: L10nText(
        'The cylinder block is the main structure of the engine that houses the cylinders, coolant passages and oil galleries. It provides mounting points for other engine components.',
        'सिलेंडर ब्लॉक इंजन की मुख्य संरचना है जिसमें सिलेंडर, शीतलक पथ और ऑयल गैलरी होती हैं। यह अन्य इंजन घटकों के लिए माउंटिंग बिंदु प्रदान करता है।',
      ),
      keyFunctions: [
        L10nText(
          'Houses cylinders and pistons',
          'सिलेंडर और पिस्टन को समाहित करता है',
        ),
        L10nText(
          'Contains coolant and oil passages',
          'शीतलक और तेल पथ रखता है',
        ),
        L10nText(
          'Provides structural rigidity',
          'संरचनात्मक दृढ़ता प्रदान करता है',
        ),
        L10nText(
          'Supports crankshaft and camshaft mounts',
          'क्रैंकशाफ्ट और कैमशाफ्ट माउंट को सहारा देता है',
        ),
      ],
      specs: {
        L10nText('Material', 'सामग्री'): L10nText(
          'Cast Iron / Aluminum Alloy',
          'कास्ट आयरन / एल्यूमीनियम मिश्र धातु',
        ),
        L10nText('No. of Cylinders', 'सिलेंडर की संख्या'): L10nText('6', '6'),
        L10nText('Cooling Type', 'शीतलन प्रकार'): L10nText(
          'Water Cooled',
          'जल शीतित',
        ),
        L10nText('Weight (Approx.)', 'भार (लगभग)'): L10nText(
          '120 - 150 kg',
          '120 - 150 kg',
        ),
      },
      resources: [
        LearningResource(
          title: L10nText(
            'Cylinder Block Manual (PDF)',
            'सिलेंडर ब्लॉक मैनुअल (PDF)',
          ),
          meta: '1.8 MB',
          icon: Icons.picture_as_pdf,
          iconColor: Color(0xFFE53935),
        ),
        LearningResource(
          title: L10nText(
            'Cylinder Block Video',
            'सिलेंडर ब्लॉक वीडियो',
          ),
          meta: '08:45',
          icon: Icons.play_circle_fill,
          iconColor: Color(0xFF1E88E5),
        ),
        LearningResource(
          title: L10nText(
            'Cylinder Block Diagram',
            'सिलेंडर ब्लॉक आरेख',
          ),
          meta: '1.2 MB',
          icon: Icons.account_tree_outlined,
          iconColor: Color(0xFF43A047),
        ),
        LearningResource(
          title: L10nText('Study Notes', 'अध्ययन नोट्स'),
          meta: '856 KB',
          icon: Icons.sticky_note_2_outlined,
          iconColor: Color(0xFFF9A825),
        ),
      ],
      bookmarked: true,
    ),
    EnginePart(
      id: 'piston',
      name: L10nText('Piston', 'पिस्टन'),
      icon: Icons.circle_outlined,
      overview: L10nText(
        'The piston transfers force from expanding gases in the cylinder to the crankshaft via the connecting rod, enabling rotary motion.',
        'पिस्टन सिलेंडर में फैलती गैसों के बल को कनेक्टिंग रॉड के माध्यम से क्रैंकशाफ्ट तक पहुँचाता है, जिससे घूर्णन गति संभव होती है।',
      ),
      keyFunctions: [
        L10nText(
          'Transfers combustion force',
          'दहन बल स्थानांतरित करता है',
        ),
        L10nText(
          'Seals combustion chamber with rings',
          'रिंग्स से दहन कक्ष को सील करता है',
        ),
        L10nText(
          'Dissipates heat to cylinder walls',
          'सिलेंडर दीवारों तक ऊष्मा नष्ट करता है',
        ),
      ],
      specs: {
        L10nText('Material', 'सामग्री'): L10nText(
          'Aluminum Alloy',
          'एल्यूमीनियम मिश्र धातु',
        ),
        L10nText('Diameter', 'व्यास'): L10nText('110 mm', '110 mm'),
        L10nText('Type', 'प्रकार'): L10nText(
          'Trunk Piston',
          'ट्रंक पिस्टन',
        ),
        L10nText('Weight (Approx.)', 'भार (लगभग)'): L10nText(
          '1.2 - 1.5 kg',
          '1.2 - 1.5 kg',
        ),
      },
      resources: [
        LearningResource(
          title: L10nText('Piston Manual (PDF)', 'पिस्टन मैनुअल (PDF)'),
          meta: '1.1 MB',
          icon: Icons.picture_as_pdf,
          iconColor: Color(0xFFE53935),
        ),
        LearningResource(
          title: L10nText(
            'Piston Assembly Video',
            'पिस्टन असेंबली वीडियो',
          ),
          meta: '06:20',
          icon: Icons.play_circle_fill,
          iconColor: Color(0xFF1E88E5),
        ),
      ],
    ),
    EnginePart(
      id: 'crankshaft',
      name: L10nText('Crankshaft', 'क्रैंकशाफ्ट'),
      icon: Icons.rotate_90_degrees_ccw,
      overview: L10nText(
        'The crankshaft converts the linear motion of pistons into rotational motion to drive the transmission and accessories.',
        'क्रैंकशाफ्ट पिस्टन की रैखिक गति को घूर्णन गति में बदलकर ट्रांसमिशन और एक्सेसरीज़ चलाता है।',
      ),
      keyFunctions: [
        L10nText(
          'Converts reciprocating to rotary motion',
          'आवर्ती गति को घूर्णन गति में बदलता है',
        ),
        L10nText(
          'Drives flywheel and accessories',
          'फ्लाईव्हील और एक्सेसरीज़ चलाता है',
        ),
        L10nText(
          'Balances engine dynamics',
          'इंजन डायनामिक्स को संतुलित करता है',
        ),
      ],
      specs: {
        L10nText('Material', 'सामग्री'): L10nText(
          'Forged Steel',
          'फोर्ज्ड स्टील',
        ),
        L10nText('Journals', 'जर्नल'): L10nText('7 Main', '7 मुख्य'),
        L10nText('Throw', 'थ्रो'): L10nText('130 mm', '130 mm'),
        L10nText('Weight (Approx.)', 'भार (लगभग)'): L10nText(
          '45 - 55 kg',
          '45 - 55 kg',
        ),
      },
      resources: [
        LearningResource(
          title: L10nText(
            'Crankshaft Manual (PDF)',
            'क्रैंकशाफ्ट मैनुअल (PDF)',
          ),
          meta: '2.0 MB',
          icon: Icons.picture_as_pdf,
          iconColor: Color(0xFFE53935),
        ),
      ],
    ),
    EnginePart(
      id: 'cylinder_head',
      name: L10nText('Cylinder Head', 'सिलेंडर हेड'),
      icon: Icons.layers_outlined,
      overview: L10nText(
        'The cylinder head seals the top of the cylinders and houses valves, injectors and the combustion chamber.',
        'सिलेंडर हेड सिलेंडर के शीर्ष को सील करता है और वाल्व, इंजेक्टर तथा दहन कक्ष को समाहित करता है।',
      ),
      keyFunctions: [
        L10nText(
          'Seals combustion chambers',
          'दहन कक्षों को सील करता है',
        ),
        L10nText(
          'Houses valves and injectors',
          'वाल्व और इंजेक्टर समाहित करता है',
        ),
        L10nText(
          'Contains coolant passages',
          'शीतलक पथ रखता है',
        ),
      ],
      specs: {
        L10nText('Material', 'सामग्री'): L10nText(
          'Cast Iron / Alloy',
          'कास्ट आयरन / मिश्र धातु',
        ),
        L10nText('Valves per Cylinder', 'प्रति सिलेंडर वाल्व'): L10nText(
          '4',
          '4',
        ),
        L10nText('Cooling', 'शीतलन'): L10nText(
          'Water Cooled',
          'जल शीतित',
        ),
        L10nText('Weight (Approx.)', 'भार (लगभग)'): L10nText(
          '60 - 80 kg',
          '60 - 80 kg',
        ),
      },
      resources: [
        LearningResource(
          title: L10nText(
            'Cylinder Head Manual',
            'सिलेंडर हेड मैनुअल',
          ),
          meta: '1.5 MB',
          icon: Icons.picture_as_pdf,
          iconColor: Color(0xFFE53935),
        ),
      ],
    ),
    EnginePart(
      id: 'camshaft',
      name: L10nText('Camshaft', 'कैमशाफ्ट'),
      icon: Icons.timeline,
      overview: L10nText(
        'The camshaft controls the opening and closing of intake and exhaust valves in sync with piston position.',
        'कैमशाफ्ट पिस्टन स्थिति के साथ समन्वय में इनटेक और एग्ज़ॉस्ट वाल्व के खुलने-बंद होने को नियंत्रित करता है।',
      ),
      keyFunctions: [
        L10nText(
          'Actuates intake and exhaust valves',
          'इनटेक और एग्ज़ॉस्ट वाल्व चलाता है',
        ),
        L10nText(
          'Synchronizes with crankshaft timing',
          'क्रैंकशाफ्ट टाइमिंग के साथ समन्वय करता है',
        ),
        L10nText(
          'Drives fuel pump / accessories (as fitted)',
          'फ्यूल पंप / एक्सेसरीज़ चलाता है (जहाँ लगे हों)',
        ),
      ],
      specs: {
        L10nText('Material', 'सामग्री'): L10nText(
          'Hardened Steel',
          'हार्डेन्ड स्टील',
        ),
        L10nText('Drive', 'ड्राइव'): L10nText(
          'Gear / Chain',
          'गियर / चेन',
        ),
        L10nText('Lobes', 'लोब'): L10nText('12', '12'),
        L10nText('Weight (Approx.)', 'भार (लगभग)'): L10nText(
          '8 - 12 kg',
          '8 - 12 kg',
        ),
      },
      resources: [
        LearningResource(
          title: L10nText('Camshaft Notes', 'कैमशाफ्ट नोट्स'),
          meta: '920 KB',
          icon: Icons.sticky_note_2_outlined,
          iconColor: Color(0xFFF9A825),
        ),
      ],
    ),
    EnginePart(
      id: 'connecting_rod',
      name: L10nText('Connecting Rod', 'कनेक्टिंग रॉड'),
      icon: Icons.linear_scale,
      overview: L10nText(
        'Connecting rods link pistons to the crankshaft and transmit combustion forces during the power stroke.',
        'कनेक्टिंग रॉड पिस्टन को क्रैंकशाफ्ट से जोड़ती है और पावर स्ट्रोक के दौरान दहन बल संचारित करती है।',
      ),
      keyFunctions: [
        L10nText(
          'Links piston to crankshaft',
          'पिस्टन को क्रैंकशाफ्ट से जोड़ती है',
        ),
        L10nText(
          'Transmits power stroke force',
          'पावर स्ट्रोक बल संचारित करती है',
        ),
        L10nText(
          'Maintains alignment under load',
          'लोड के दौरान संरेखण बनाए रखती है',
        ),
      ],
      specs: {
        L10nText('Material', 'सामग्री'): L10nText(
          'Forged Steel',
          'फोर्ज्ड स्टील',
        ),
        L10nText('Length', 'लंबाई'): L10nText('210 mm', '210 mm'),
        L10nText('Big End', 'बिग एंड'): L10nText(
          'Split Type',
          'स्प्लिट प्रकार',
        ),
        L10nText('Weight (Approx.)', 'भार (लगभग)'): L10nText(
          '1.8 - 2.2 kg',
          '1.8 - 2.2 kg',
        ),
      },
      resources: [
        LearningResource(
          title: L10nText(
            'Connecting Rod Diagram',
            'कनेक्टिंग रॉड आरेख',
          ),
          meta: '780 KB',
          icon: Icons.account_tree_outlined,
          iconColor: Color(0xFF43A047),
        ),
      ],
    ),
  ];

  List<EnginePart> get filteredParts {
    if (_searchQuery.trim().isEmpty) return _allParts;
    final q = _searchQuery.toLowerCase();
    return _allParts
        .where(
          (p) =>
              p.name.en.toLowerCase().contains(q) ||
              p.name.hi.toLowerCase().contains(q),
        )
        .toList();
  }

  EnginePart get selectedPart {
    final list = filteredParts;
    if (list.isEmpty) return _allParts.first;
    final index = _selectedIndex.clamp(0, list.length - 1);
    return list[index];
  }

  bool isBookmarked(String id) => _bookmarkedIds.contains(id);

  void setSearchQuery(String value) {
    _searchQuery = value;
    _selectedIndex = 0;
    _imageIndex = 0;
    notifyListeners();
  }

  void selectPart(int index) {
    _selectedIndex = index;
    _imageIndex = 0;
    notifyListeners();
  }

  void setImageIndex(int index) {
    _imageIndex = index;
    notifyListeners();
  }

  void toggleBookmark(String id) {
    if (_bookmarkedIds.contains(id)) {
      _bookmarkedIds.remove(id);
    } else {
      _bookmarkedIds.add(id);
    }
    notifyListeners();
  }
}
