import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';

class PrincipleSection {
  final String id;
  final L10nText title;
  final L10nText body;
  final IconData icon;

  const PrincipleSection({
    required this.id,
    required this.title,
    required this.body,
    required this.icon,
  });
}

class CycleStep {
  final L10nText title;
  final L10nText description;
  final IconData icon;

  const CycleStep({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class PrincipleResource {
  final L10nText title;
  final String meta;
  final IconData icon;
  final Color iconColor;

  const PrincipleResource({
    required this.title,
    required this.meta,
    required this.icon,
    required this.iconColor,
  });
}
