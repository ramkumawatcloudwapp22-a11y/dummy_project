import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../models/training_models.dart';
import '../../providers/training_provider.dart';
import '../../widgets/app_breadcrumb.dart';
import '../../widgets/brand_header.dart';
import 'technical_manuals_screen.dart';

class TrainingCenterScreen extends StatelessWidget {
  /// When true, shows back button (pushed route). When false, used as tab.
  final bool showBack;

  const TrainingCenterScreen({super.key, this.showBack = false});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrainingProvider(),
      child: _TrainingView(showBack: showBack),
    );
  }
}

class _TrainingView extends StatelessWidget {
  final bool showBack;

  const _TrainingView({required this.showBack});

  @override
  Widget build(BuildContext context) {
    final training = context.watch<TrainingProvider>();
    final l10n = context.l10n;

    return ColoredBox(
      color: AppColors.bgDark,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _Header(showBack: showBack),
            AppBreadcrumb(
              items: [
                BreadcrumbItem(
                  label: l10n.home,
                  isHome: true,
                  onTap: showBack
                      ? () => Navigator.of(context).popUntil((r) => r.isFirst)
                      : null,
                ),
                BreadcrumbItem(label: l10n.section),
                BreadcrumbItem(label: l10n.bVeh),
                BreadcrumbItem(label: l10n.heavyVehicle),
                BreadcrumbItem(label: l10n.als),
                BreadcrumbItem(label: l10n.trainingCenter),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                children: [
                  const _WelcomeCard(),
                  const SizedBox(height: 20),
                  _SectionTitle(
                    icon: Icons.grid_view_rounded,
                    title: l10n.exploreLearning,
                    subtitle: l10n.chooseCategory,
                  ),
                  const SizedBox(height: 14),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: training.categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.95,
                    ),
                    itemBuilder: (context, index) {
                      final category = training.categories[index];
                      return _CategoryCard(
                        category: category,
                        onTap: () {
                          context
                              .read<TrainingProvider>()
                              .selectCategory(category.id);
                          if (category.id == 'manuals') {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                settings: const RouteSettings(
                                  name: 'technical_manuals',
                                ),
                                builder: (_) =>
                                    const TechnicalManualsScreen(),
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
                  const SizedBox(height: 22),
                  _SectionTitle(
                    icon: Icons.bolt,
                    title: l10n.quickAccess,
                  ),
                  const SizedBox(height: 12),
                  _QuickAccessRow(items: training.quickAccess),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final bool showBack;

  const _Header({required this.showBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
      child: Row(
        children: [
          if (showBack)
            IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
            )
          else
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.school_outlined, color: AppColors.accentGreen),
            ),
          Expanded(
            child: Column(
              children: [
                Text(
                  TrainingProvider.title.of(context),
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  TrainingProvider.subtitle.of(context),
                  style: const TextStyle(
                    color: AppColors.accentGreen,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.textWhite),
          ),
          const TechYodhaEmblem(size: 36),
        ],
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentGreen.withValues(alpha: 0.18),
            ),
            child: const Icon(
              Icons.school,
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
                  TrainingProvider.welcomeTitle.of(context),
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  TrainingProvider.welcomeBody.of(context),
                  style: const TextStyle(
                    color: AppColors.mutedGreen,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
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
            child: const Icon(
              Icons.menu_book,
              color: AppColors.accentGreen,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const _SectionTitle({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.accentGreen, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: const TextStyle(color: AppColors.mutedGreen, fontSize: 12),
          ),
        ],
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final TrainingCategory category;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentGreen.withValues(alpha: 0.15),
                  ),
                  child: Icon(
                    category.icon,
                    color: AppColors.accentGreen,
                    size: 22,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  category.title.of(context),
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  category.description.of(context),
                  style: const TextStyle(
                    color: AppColors.mutedGreen,
                    fontSize: 11,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      l10n.viewAll,
                      style: const TextStyle(
                        color: AppColors.accentGreen,
                        fontSize: 12,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickAccessRow extends StatelessWidget {
  final List<QuickAccessItem> items;

  const _QuickAccessRow({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: Row(
        children: items.map((item) {
          return Expanded(
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: item.iconColor.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(item.icon, color: item.iconColor, size: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  item.value,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.label.of(context),
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
