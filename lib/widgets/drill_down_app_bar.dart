import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import 'brand_header.dart';

class DrillDownAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const DrillDownAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.onBack,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.bgDark,
      elevation: 0,
      leading: IconButton(
        onPressed: onBack ?? () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
      ),
      title: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: const TextStyle(
                color: AppColors.mutedGreen,
                fontSize: 11,
              ),
            ),
        ],
      ),
      centerTitle: true,
      actions: [
        ...?actions,
        const Padding(
          padding: EdgeInsets.only(right: 12),
          child: TechYodhaEmblem(size: 36),
        ),
      ],
    );
  }
}
