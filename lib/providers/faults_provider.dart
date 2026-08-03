import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';
import '../models/engine_fault.dart';

class FaultsProvider extends ChangeNotifier {
  String _searchQuery = '';
  int _selectedIndex = 0;
  bool? _wasHelpful;
  final Set<String> _bookmarkedIds = {'engine_not_starting'};

  String get searchQuery => _searchQuery;
  int get selectedIndex => _selectedIndex;
  bool? get wasHelpful => _wasHelpful;

  final List<EngineFault> _allFaults = const [
    EngineFault(
      id: 'engine_not_starting',
      name: L10nText('Engine Not Starting', 'इंजन स्टार्ट नहीं हो रहा'),
      icon: Icons.warning_amber_rounded,
      description: L10nText(
        'The engine cranks but does not start or shows weak cranking. This can be due to electrical, fuel, or air intake related issues.',
        'इंजन क्रैंक तो करता है लेकिन स्टार्ट नहीं होता या कमज़ोर क्रैंकिंग दिखाता है। यह इलेक्ट्रिकल, ईंधन या एयर इनटेक संबंधी समस्याओं से हो सकता है।',
      ),
      causes: [
        L10nText(
          'Battery weak or discharged',
          'बैटरी कमज़ोर या डिस्चार्ज',
        ),
        L10nText('Fuel supply blockage', 'ईंधन आपूर्ति अवरुद्ध'),
        L10nText('Faulty starter motor', 'दोषपूर्ण स्टार्टर मोटर'),
        L10nText('Air in fuel system', 'फ्यूल सिस्टम में हवा'),
        L10nText(
          'Faulty ignition switch or wiring',
          'दोषपूर्ण इग्निशन स्विच या वायरिंग',
        ),
        L10nText('Defective fuel pump', 'दोषपूर्ण फ्यूल पंप'),
      ],
      remedies: [
        L10nText(
          'Check battery voltage and connections',
          'बैटरी वोल्टेज और कनेक्शन जाँचें',
        ),
        L10nText(
          'Ensure fuel is reaching the injectors',
          'सुनिश्चित करें कि ईंधन इंजेक्टर तक पहुँच रहा है',
        ),
        L10nText(
          'Inspect starter motor and relay',
          'स्टार्टर मोटर और रिले का निरीक्षण करें',
        ),
        L10nText(
          'Bleed air from fuel system',
          'फ्यूल सिस्टम से हवा निकालें',
        ),
        L10nText(
          'Check ignition switch and wiring',
          'इग्निशन स्विच और वायरिंग जाँचें',
        ),
      ],
      resources: [
        FaultResource(
          title: L10nText(
            'Troubleshooting Guide (PDF)',
            'समस्या निवारण गाइड (PDF)',
          ),
          meta: '1.6 MB',
          icon: Icons.picture_as_pdf,
          iconColor: Color(0xFFE53935),
        ),
        FaultResource(
          title: L10nText('Video Guide', 'वीडियो गाइड'),
          meta: '07:32',
          icon: Icons.play_circle_fill,
          iconColor: Color(0xFF1E88E5),
        ),
        FaultResource(
          title: L10nText('Wiring Diagram', 'वायरिंग आरेख'),
          meta: '1.3 MB',
          icon: Icons.account_tree_outlined,
          iconColor: Color(0xFF43A047),
        ),
        FaultResource(
          title: L10nText('Study Notes', 'अध्ययन नोट्स'),
          meta: '845 KB',
          icon: Icons.sticky_note_2_outlined,
          iconColor: Color(0xFFF9A825),
        ),
      ],
    ),
    EngineFault(
      id: 'overheating',
      name: L10nText('Overheating', 'अत्यधिक गरम होना'),
      icon: Icons.thermostat,
      description: L10nText(
        'Engine temperature rises above normal operating range, risking damage to cylinder head and gaskets.',
        'इंजन तापमान सामान्य संचालन सीमा से ऊपर चला जाता है, जिससे सिलेंडर हेड और गैस्केट को नुकसान का खतरा होता है।',
      ),
      causes: [
        L10nText('Low coolant level', 'शीतलक स्तर कम'),
        L10nText('Faulty thermostat', 'दोषपूर्ण थर्मोस्टैट'),
        L10nText('Radiator blockage', 'रेडिएटर अवरुद्ध'),
        L10nText('Water pump failure', 'वाटर पंप खराबी'),
        L10nText('Broken fan belt', 'टूटा फैन बेल्ट'),
      ],
      remedies: [
        L10nText(
          'Top up coolant to correct level',
          'शीतलक सही स्तर तक भरें',
        ),
        L10nText(
          'Replace defective thermostat',
          'दोषपूर्ण थर्मोस्टैट बदलें',
        ),
        L10nText(
          'Flush and clean radiator',
          'रेडिएटर फ्लश और साफ करें',
        ),
        L10nText(
          'Inspect/replace water pump',
          'वाटर पंप का निरीक्षण/प्रतिस्थापन करें',
        ),
        L10nText(
          'Check and tension fan belt',
          'फैन बेल्ट जाँचें और तनाव सही करें',
        ),
      ],
      resources: [
        FaultResource(
          title: L10nText(
            'Cooling System Guide',
            'शीतलन सिस्टम गाइड',
          ),
          meta: '1.1 MB',
          icon: Icons.picture_as_pdf,
          iconColor: Color(0xFFE53935),
        ),
      ],
    ),
    EngineFault(
      id: 'low_power',
      name: L10nText('Low Power', 'कम शक्ति'),
      icon: Icons.speed,
      description: L10nText(
        'Vehicle lacks expected power under load or during acceleration.',
        'लोड या त्वरण के दौरान वाहन में अपेक्षित शक्ति नहीं रहती।',
      ),
      causes: [
        L10nText(
          'Clogged air/fuel filter',
          'अवरुद्ध एयर/फ्यूल फ़िल्टर',
        ),
        L10nText('Turbocharger fault', 'टर्बोचार्जर दोष'),
        L10nText(
          'Incorrect valve timing',
          'गलत वाल्व टाइमिंग',
        ),
        L10nText('Worn injectors', 'घिसे इंजेक्टर'),
      ],
      remedies: [
        L10nText(
          'Replace air and fuel filters',
          'एयर और फ्यूल फ़िल्टर बदलें',
        ),
        L10nText(
          'Inspect turbo boost pressure',
          'टर्बो बूस्ट दबाव जाँचें',
        ),
        L10nText('Verify timing marks', 'टाइमिंग मार्क सत्यापित करें'),
        L10nText(
          'Test and service injectors',
          'इंजेक्टर का परीक्षण और सर्विस करें',
        ),
      ],
      resources: [
        FaultResource(
          title: L10nText(
            'Power Loss Checklist',
            'पावर लॉस चेकलिस्ट',
          ),
          meta: '720 KB',
          icon: Icons.sticky_note_2_outlined,
          iconColor: Color(0xFFF9A825),
        ),
      ],
    ),
    EngineFault(
      id: 'excess_smoke',
      name: L10nText('Excess Smoke', 'अत्यधिक धुआँ'),
      icon: Icons.cloud_outlined,
      description: L10nText(
        'Abnormal exhaust smoke (black, blue or white) indicating combustion or lubrication issues.',
        'असामान्य एग्ज़ॉस्ट धुआँ (काला, नीला या सफेद) जो दहन या स्नेहन समस्याओं का संकेत देता है।',
      ),
      causes: [
        L10nText('Rich fuel mixture', 'समृद्ध ईंधन मिश्रण'),
        L10nText(
          'Worn piston rings (blue smoke)',
          'घिसे पिस्टन रिंग्स (नीला धुआँ)',
        ),
        L10nText(
          'Coolant leak into cylinder (white smoke)',
          'सिलेंडर में शीतलक रिसाव (सफेद धुआँ)',
        ),
        L10nText('Faulty injectors', 'दोषपूर्ण इंजेक्टर'),
      ],
      remedies: [
        L10nText(
          'Check injection timing and quantity',
          'इंजेक्शन टाइमिंग और मात्रा जाँचें',
        ),
        L10nText(
          'Perform compression test',
          'कम्प्रेशन टेस्ट करें',
        ),
        L10nText(
          'Inspect head gasket for coolant leak',
          'शीतलक रिसाव के लिए हेड गैस्केट जाँचें',
        ),
        L10nText(
          'Service or replace injectors',
          'इंजेक्टर सर्विस या बदलें',
        ),
      ],
      resources: [
        FaultResource(
          title: L10nText(
            'Smoke Diagnosis Chart',
            'धुआँ निदान चार्ट',
          ),
          meta: '980 KB',
          icon: Icons.picture_as_pdf,
          iconColor: Color(0xFFE53935),
        ),
      ],
    ),
    EngineFault(
      id: 'knocking',
      name: L10nText('Knocking Noise', 'नॉकिंग शोर'),
      icon: Icons.graphic_eq,
      description: L10nText(
        'Metallic knocking sound from engine bay during idle or under load.',
        'आइडल या लोड के दौरान इंजन बे से धातु जैसी नॉकिंग ध्वनि।',
      ),
      causes: [
        L10nText('Low oil pressure', 'कम ऑयल प्रेशर'),
        L10nText(
          'Worn big-end bearings',
          'घिसे बिग-एंड बियरिंग',
        ),
        L10nText('Incorrect fuel grade', 'गलत ईंधन ग्रेड'),
        L10nText('Carbon deposits', 'कार्बन जमाव'),
      ],
      remedies: [
        L10nText(
          'Check oil level and pressure',
          'तेल स्तर और दबाव जाँचें',
        ),
        L10nText(
          'Inspect bearings if noise persists',
          'शोर जारी रहे तो बियरिंग जाँचें',
        ),
        L10nText(
          'Use recommended fuel grade',
          'अनुशंसित ईंधन ग्रेड उपयोग करें',
        ),
        L10nText(
          'Decarbonize combustion chamber',
          'दहन कक्ष डीकार्बनाइज़ करें',
        ),
      ],
      resources: [
        FaultResource(
          title: L10nText(
            'Noise Diagnosis Video',
            'शोर निदान वीडियो',
          ),
          meta: '05:18',
          icon: Icons.play_circle_fill,
          iconColor: Color(0xFF1E88E5),
        ),
      ],
    ),
    EngineFault(
      id: 'high_fuel',
      name: L10nText(
        'High Fuel Consumption',
        'अधिक ईंधन खपत',
      ),
      icon: Icons.local_gas_station,
      description: L10nText(
        'Fuel usage significantly higher than specified for ALS engine under similar conditions.',
        'समान परिस्थितियों में ALS इंजन के लिए निर्धारित से कहीं अधिक ईंधन खपत।',
      ),
      causes: [
        L10nText('Clogged air filter', 'अवरुद्ध एयर फ़िल्टर'),
        L10nText('Faulty injectors', 'दोषपूर्ण इंजेक्टर'),
        L10nText(
          'Incorrect tyre pressure',
          'गलत टायर दबाव',
        ),
        L10nText('Dragging brakes', 'खींचते ब्रेक'),
      ],
      remedies: [
        L10nText('Replace air filter', 'एयर फ़िल्टर बदलें'),
        L10nText('Calibrate injectors', 'इंजेक्टर कैलिब्रेट करें'),
        L10nText(
          'Set correct tyre pressures',
          'सही टायर दबाव सेट करें',
        ),
        L10nText(
          'Inspect brake adjustment',
          'ब्रेक समायोजन जाँचें',
        ),
      ],
      resources: [
        FaultResource(
          title: L10nText(
            'Fuel Economy Tips',
            'ईंधन अर्थव्यवस्था सुझाव',
          ),
          meta: '640 KB',
          icon: Icons.sticky_note_2_outlined,
          iconColor: Color(0xFFF9A825),
        ),
      ],
    ),
    EngineFault(
      id: 'rough_idle',
      name: L10nText('Rough Idling', 'अस्थिर आइडल'),
      icon: Icons.waves,
      description: L10nText(
        'Engine idle is unstable with vibration or fluctuating RPM.',
        'इंजन आइडल अस्थिर रहता है — कंपन या बदलता RPM।',
      ),
      causes: [
        L10nText('Vacuum leak', 'वैक्यूम लीक'),
        L10nText(
          'Dirty idle control valve',
          'गंदा आइडल कंट्रोल वाल्व',
        ),
        L10nText('Uneven compression', 'असमान कम्प्रेशन'),
        L10nText('Faulty sensors', 'दोषपूर्ण सेंसर'),
      ],
      remedies: [
        L10nText(
          'Check intake manifold seals',
          'इनटेक मैनिफ़ोल्ड सील जाँचें',
        ),
        L10nText(
          'Clean idle control components',
          'आइडल कंट्रोल घटक साफ करें',
        ),
        L10nText(
          'Perform compression test',
          'कम्प्रेशन टेस्ट करें',
        ),
        L10nText(
          'Scan and replace faulty sensors',
          'स्कैन करें और दोषपूर्ण सेंसर बदलें',
        ),
      ],
      resources: [
        FaultResource(
          title: L10nText('Idle Fault Guide', 'आइडल फॉल्ट गाइड'),
          meta: '1.0 MB',
          icon: Icons.picture_as_pdf,
          iconColor: Color(0xFFE53935),
        ),
      ],
    ),
    EngineFault(
      id: 'misfiring',
      name: L10nText('Engine Misfiring', 'इंजन मिसफायरिंग'),
      icon: Icons.flash_on,
      description: L10nText(
        'One or more cylinders fail to fire correctly, causing vibration and power loss.',
        'एक या अधिक सिलेंडर सही से फायर नहीं करते, जिससे कंपन और शक्ति हानि होती है।',
      ),
      causes: [
        L10nText('Faulty injector', 'दोषपूर्ण इंजेक्टर'),
        L10nText('Low compression', 'कम कम्प्रेशन'),
        L10nText('Wiring/sensor fault', 'वायरिंग/सेंसर दोष'),
        L10nText('Contaminated fuel', 'दूषित ईंधन'),
      ],
      remedies: [
        L10nText(
          'Identify misfiring cylinder',
          'मिसफायरिंग सिलेंडर पहचानें',
        ),
        L10nText(
          'Test injector spray pattern',
          'इंजेक्टर स्प्रे पैटर्न जाँचें',
        ),
        L10nText(
          'Check compression and valves',
          'कम्प्रेशन और वाल्व जाँचें',
        ),
        L10nText(
          'Drain and replace fuel if contaminated',
          'दूषित होने पर ईंधन निकालकर बदलें',
        ),
      ],
      resources: [
        FaultResource(
          title: L10nText('Misfire Diagnosis', 'मिसफायर निदान'),
          meta: '06:40',
          icon: Icons.play_circle_fill,
          iconColor: Color(0xFF1E88E5),
        ),
      ],
    ),
    EngineFault(
      id: 'oil_pressure',
      name: L10nText('Oil Pressure Low', 'ऑयल प्रेशर कम'),
      icon: Icons.opacity,
      description: L10nText(
        'Oil pressure warning lamp illuminates or gauge reads below safe range.',
        'ऑयल प्रेशर वॉर्निंग लैंप जलता है या गेज सुरक्षित सीमा से नीचे पढ़ता है।',
      ),
      causes: [
        L10nText('Low oil level', 'तेल स्तर कम'),
        L10nText('Worn oil pump', 'घिसा ऑयल पंप'),
        L10nText('Blocked oil filter', 'अवरुद्ध ऑयल फ़िल्टर'),
        L10nText('Bearing wear', 'बियरिंग घिसाव'),
      ],
      remedies: [
        L10nText(
          'Top up to correct oil grade/level',
          'सही ग्रेड/स्तर तक तेल भरें',
        ),
        L10nText('Replace oil filter', 'ऑयल फ़िल्टर बदलें'),
        L10nText(
          'Measure oil pressure with gauge',
          'गेज से ऑयल प्रेशर मापें',
        ),
        L10nText(
          'Inspect pump and bearings if required',
          'आवश्यक होने पर पंप और बियरिंग जाँचें',
        ),
      ],
      resources: [
        FaultResource(
          title: L10nText('Lubrication SOP', 'स्नेहन SOP'),
          meta: '890 KB',
          icon: Icons.picture_as_pdf,
          iconColor: Color(0xFFE53935),
        ),
      ],
    ),
    EngineFault(
      id: 'coolant_leak',
      name: L10nText('Coolant Leakage', 'शीतलक रिसाव'),
      icon: Icons.water_drop_outlined,
      description: L10nText(
        'Visible coolant loss from radiator, hoses, water pump or head gasket area.',
        'रेडिएटर, होज़, वाटर पंप या हेड गैस्केट क्षेत्र से दिखाई देने वाला शीतलक नुकसान।',
      ),
      causes: [
        L10nText('Damaged hose/clamp', 'क्षतिग्रस्त होज़/क्लैंप'),
        L10nText('Radiator leak', 'रेडिएटर लीक'),
        L10nText(
          'Water pump seal failure',
          'वाटर पंप सील खराबी',
        ),
        L10nText('Head gasket breach', 'हेड गैस्केट टूटना'),
      ],
      remedies: [
        L10nText(
          'Pressure-test cooling system',
          'शीतलन सिस्टम का प्रेशर टेस्ट करें',
        ),
        L10nText(
          'Replace damaged hoses/clamps',
          'क्षतिग्रस्त होज़/क्लैंप बदलें',
        ),
        L10nText(
          'Repair or replace radiator',
          'रेडिएटर मरम्मत या बदलें',
        ),
        L10nText(
          'Inspect head gasket if internal leak suspected',
          'आंतरिक लीक संदेह पर हेड गैस्केट जाँचें',
        ),
      ],
      resources: [
        FaultResource(
          title: L10nText(
            'Coolant Leak Chart',
            'शीतलक रिसाव चार्ट',
          ),
          meta: '750 KB',
          icon: Icons.account_tree_outlined,
          iconColor: Color(0xFF43A047),
        ),
      ],
    ),
    EngineFault(
      id: 'belt_noise',
      name: L10nText('Belt Noise', 'बेल्ट शोर'),
      icon: Icons.settings,
      description: L10nText(
        'Squealing or chirping noise from drive belts during start or acceleration.',
        'स्टार्ट या त्वरण के दौरान ड्राइव बेल्ट से चीखने या चहचहाने जैसी ध्वनि।',
      ),
      causes: [
        L10nText('Loose belt tension', 'ढीला बेल्ट तनाव'),
        L10nText('Worn belt', 'घिसा बेल्ट'),
        L10nText('Misaligned pulley', 'गलत संरेखित पुली'),
        L10nText(
          'Contaminated belt surface',
          'दूषित बेल्ट सतह',
        ),
      ],
      remedies: [
        L10nText('Adjust belt tension', 'बेल्ट तनाव समायोजित करें'),
        L10nText('Replace worn belt', 'घिसा बेल्ट बदलें'),
        L10nText('Align pulleys', 'पुली संरेखित करें'),
        L10nText(
          'Clean oil/grease from belt area',
          'बेल्ट क्षेत्र से तेल/ग्रीस साफ करें',
        ),
      ],
      resources: [
        FaultResource(
          title: L10nText('Belt Service Notes', 'बेल्ट सर्विस नोट्स'),
          meta: '520 KB',
          icon: Icons.sticky_note_2_outlined,
          iconColor: Color(0xFFF9A825),
        ),
      ],
    ),
    EngineFault(
      id: 'turbo_boost',
      name: L10nText('Turbo Low Boost', 'टर्बो लो बूस्ट'),
      icon: Icons.air,
      description: L10nText(
        'Insufficient boost pressure leading to poor acceleration and power.',
        'अपर्याप्त बूस्ट दबाव के कारण कमज़ोर त्वरण और शक्ति।',
      ),
      causes: [
        L10nText('Boost leak in pipes', 'पाइप में बूस्ट लीक'),
        L10nText(
          'Wastegate stuck open',
          'वेस्टगेट खुला अटका',
        ),
        L10nText('Dirty air filter', 'गंदा एयर फ़िल्टर'),
        L10nText('Turbocharger wear', 'टर्बोचार्जर घिसाव'),
      ],
      remedies: [
        L10nText(
          'Inspect intercooler pipes for leaks',
          'लीक के लिए इंटरकूलर पाइप जाँचें',
        ),
        L10nText(
          'Check wastegate actuator',
          'वेस्टगेट एक्चुएटर जाँचें',
        ),
        L10nText('Replace air filter', 'एयर फ़िल्टर बदलें'),
        L10nText(
          'Test turbo shaft play and vanes',
          'टर्बो शाफ्ट प्ले और वेन्स जाँचें',
        ),
      ],
      resources: [
        FaultResource(
          title: L10nText('Turbo Boost Guide', 'टर्बो बूस्ट गाइड'),
          meta: '1.4 MB',
          icon: Icons.picture_as_pdf,
          iconColor: Color(0xFFE53935),
        ),
      ],
    ),
  ];

  List<EngineFault> get filteredFaults {
    if (_searchQuery.trim().isEmpty) return _allFaults;
    final q = _searchQuery.toLowerCase();
    return _allFaults
        .where(
          (f) =>
              f.name.en.toLowerCase().contains(q) ||
              f.name.hi.toLowerCase().contains(q),
        )
        .toList();
  }

  EngineFault get selectedFault {
    final list = filteredFaults;
    if (list.isEmpty) return _allFaults.first;
    return list[_selectedIndex.clamp(0, list.length - 1)];
  }

  bool isBookmarked(String id) => _bookmarkedIds.contains(id);

  void setSearchQuery(String value) {
    _searchQuery = value;
    _selectedIndex = 0;
    _wasHelpful = null;
    notifyListeners();
  }

  void selectFault(int index) {
    _selectedIndex = index;
    _wasHelpful = null;
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

  void setHelpful(bool value) {
    _wasHelpful = value;
    notifyListeners();
  }
}
