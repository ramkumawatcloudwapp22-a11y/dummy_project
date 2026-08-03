import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';

class ModuleCard {
  final String id;
  final L10nText title;
  final L10nText description;
  final int resourceCount;
  final IconData icon;

  const ModuleCard({
    required this.id,
    required this.title,
    required this.description,
    required this.resourceCount,
    required this.icon,
  });
}

class QuickResource {
  final String id;
  final L10nText title;
  final String meta;
  final IconData icon;
  final Color iconColor;

  const QuickResource({
    required this.id,
    required this.title,
    required this.meta,
    required this.icon,
    required this.iconColor,
  });
}
