import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class BreadcrumbItem {
  final String label;
  final bool isHome;
  final VoidCallback? onTap;

  const BreadcrumbItem({
    required this.label,
    this.isHome = false,
    this.onTap,
  });
}

class AppBreadcrumb extends StatelessWidget {
  final List<BreadcrumbItem> items;

  const AppBreadcrumb({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: AppColors.textGrey,
                  ),
                ),
              GestureDetector(
                onTap: items[i].onTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (items[i].isHome) ...[
                      Icon(
                        Icons.home,
                        size: 14,
                        color: i == items.length - 1
                            ? AppColors.accentGreen
                            : AppColors.mutedGreen,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      items[i].label,
                      style: TextStyle(
                        color: i == items.length - 1
                            ? AppColors.accentGreen
                            : AppColors.textWhite.withValues(alpha: 0.85),
                        fontSize: 12,
                        fontWeight: i == items.length - 1
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
