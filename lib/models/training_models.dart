import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';

class TrainingCategory {
  final String id;
  final L10nText title;
  final L10nText description;
  final IconData icon;

  const TrainingCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class QuickAccessItem {
  final L10nText label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const QuickAccessItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });
}
