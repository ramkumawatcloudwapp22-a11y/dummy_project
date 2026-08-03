import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';

class VehicleCategory {
  final String id;
  final L10nText title;
  final L10nText description;
  final IconData icon;
  final String imageAsset;

  const VehicleCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.imageAsset,
  });
}
