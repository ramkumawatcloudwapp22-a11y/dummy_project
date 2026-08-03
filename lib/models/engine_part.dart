import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';

class EnginePart {
  final String id;
  final L10nText name;
  final IconData icon;
  final L10nText overview;
  final List<L10nText> keyFunctions;
  final Map<L10nText, L10nText> specs;
  final List<LearningResource> resources;
  final bool bookmarked;

  const EnginePart({
    required this.id,
    required this.name,
    required this.icon,
    required this.overview,
    required this.keyFunctions,
    required this.specs,
    required this.resources,
    this.bookmarked = false,
  });
}

class LearningResource {
  final L10nText title;
  final String meta;
  final IconData icon;
  final Color iconColor;

  const LearningResource({
    required this.title,
    required this.meta,
    required this.icon,
    required this.iconColor,
  });
}
