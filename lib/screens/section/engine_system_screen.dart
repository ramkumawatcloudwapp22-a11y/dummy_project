import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../models/module_models.dart';
import '../../providers/engine_system_provider.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_breadcrumb.dart';
import '../../widgets/drill_down_app_bar.dart';
import 'faults_screen.dart';
import 'parts_screen.dart';
import 'working_principle_screen.dart';

class EngineSystemScreen extends StatelessWidget {
  const EngineSystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EngineSystemProvider(),
      child: const _EngineSystemView(),
    );
  }
}

class _EngineSystemView extends StatelessWidget {
  const _EngineSystemView();

  @override
  Widget build(BuildContext context) {
    final engine = context.watch<EngineSystemProvider>();
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: DrillDownAppBar(
        title: EngineSystemProvider.title.of(context),
        subtitle: EngineSystemProvider.subtitle.of(context),
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
              BreadcrumbItem(
                label: l10n.als,
                onTap: () {
                  Navigator.of(context).popUntil(
                    (route) =>
                        route.isFirst || route.settings.name == 'als',
                  );
                },
              ),
              BreadcrumbItem(label: l10n.engineSystem),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                const _SectionHeader(),
                const SizedBox(height: 14),
                ...engine.modules.map(
                  (module) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _ModuleCardWidget(
                      module: module,
                      onTap: () {
                        context
                            .read<EngineSystemProvider>()
                            .selectModule(module.id);
                        if (module.id == 'parts') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              settings: const RouteSettings(name: 'parts'),
                              builder: (_) => const PartsScreen(),
                            ),
                          );
                          return;
                        }
                        if (module.id == 'faults') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              settings: const RouteSettings(name: 'faults'),
                              builder: (_) => const FaultsScreen(),
                            ),
                          );
                          return;
                        }
                        if (module.id == 'working_principle') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              settings: const RouteSettings(
                                name: 'working_principle',
                              ),
                              builder: (_) => const WorkingPrincipleScreen(),
                            ),
                          );
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              context.l10nRead.comingSoon(
                                module.title.read(context),
                              ),
                            ),
                            backgroundColor: AppColors.olive,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _QuickResourcesSection(resources: engine.quickResources),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.menu_book_outlined,
              color: AppColors.accentGreen,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              l10n.engineSystem,
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          EngineSystemProvider.description.of(context),
          style: const TextStyle(
            color: AppColors.mutedGreen,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _ModuleCardWidget extends StatelessWidget {
  final ModuleCard module;
  final VoidCallback onTap;

  const _ModuleCardWidget({
    required this.module,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderMuted),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentGreen.withValues(alpha: 0.18),
                  ),
                  child: Icon(module.icon, color: AppColors.accentGreen, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        module.title.of(context),
                        style: const TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        module.description.of(context),
                        style: TextStyle(
                          color: AppColors.textWhite.withValues(alpha: 0.7),
                          fontSize: 12,
                          height: 1.35,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.bgCardLight,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.borderMuted),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.description_outlined,
                              size: 12,
                              color: AppColors.accentGreen,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              l10n.resourcesCount(module.resourceCount),
                              style: const TextStyle(
                                color: AppColors.accentGreen,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.olive.withValues(alpha: 0.5),
                        AppColors.bgForest,
                      ],
                    ),
                  ),
                  child: Icon(
                    module.icon,
                    color: AppColors.accentGreen.withValues(alpha: 0.65),
                    size: 30,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.accentGreen),
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    color: AppColors.accentGreen,
                    size: 18,
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

class _QuickResourcesSection extends StatelessWidget {
  final List<QuickResource> resources;

  const _QuickResourcesSection({required this.resources});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        Row(
          children: [
            Text(
              l10n.quickResources,
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Text(
                    l10n.viewAll,
                    style: const TextStyle(
                      color: AppColors.accentGreen,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward,
                    color: AppColors.accentGreen,
                    size: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: resources.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final resource = resources[index];
              return _ResourceCard(resource: resource);
            },
          ),
        ),
      ],
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final QuickResource resource;

  const _ResourceCard({required this.resource});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(resource.icon, color: resource.iconColor, size: 28),
          const Spacer(),
          Text(
            resource.title.of(context),
            style: const TextStyle(
              color: AppColors.textWhite,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            resource.meta,
            style: const TextStyle(
              color: AppColors.textGrey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
