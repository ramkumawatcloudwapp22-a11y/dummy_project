import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../models/system_item.dart';
import '../../providers/als_provider.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_breadcrumb.dart';
import '../../widgets/drill_down_app_bar.dart';
import 'engine_system_screen.dart';

class AlsScreen extends StatelessWidget {
  const AlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AlsProvider(),
      child: const _AlsView(),
    );
  }
}

class _AlsView extends StatelessWidget {
  const _AlsView();

  @override
  Widget build(BuildContext context) {
    final als = context.watch<AlsProvider>();
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: DrillDownAppBar(
        title: l10n.als,
        subtitle: l10n.advancedLightSupport,
      ),
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
              BreadcrumbItem(
                label: l10n.bVeh,
                onTap: () {
                  Navigator.of(context).popUntil(
                    (route) =>
                        route.isFirst || route.settings.name == 'b_veh',
                  );
                },
              ),
              BreadcrumbItem(label: l10n.heavyVehicle),
              BreadcrumbItem(label: l10n.als),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                const _AlsHeader(),
                const SizedBox(height: 8),
                ...List.generate(als.systems.length, (index) {
                  final system = als.systems[index];
                  return Column(
                    children: [
                      _SystemTile(
                        system: system,
                        onTap: () {
                          context.read<AlsProvider>().selectSystem(system.id);
                          if (system.id == 'eng_sys') {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                settings: const RouteSettings(
                                  name: 'engine_system',
                                ),
                                builder: (_) => const EngineSystemScreen(),
                              ),
                            );
                            return;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                context.l10nRead.comingSoon(
                                  system.title.read(context),
                                ),
                              ),
                              backgroundColor: AppColors.olive,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      if (index < als.systems.length - 1)
                        const Divider(
                          color: AppColors.border,
                          height: 1,
                          indent: 56,
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _AlsHeader extends StatelessWidget {
  const _AlsHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.alsSystems,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.selectSystem,
                  style: const TextStyle(
                    color: AppColors.mutedGreen,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 100,
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.olive.withValues(alpha: 0.5),
                  AppColors.bgCard,
                ],
              ),
              border: Border.all(color: AppColors.borderMuted),
            ),
            child: const Icon(
              Icons.local_shipping,
              color: AppColors.accentGreen,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}

class _SystemTile extends StatelessWidget {
  final SystemItem system;
  final VoidCallback onTap;

  const _SystemTile({
    required this.system,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.borderMuted),
              ),
              child: Icon(
                system.icon,
                color: AppColors.mutedGreen,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    system.title.of(context),
                    style: const TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    system.description.of(context),
                    style: const TextStyle(
                      color: AppColors.mutedGreen,
                      fontSize: 12,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textGrey,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
