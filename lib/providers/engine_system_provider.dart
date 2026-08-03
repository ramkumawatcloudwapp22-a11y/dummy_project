import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';
import '../models/module_models.dart';

class EngineSystemProvider extends ChangeNotifier {
  static const L10nText title = L10nText('Engine System', 'इंजन सिस्टम');
  static const L10nText subtitle = L10nText(
    'ALS – Advanced Light Support',
    'ALS – एडवांस्ड लाइट सपोर्ट',
  );
  static const L10nText description = L10nText(
    'Explore all topics related to Engine System.',
    'इंजन सिस्टम से जुड़े सभी विषय देखें।',
  );

  String? _selectedModuleId;
  String? get selectedModuleId => _selectedModuleId;

  final List<ModuleCard> modules = const [
    ModuleCard(
      id: 'working_principle',
      title: L10nText('Working Principle', 'कार्य सिद्धांत'),
      description: L10nText(
        'Understand how the engine operates, combustion cycle and power delivery.',
        'इंजन कैसे काम करता है, दहन चक्र और पावर डिलीवरी समझें।',
      ),
      resourceCount: 8,
      icon: Icons.psychology_outlined,
    ),
    ModuleCard(
      id: 'parts',
      title: L10nText('Parts', 'पार्ट्स'),
      description: L10nText(
        'Explore major engine components, assembly and identification.',
        'मुख्य इंजन घटक, असेंबली और पहचान देखें।',
      ),
      resourceCount: 12,
      icon: Icons.precision_manufacturing_outlined,
    ),
    ModuleCard(
      id: 'faults',
      title: L10nText('Faults', 'फॉल्ट्स'),
      description: L10nText(
        'Diagnose common engine faults, causes and recommended remedies.',
        'सामान्य इंजन फॉल्ट्स, कारण और अनुशंसित उपायों का निदान करें।',
      ),
      resourceCount: 10,
      icon: Icons.warning_amber_rounded,
    ),
  ];

  final List<QuickResource> quickResources = const [
    QuickResource(
      id: 'manual',
      title: L10nText(
        'Engine System Manual (PDF)',
        'इंजन सिस्टम मैनुअल (PDF)',
      ),
      meta: '2.4 MB',
      icon: Icons.picture_as_pdf,
      iconColor: Color(0xFFE53935),
    ),
    QuickResource(
      id: 'video',
      title: L10nText(
        'Engine Overview Video',
        'इंजन अवलोकन वीडियो',
      ),
      meta: '15:24',
      icon: Icons.play_circle_fill,
      iconColor: Color(0xFF1E88E5),
    ),
    QuickResource(
      id: 'diagram',
      title: L10nText(
        'Engine System Diagram',
        'इंजन सिस्टम आरेख',
      ),
      meta: '1.8 MB',
      icon: Icons.account_tree_outlined,
      iconColor: Color(0xFF43A047),
    ),
    QuickResource(
      id: 'notes',
      title: L10nText('Study Notes', 'अध्ययन नोट्स'),
      meta: '1.2 MB',
      icon: Icons.sticky_note_2_outlined,
      iconColor: Color(0xFFF9A825),
    ),
  ];

  void selectModule(String id) {
    _selectedModuleId = id;
    notifyListeners();
  }
}
