import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';

class EngineFault {
  final String id;
  final L10nText name;
  final IconData icon;
  final L10nText description;
  final List<L10nText> causes;
  final List<L10nText> remedies;
  final List<FaultResource> resources;

  const EngineFault({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.causes,
    required this.remedies,
    required this.resources,
  });
}

class FaultResource {
  final L10nText title;
  final String meta;
  final IconData icon;
  final Color iconColor;

  const FaultResource({
    required this.title,
    required this.meta,
    required this.icon,
    required this.iconColor,
  });
}
