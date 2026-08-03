import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../models/engine_part.dart';
import '../../providers/parts_provider.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_breadcrumb.dart';
import '../../widgets/brand_header.dart';

class PartsScreen extends StatelessWidget {
  const PartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PartsProvider(),
      child: const _PartsView(),
    );
  }
}

class _PartsView extends StatelessWidget {
  const _PartsView();

  @override
  Widget build(BuildContext context) {
    final parts = context.watch<PartsProvider>();
    final selected = parts.selectedPart;
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
              l10n.parts,
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
            onPressed: () => parts.toggleBookmark(selected.id),
            icon: Icon(
              parts.isBookmarked(selected.id)
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
              BreadcrumbItem(label: l10n.parts),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: parts.setSearchQuery,
                    style: const TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: l10n.searchEngineParts,
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
                        width: 200,
                        child: _PartsSidebar(parts: parts),
                      ),
                      const VerticalDivider(
                        width: 1,
                        color: AppColors.border,
                      ),
                      Expanded(child: _PartDetail(parts: parts)),
                    ],
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                      height: 168,
                      child: _PartsSidebar(parts: parts),
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    Expanded(child: _PartDetail(parts: parts)),
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

class _PartsSidebar extends StatelessWidget {
  final PartsProvider parts;

  const _PartsSidebar({required this.parts});

  @override
  Widget build(BuildContext context) {
    final list = parts.filteredParts;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            l10n.engineParts,
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
                    l10n.noPartsFound,
                    style: const TextStyle(color: AppColors.textGrey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 8),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final part = list[index];
                    final selected = index == parts.selectedIndex;
                    return InkWell(
                      onTap: () => parts.selectPart(index),
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
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppColors.bgCard,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.borderMuted),
                              ),
                              child: Icon(
                                part.icon,
                                size: 16,
                                color: AppColors.mutedGreen,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${index + 1}. ${part.name.of(context)}',
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

class _PartDetail extends StatelessWidget {
  final PartsProvider parts;

  const _PartDetail({required this.parts});

  @override
  Widget build(BuildContext context) {
    final part = parts.selectedPart;
    final l10n = context.l10n;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${parts.selectedIndex + 1}. ${part.name.of(context)}',
                style: const TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            IconButton(
              onPressed: () => parts.toggleBookmark(part.id),
              icon: Icon(
                parts.isBookmarked(part.id)
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: AppColors.accentGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          height: 180,
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
          child: PageView.builder(
            itemCount: 5,
            onPageChanged: parts.setImageIndex,
            itemBuilder: (context, index) {
              return Center(
                child: Icon(
                  part.icon,
                  size: 72,
                  color: AppColors.accentGreen.withValues(alpha: 0.7),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (i) {
            final active = i == parts.imageIndex;
            return Container(
              width: active ? 8 : 6,
              height: active ? 8 : 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? AppColors.accentGreen : AppColors.borderMuted,
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        _SectionTitle(icon: Icons.description_outlined, title: l10n.overview),
        const SizedBox(height: 8),
        Text(
          part.overview.of(context),
          style: TextStyle(
            color: AppColors.textWhite.withValues(alpha: 0.8),
            fontSize: 13,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 18),
        _SectionTitle(icon: Icons.star_outline, title: l10n.keyFunctions),
        const SizedBox(height: 8),
        ...part.keyFunctions.map(
          (fn) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppColors.accentGreen,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    fn.of(context),
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
          icon: Icons.settings_outlined,
          title: l10n.technicalSpecification,
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderMuted),
          ),
          child: Column(
            children: part.specs.entries.map((e) {
              final isLast = e.key == part.specs.keys.last;
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: isLast
                      ? null
                      : const Border(
                          bottom: BorderSide(color: AppColors.border),
                        ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        e.key.of(context),
                        style: const TextStyle(
                          color: AppColors.mutedGreen,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      e.value.of(context),
                      style: const TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
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
                icon: const Icon(Icons.view_in_ar, size: 18),
                label: Text(l10n.viewIn3d),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
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
                icon: const Icon(Icons.hub_outlined, size: 18),
                label: Text(l10n.explodedView),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              l10n.learningResources,
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
            itemCount: part.resources.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final r = part.resources[index];
              return _ResourceCard(resource: r);
            },
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
  final LearningResource resource;

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
            style: const TextStyle(color: AppColors.textGrey, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
