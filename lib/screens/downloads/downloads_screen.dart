import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../models/download_item.dart';
import '../../providers/downloads_provider.dart';
import '../../widgets/app_breadcrumb.dart';
import '../../widgets/brand_header.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DownloadsProvider(),
      child: const _DownloadsView(),
    );
  }
}

class _DownloadsView extends StatelessWidget {
  const _DownloadsView();

  @override
  Widget build(BuildContext context) {
    final downloads = context.watch<DownloadsProvider>();
    final l10n = context.l10n;

    return ColoredBox(
      color: AppColors.bgDark,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _Header(),
            AppBreadcrumb(
              items: [
                BreadcrumbItem(label: l10n.home, isHome: true),
                BreadcrumbItem(label: l10n.trainingCenter),
                BreadcrumbItem(label: l10n.downloads),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F7F4),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                  children: [
                    _StorageCard(downloads: downloads),
                    const SizedBox(height: 16),
                    _CategoryTabs(downloads: downloads),
                    const SizedBox(height: 16),
                    ...downloads.visibleSections.map((section) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: _CategorySection(
                          category: section,
                          downloads: downloads,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: AppColors.textWhite),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  DownloadsProvider.title.of(context),
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  DownloadsProvider.subtitle.of(context),
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.textWhite),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune, color: AppColors.textWhite),
          ),
          const TechYodhaEmblem(size: 34),
        ],
      ),
    );
  }
}

class _StorageCard extends StatelessWidget {
  final DownloadsProvider downloads;

  const _StorageCard({required this.downloads});

  @override
  Widget build(BuildContext context) {
    final pct = (downloads.usedPercent * 100).round();
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.storageUsage,
            style: const TextStyle(
              color: Color(0xFF1A2A1A),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              SizedBox(
                width: 84,
                height: 84,
                child: CustomPaint(
                  painter: _DonutPainter(progress: downloads.usedPercent),
                  child: Center(
                    child: Text(
                      '$pct%\n${l10n.used}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF1A2A1A),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  children: [
                    _StatColumn(
                      label: l10n.used,
                      value: '${downloads.usedGb.toStringAsFixed(2)} GB',
                    ),
                    _StatColumn(
                      label: l10n.available,
                      value: '${downloads.availableGb.toStringAsFixed(2)} GB',
                    ),
                    _StatColumn(
                      label: l10n.totalStorage,
                      value: '${downloads.totalGb.toStringAsFixed(0)} GB',
                      showPhone: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: downloads.usedPercent,
              minHeight: 8,
              backgroundColor: const Color(0xFFE0E5DE),
              valueColor: const AlwaysStoppedAnimation(AppColors.olive),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '${downloads.usedGb.toStringAsFixed(2)} ${l10n.gbOf} ${downloads.totalGb.toStringAsFixed(0)} ${l10n.gbUsed}',
                style: const TextStyle(color: Color(0xFF6B7368), fontSize: 11),
              ),
              const Spacer(),
              Text(
                '$pct${l10n.percentUsed}',
                style: const TextStyle(color: Color(0xFF6B7368), fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  final bool showPhone;

  const _StatColumn({
    required this.label,
    required this.value,
    this.showPhone = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF6B7368), fontSize: 11),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showPhone) ...[
                const Icon(Icons.smartphone, size: 12, color: AppColors.olive),
                const SizedBox(width: 2),
              ],
              Flexible(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF1A2A1A),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double progress;

  _DonutPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    final bg = Paint()
      ..color = const Color(0xFFE0E5DE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    final fg = Paint()
      ..color = AppColors.olive
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bg);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      fg,
    );
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _CategoryTabs extends StatelessWidget {
  final DownloadsProvider downloads;

  const _CategoryTabs({required this.downloads});

  @override
  Widget build(BuildContext context) {
    const tabs = DownloadCategory.values;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((tab) {
          final active = downloads.selectedTab == tab;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => downloads.setTab(tab),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: active ? AppColors.olive : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  downloads.tabLabel(tab).of(context),
                  style: TextStyle(
                    color: active ? AppColors.olive : const Color(0xFF6B7368),
                    fontSize: 13,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  final DownloadCategory category;
  final DownloadsProvider downloads;

  const _CategorySection({
    required this.category,
    required this.downloads,
  });

  @override
  Widget build(BuildContext context) {
    final items = downloads.itemsFor(category);
    final total = downloads.categoryTotals[category] ?? items.length;
    final remaining = downloads.remainingCount(category);
    final l10n = context.l10n;
    final tab = downloads.tabLabel(category).of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              downloads.sectionIcon(category),
              color: AppColors.olive,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              '$tab ($total)',
              style: const TextStyle(
                color: Color(0xFF1A2A1A),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              l10n.viewAll,
              style: const TextStyle(
                color: AppColors.olive,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(Icons.arrow_forward, color: AppColors.olive, size: 14),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              ...List.generate(items.length, (index) {
                final item = items[index];
                return Column(
                  children: [
                    _DownloadTile(item: item),
                    if (index < items.length - 1)
                      const Divider(height: 1, color: Color(0xFFE8EBE6)),
                  ],
                );
              }),
              if (remaining > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    l10n.moreItems(remaining, tab.toLowerCase()),
                    style: const TextStyle(
                      color: AppColors.olive,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DownloadTile extends StatelessWidget {
  final DownloadItem item;

  const _DownloadTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          if (item.isVideo)
            Container(
              width: 56,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [
                    AppColors.olive.withValues(alpha: 0.7),
                    AppColors.bgForest,
                  ],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.play_arrow, color: Colors.white, size: 22),
                  Positioned(
                    right: 4,
                    bottom: 3,
                    child: Text(
                      item.sizeOrDuration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Icon(
              item.leadingIcon ?? Icons.insert_drive_file,
              color: item.leadingColor ?? AppColors.olive,
              size: 28,
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title.of(context),
                  style: const TextStyle(
                    color: Color(0xFF1A2A1A),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${item.sizeOrDuration} • ${item.meta.of(context)}',
                  style: const TextStyle(
                    color: Color(0xFF6B7368),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.date.of(context),
                  style: const TextStyle(
                    color: Color(0xFF8A9286),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: AppColors.success, size: 20),
          const SizedBox(width: 4),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Color(0xFF6B7368)),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
