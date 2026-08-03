import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';
import '../models/system_item.dart';

class AlsProvider extends ChangeNotifier {
  static const String vehicleName = 'ALS';
  static const L10nText vehicleFullName = L10nText(
    'Advanced Light Support',
    'एडवांस्ड लाइट सपोर्ट',
  );

  String? _selectedSystemId;
  String? get selectedSystemId => _selectedSystemId;

  final List<SystemItem> systems = const [
    SystemItem(
      id: 'eng_sys',
      title: L10nText('Engine System', 'इंजन सिस्टम'),
      description: L10nText(
        'Study engine types, operation, components and working',
        'इंजन प्रकार, संचालन, घटक और कार्यविधि का अध्ययन करें',
      ),
      icon: Icons.settings,
    ),
    SystemItem(
      id: 'trnsmsn_sys',
      title: L10nText('Transmission System', 'ट्रांसमिशन सिस्टम'),
      description: L10nText(
        'Study transmission types, operation, components and gear mechanism',
        'ट्रांसमिशन प्रकार, संचालन, घटक और गियर तंत्र का अध्ययन करें',
      ),
      icon: Icons.settings_suggest,
    ),
    SystemItem(
      id: 'brake_sys',
      title: L10nText('Brake System', 'ब्रेक सिस्टम'),
      description: L10nText(
        'Learn braking components, hydraulics and safety systems',
        'ब्रेकिंग घटक, हाइड्रोलिक्स और सुरक्षा सिस्टम सीखें',
      ),
      icon: Icons.disc_full,
    ),
    SystemItem(
      id: 'fuel_sys',
      title: L10nText('Fuel System', 'फ्यूल सिस्टम'),
      description: L10nText(
        'Explore fuel delivery, injection and filtration components',
        'ईंधन वितरण, इंजेक्शन और फ़िल्ट्रेशन घटक देखें',
      ),
      icon: Icons.local_gas_station,
    ),
    SystemItem(
      id: 'suspension_sys',
      title: L10nText('Suspension System', 'सस्पेंशन सिस्टम'),
      description: L10nText(
        'Understand springs, dampers and axle configurations',
        'स्प्रिंग, डैम्पर और एक्सल विन्यास समझें',
      ),
      icon: Icons.alt_route,
    ),
    SystemItem(
      id: 'steering_sys',
      title: L10nText('Steering System', 'स्टीयरिंग सिस्टम'),
      description: L10nText(
        'Learn steering gear, linkages and power assist systems',
        'स्टीयरिंग गियर, लिंकेज और पावर असिस्ट सिस्टम सीखें',
      ),
      icon: Icons.rotate_right,
    ),
    SystemItem(
      id: 'electrical_sys',
      title: L10nText('Electrical System', 'इलेक्ट्रिकल सिस्टम'),
      description: L10nText(
        'Study battery, charging, lighting and wiring circuits',
        'बैटरी, चार्जिंग, लाइटिंग और वायरिंग सर्किट का अध्ययन करें',
      ),
      icon: Icons.electrical_services,
    ),
    SystemItem(
      id: 'electronic_sys',
      title: L10nText('Electronic System', 'इलेक्ट्रॉनिक सिस्टम'),
      description: L10nText(
        'Explore sensors, ECUs and electronic control modules',
        'सेंसर, ECU और इलेक्ट्रॉनिक कंट्रोल मॉड्यूल देखें',
      ),
      icon: Icons.memory,
    ),
    SystemItem(
      id: 'faults',
      title: L10nText(
        'Running Faults & Remedies',
        'चलते फॉल्ट्स और उपाय',
      ),
      description: L10nText(
        'Diagnose common faults and apply corrective remedies',
        'सामान्य फॉल्ट्स का निदान करें और सुधारात्मक उपाय लागू करें',
      ),
      icon: Icons.warning_amber_rounded,
      hasModules: false,
    ),
    SystemItem(
      id: 'maint',
      title: L10nText('Maintenance', 'रखरखाव'),
      description: L10nText(
        'Scheduled servicing, inspection and preventive maintenance',
        'निर्धारित सर्विसिंग, निरीक्षण और निवारक रखरखाव',
      ),
      icon: Icons.build_circle_outlined,
      hasModules: false,
    ),
    SystemItem(
      id: 'esp',
      title: L10nText('ESP', 'ESP'),
      description: L10nText(
        'Electronic Stability Program — operation and diagnostics',
        'इलेक्ट्रॉनिक स्टेबिलिटी प्रोग्राम — संचालन और डायग्नोस्टिक्स',
      ),
      icon: Icons.speed,
      hasModules: false,
    ),
  ];

  void selectSystem(String id) {
    _selectedSystemId = id;
    notifyListeners();
  }
}
