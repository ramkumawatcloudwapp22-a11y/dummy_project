import 'package:flutter/material.dart';
import '../core/l10n/l10n_text.dart';

enum DownloadCategory { all, manuals, videos, sops, documents }

class DownloadItem {
  final String id;
  final L10nText title;
  final DownloadCategory category;
  final String sizeOrDuration;
  final L10nText meta;
  final L10nText date;
  final IconData? leadingIcon;
  final Color? leadingColor;
  final bool isVideo;

  const DownloadItem({
    required this.id,
    required this.title,
    required this.category,
    required this.sizeOrDuration,
    required this.meta,
    required this.date,
    this.leadingIcon,
    this.leadingColor,
    this.isVideo = false,
  });
}
