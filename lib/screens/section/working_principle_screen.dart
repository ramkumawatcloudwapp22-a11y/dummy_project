import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../models/working_principle.dart';
import '../../providers/working_principle_provider.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_breadcrumb.dart';
import '../../widgets/brand_header.dart';

class WorkingPrincipleScreen extends StatelessWidget {
  const WorkingPrincipleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WorkingPrincipleProvider(),
      child: const _WorkingPrincipleView(),
    );
  }
}

class _WorkingPrincipleView extends StatelessWidget {
  const _WorkingPrincipleView();

  @override
  Widget build(BuildContext context) {
    final wp = context.watch<WorkingPrincipleProvider>();
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
              WorkingPrincipleProvider.title.of(context),
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              WorkingPrincipleProvider.subtitle.of(context),
              style: const TextStyle(color: AppColors.mutedGreen, fontSize: 11),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: wp.toggleBookmark,
            icon: Icon(
              wp.bookmarked ? Icons.bookmark : Icons.bookmark_border,
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
              BreadcrumbItem(label: l10n.workingPrinciple),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              children: [
                const _OverviewCard(),
                const SizedBox(height: 16),
                _SectionLabel(
                  icon: Icons.psychology_outlined,
                  title: l10n.topics,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: wp.topics.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final topic = wp.topics[index];
                      final selected = index == wp.selectedTopicIndex;
                      return ChoiceChip(
                        label: Text(topic.title.of(context)),
                        selected: selected,
                        onSelected: (_) => wp.selectTopic(index),
                        selectedColor: AppColors.accentGreen.withValues(
                          alpha: 0.25,
                        ),
                        backgroundColor: AppColors.bgCard,
                        labelStyle: TextStyle(
                          color: selected
                              ? AppColors.accentGreen
                              : AppColors.textWhite,
                          fontSize: 12,
                          fontWeight:
                              selected ? FontWeight.w700 : FontWeight.w500,
                        ),
                        side: BorderSide(
                          color: selected
                              ? AppColors.accentGreen
                              : AppColors.borderMuted,
                        ),
                        showCheckmark: false,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                _TopicCard(topic: wp.selectedTopic),
                const SizedBox(height: 20),
                _SectionLabel(
                  icon: Icons.loop,
                  title: l10n.fourStrokeCycle,
                ),
                const SizedBox(height: 12),
                ...List.generate(wp.cycleSteps.length, (index) {
                  final step = wp.cycleSteps[index];
                  final selected = index == wp.selectedCycleIndex;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _CycleStepCard(
                      step: step,
                      selected: selected,
                      onTap: () => wp.selectCycleStep(index),
                    ),
                  );
                }),
                const SizedBox(height: 12),
                _SectionLabel(
                  icon: Icons.check_circle_outline,
                  title: l10n.keyPoints,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderMuted),
                  ),
                  child: Column(
                    children: wp.keyPoints.map((point) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
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
                                point.of(context),
                                style: TextStyle(
                                  color: AppColors.textWhite.withValues(
                                    alpha: 0.85,
                                  ),
                                  fontSize: 13,
                                  height: 1.35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _SectionLabel(
                      icon: Icons.folder_open_outlined,
                      title: l10n.learningResources,
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
                    itemCount: wp.resources.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      return _ResourceCard(resource: wp.resources[index]);
                    },
                  ),
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

class _OverviewCard extends StatelessWidget {
  const _OverviewCard();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentGreen.withValues(alpha: 0.18),
            ),
            child: const Icon(
              Icons.psychology_outlined,
              color: AppColors.accentGreen,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.overview,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  WorkingPrincipleProvider.overview.of(context),
                  style: const TextStyle(
                    color: AppColors.mutedGreen,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionLabel({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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

class _TopicCard extends StatelessWidget {
  final PrincipleSection topic;

  const _TopicCard({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(topic.icon, color: AppColors.accentGreen, size: 20),
              const SizedBox(width: 8),
              Text(
                topic.title.of(context),
                style: const TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            topic.body.of(context),
            style: TextStyle(
              color: AppColors.textWhite.withValues(alpha: 0.8),
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _CycleStepCard extends StatelessWidget {
  final CycleStep step;
  final bool selected;
  final VoidCallback onTap;

  const _CycleStepCard({
    required this.step,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          decoration: BoxDecoration(
            color: selected
                ? AppColors.accentGreen.withValues(alpha: 0.12)
                : AppColors.bgCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.accentGreen : AppColors.borderMuted,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentGreen.withValues(alpha: 0.15),
                  ),
                  child: Icon(step.icon, color: AppColors.accentGreen, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title.of(context),
                        style: TextStyle(
                          color: selected
                              ? AppColors.accentGreen
                              : AppColors.textWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        step.description.of(context),
                        style: TextStyle(
                          color: AppColors.textWhite.withValues(alpha: 0.7),
                          fontSize: 12,
                          height: 1.35,
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

class _ResourceCard extends StatelessWidget {
  final PrincipleResource resource;

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
