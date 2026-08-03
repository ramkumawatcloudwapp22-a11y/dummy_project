import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../models/vehicle_category.dart';
import '../../providers/b_veh_provider.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_breadcrumb.dart';
import '../../widgets/drill_down_app_bar.dart';
import 'als_screen.dart';

class BVehScreen extends StatelessWidget {
  const BVehScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BVehProvider(),
      child: const _BVehView(),
    );
  }
}

class _BVehView extends StatelessWidget {
  const _BVehView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BVehProvider>();
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: DrillDownAppBar(title: l10n.bVeh),
      body: Column(
        children: [
          AppBreadcrumb(
            items: [
              BreadcrumbItem(
                label: l10n.home,
                isHome: true,
                onTap: () => Navigator.of(context).popUntil((r) => r.isFirst),
              ),
              BreadcrumbItem(label: l10n.section),
              BreadcrumbItem(label: l10n.bVeh),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(painter: _DotGridPainter()),
                ),
                ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                  itemCount: provider.categories.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final category = provider.categories[index];
                    return _CategoryCard(
                      category: category,
                      onTap: () {
                        context.read<BVehProvider>().selectCategory(category.id);
                        if (category.id == 'hy_veh') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              settings: const RouteSettings(name: 'als'),
                              builder: (_) => const AlsScreen(),
                            ),
                          );
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              context.l10nRead.comingSoon(
                                category.title.read(context),
                              ),
                            ),
                            backgroundColor: AppColors.olive,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final VehicleCategory category;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          height: 128,
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderMuted.withValues(alpha: 0.7)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Subtle card grid texture
                Positioned.fill(
                  child: CustomPaint(
                    painter: _DotGridPainter(
                      color: AppColors.accentGreen.withValues(alpha: 0.04),
                      spacing: 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 118,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 0,
                              bottom: -6,
                              right: -8,
                              top: 10,
                              child: Image.asset(
                                category.imageAsset,
                                fit: BoxFit.contain,
                                alignment: Alignment.bottomLeft,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: AppColors.bgCardLight,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.borderMuted,
                                  ),
                                ),
                                child: Icon(
                                  category.icon,
                                  color: AppColors.accentGreen,
                                  size: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              category.title.of(context),
                              style: const TextStyle(
                                color: AppColors.textWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              category.description.of(context),
                              style: TextStyle(
                                color: AppColors.textWhite.withValues(alpha: 0.72),
                                fontSize: 12,
                                height: 1.35,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accentGreen.withValues(alpha: 0.18),
                          border: Border.all(
                            color: AppColors.accentGreen.withValues(alpha: 0.85),
                          ),
                        ),
                        child: const Icon(
                          Icons.chevron_right,
                          color: AppColors.accentGreen,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  final Color color;
  final double spacing;

  _DotGridPainter({
    Color? color,
    this.spacing = 14,
  }) : color = color ?? AppColors.accentGreen.withValues(alpha: 0.05);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (var y = 0.0; y < size.height; y += spacing) {
      for (var x = 0.0; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), 0.8, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.spacing != spacing;
}
