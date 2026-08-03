import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';

class StatItem {
  final L10nText label;
  final String value;
  final IconData icon;

  const StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });
}

class TechnicalSection {
  final String id;
  final String label;
  final IconData icon;

  const TechnicalSection({
    required this.id,
    required this.label,
    required this.icon,
  });
}

class ActivityItem {
  final L10nText title;
  final L10nText timeAgo;
  final IconData icon;

  const ActivityItem({
    required this.title,
    required this.timeAgo,
    required this.icon,
  });
}
