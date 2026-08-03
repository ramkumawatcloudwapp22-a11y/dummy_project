import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';
import '../models/vehicle_category.dart';

class BVehProvider extends ChangeNotifier {
  final List<VehicleCategory> categories = const [
    VehicleCategory(
      id: 'hy_veh',
      title: L10nText('Heavy Vehicle', 'भारी वाहन'),
      description: L10nText(
        'Heavy duty & combat vehicles used for logistics and operations.',
        'रसद और संचालन के लिए उपयोग होने वाले भारी ड्यूटी और कॉम्बैट वाहन।',
      ),
      icon: Icons.local_shipping_outlined,
      imageAsset: 'assets/images/vehicles/heavy_vehicle.png',
    ),
    VehicleCategory(
      id: 'lt_veh',
      title: L10nText('Light Vehicle', 'हल्का वाहन'),
      description: L10nText(
        'Light utility vehicles for transport and field operations.',
        'परिवहन और फील्ड ऑपरेशन के लिए हल्के यूटिलिटी वाहन।',
      ),
      icon: Icons.directions_car_outlined,
      imageAsset: 'assets/images/vehicles/light_vehicle.png',
    ),
    VehicleCategory(
      id: 'spl_veh',
      title: L10nText('Special Vehicle', 'विशेष वाहन'),
      description: L10nText(
        'Special purpose vehicles designed for specific mission requirements.',
        'विशिष्ट मिशन आवश्यकताओं के लिए डिज़ाइन किए गए विशेष प्रयोजन वाहन।',
      ),
      icon: Icons.security_outlined,
      imageAsset: 'assets/images/vehicles/special_vehicle.png',
    ),
    VehicleCategory(
      id: 'mcs',
      title: L10nText('MCs', 'MCs'),
      description: L10nText(
        'Motor cycles used for reconnaissance and rapid response.',
        'टोही और त्वरित प्रतिक्रिया के लिए उपयोग होने वाली मोटरसाइकिलें।',
      ),
      icon: Icons.two_wheeler_outlined,
      imageAsset: 'assets/images/vehicles/mcs.png',
    ),
  ];

  String? _selectedId;
  String? get selectedId => _selectedId;

  void selectCategory(String id) {
    _selectedId = id;
    notifyListeners();
  }
}
