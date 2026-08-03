import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../models/engine_fault.dart';
import '../../providers/faults_provider.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_breadcrumb.dart';
import '../../widgets/brand_header.dart';

class FaultsScreen extends StatelessWidget {
  const FaultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FaultsProvider(),
      child: const _FaultsView(),
    );
  }
}

class _FaultsView extends StatelessWidget {
  const _FaultsView();

  @override
  Widget build(BuildContext context) {
    final faults = context.watch<FaultsProvider>();
    final selected = faults.selectedFault;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: AppColors.bgDark,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
        ),
        title: Column(
          children: [
            Text(
              l10n.faults,
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              l10n.engineSystemAls,
              style: const TextStyle(color: AppColors.mutedGreen, fontSize: 11),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => faults.toggleBookmark(selected.id),
            icon: Icon(
              faults.isBookmarked(selected.id)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              color: AppColors.accentGreen,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: TechYodhaEmblem(size: 36),
          ),
        ],
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
              BreadcrumbItem(
                label: l10n.engineSystem,
                onTap: () {
                  Navigator.of(context).popUntil(
                    (route) =>
                        route.isFirst ||
                        route.settings.name == 'engine_system',
                  );
                },
              ),
              BreadcrumbItem(label: l10n.faults),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: faults.setSearchQuery,
                    style: const TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: l10n.searchFaults,
                      prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.accentGreen,
                    side: const BorderSide(color: AppColors.borderMuted),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.tune, size: 18),
                  label: Text(l10n.filter),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 640;
                if (wide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 220,
                        child: _FaultsSidebar(faults: faults),
                      ),
                      const VerticalDivider(width: 1, color: AppColors.border),
                      Expanded(child: _FaultDetail(faults: faults)),
                    ],
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 180,
                      child: _FaultsSidebar(faults: faults),
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    Expanded(child: _FaultDetail(faults: faults)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _FaultsSidebar extends StatelessWidget {
  final FaultsProvider faults;

  const _FaultsSidebar({required this.faults});

  @override
  Widget build(BuildContext context) {
    final list = faults.filteredFaults;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            l10n.engineFaults,
            style: const TextStyle(
              color: AppColors.accentGreen,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
        ),
        Expanded(
          child: list.isEmpty
              ? Center(
                  child: Text(
                    l10n.noFaultsFound,
                    style: const TextStyle(color: AppColors.textGrey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 8),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final fault = list[index];
                    final selected = index == faults.selectedIndex;
                    return InkWell(
                      onTap: () => faults.selectFault(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.accentGreen.withValues(alpha: 0.18)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              fault.icon,
                              size: 18,
                              color: selected
                                  ? AppColors.accentGreen
                                  : AppColors.mutedGreen,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${index + 1}. ${fault.name.of(context)}',
                                style: TextStyle(
                                  color: selected
                                      ? AppColors.accentGreen
                                      : AppColors.textWhite,
                                  fontSize: 13,
                                  fontWeight: selected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              size: 16,
                              color: AppColors.textGrey,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _FaultDetail extends StatelessWidget {
  final FaultsProvider faults;

  const _FaultDetail({required this.faults});

  @override
  Widget build(BuildContext context) {
    final fault = faults.selectedFault;
    final l10n = context.l10n;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${faults.selectedIndex + 1}. ${fault.name.of(context)}',
                style: const TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            IconButton(
              onPressed: () => faults.toggleBookmark(fault.id),
              icon: Icon(
                faults.isBookmarked(fault.id)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: AppColors.accentGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.olive.withValues(alpha: 0.4),
                AppColors.bgCard,
              ],
            ),
            border: Border.all(color: AppColors.borderMuted),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.settings,
                size: 64,
                color: AppColors.accentGreen.withValues(alpha: 0.5),
              ),
              Positioned(
                right: 20,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.bgDark.withValues(alpha: 0.7),
                    border: Border.all(color: AppColors.error, width: 2),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.error,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _SectionTitle(icon: Icons.description_outlined, title: l10n.description),
        const SizedBox(height: 8),
        Text(
          fault.description.of(context),
          style: TextStyle(
            color: AppColors.textWhite.withValues(alpha: 0.8),
            fontSize: 13,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 18),
        _SectionTitle(
          icon: Icons.warning_amber_rounded,
          title: l10n.possibleCauses,
        ),
        const SizedBox(height: 8),
        ...fault.causes.map(
          (c) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•  ',
                  style: TextStyle(
                    color: AppColors.accentGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Text(
                    c.of(context),
                    style: TextStyle(
                      color: AppColors.textWhite.withValues(alpha: 0.85),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _SectionTitle(
          icon: Icons.build_circle_outlined,
          title: l10n.recommendedRemedies,
        ),
        const SizedBox(height: 8),
        ...List.generate(fault.remedies.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${i + 1}.  ',
                  style: const TextStyle(
                    color: AppColors.accentGreen,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: Text(
                    fault.remedies[i].of(context),
                    style: TextStyle(
                      color: AppColors.textWhite.withValues(alpha: 0.85),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
        _SectionTitle(icon: Icons.menu_book_outlined, title: l10n.resources),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: fault.resources.map((r) {
            return SizedBox(
              width: 150,
              child: _ResourceCard(resource: r),
            );
          }).toList(),
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderMuted),
          ),
          child: Column(
            children: [
              Text(
                l10n.wasThisHelpful,
                style: const TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _FeedbackChip(
                    icon: Icons.thumb_up_outlined,
                    label: l10n.yes,
                    selected: faults.wasHelpful == true,
                    onTap: () => faults.setHelpful(true),
                  ),
                  const SizedBox(width: 12),
                  _FeedbackChip(
                    icon: Icons.thumb_down_outlined,
                    label: l10n.no,
                    selected: faults.wasHelpful == false,
                    onTap: () => faults.setHelpful(false),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.accentGreen,
              side: const BorderSide(color: AppColors.accentGreen),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.flag_outlined, size: 18),
            label: Text(l10n.reportIssue),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accentGreen, size: 18),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textWhite,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final FaultResource resource;

  const _ResourceCard({required this.resource});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(resource.icon, color: resource.iconColor, size: 26),
          const SizedBox(height: 10),
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
            style: const TextStyle(color: AppColors.textGrey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _FeedbackChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FeedbackChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.accentGreen.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.accentGreen : AppColors.borderMuted,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: selected ? AppColors.accentGreen : AppColors.textGrey,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? AppColors.accentGreen : AppColors.textGrey,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
