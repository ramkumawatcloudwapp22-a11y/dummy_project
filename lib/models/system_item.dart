import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';

class SystemItem {
  final String id;
  final L10nText title;
  final L10nText description;
  final IconData icon;
  final bool hasModules;

  const SystemItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.hasModules = true,
  });
}
