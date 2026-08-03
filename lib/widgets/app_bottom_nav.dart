import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/l10n/l10n_ext.dart';
import '../core/theme/app_colors.dart';
import '../providers/nav_provider.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  void _onTap(BuildContext context, int index) {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.popUntil((route) => route.isFirst);
    }
    context.read<NavProvider>().setIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavProvider>();
    final l10n = context.l10n;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgDark,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Row(
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: l10n.home,
                isActive: nav.currentIndex == 0,
                onTap: () => _onTap(context, 0),
              ),
              _NavItem(
                icon: Icons.school_outlined,
                activeIcon: Icons.school,
                label: l10n.training,
                isActive: nav.currentIndex == 1,
                onTap: () => _onTap(context, 1),
              ),
              _NavItem(
                icon: Icons.flight_outlined,
                activeIcon: Icons.flight,
                label: l10n.drone,
                isActive: nav.currentIndex == 2,
                onTap: () => _onTap(context, 2),
              ),
              _NavItem(
                icon: Icons.download_outlined,
                activeIcon: Icons.download,
                label: l10n.downloads,
                isActive: nav.currentIndex == 3,
                onTap: () => _onTap(context, 3),
              ),
              _NavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: l10n.profile,
                isActive: nav.currentIndex == 4,
                onTap: () => _onTap(context, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.accentGreen : AppColors.textGrey;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.accentGreen.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isActive ? activeIcon : icon, color: color, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
