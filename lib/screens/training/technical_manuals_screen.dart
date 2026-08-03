import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../models/technical_manual.dart';
import '../../providers/manual_provider.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/app_breadcrumb.dart';
import '../../widgets/brand_header.dart';

class TechnicalManualsScreen extends StatelessWidget {
  const TechnicalManualsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ManualProvider(),
      child: const _ManualsView(),
    );
  }
}

class _ManualsView extends StatelessWidget {
  const _ManualsView();

  @override
  Widget build(BuildContext context) {
    final manuals = context.watch<ManualProvider>();
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
              ManualProvider.title.of(context),
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              ManualProvider.subtitle.of(context),
              style: const TextStyle(color: AppColors.mutedGreen, fontSize: 11),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showSearch(context),
            icon: const Icon(Icons.search, color: AppColors.textWhite),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune, color: AppColors.textWhite),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: TechYodhaEmblem(size: 34),
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
              BreadcrumbItem(label: l10n.bVeh),
              BreadcrumbItem(label: l10n.heavyVehicle),
              BreadcrumbItem(label: l10n.als),
              BreadcrumbItem(
                label: l10n.trainingCenter,
                onTap: () => Navigator.of(context).maybePop(),
              ),
              BreadcrumbItem(label: l10n.technicalManuals),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                const _HeroCard(),
                const SizedBox(height: 18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.manualsList,
                            style: const TextStyle(
                              color: AppColors.textWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            ManualProvider.listSubtitle.of(context),
                            style: const TextStyle(
                              color: AppColors.mutedGreen,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.olive),
                        color: AppColors.olive.withValues(alpha: 0.2),
                      ),
                      child: Text(
                        l10n.manualsCount(manuals.count),
                        style: const TextStyle(
                          color: AppColors.accentGreen,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (manuals.manuals.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        l10n.noManualsFound,
                        style: const TextStyle(color: AppColors.textGrey),
                      ),
                    ),
                  )
                else
                  ...List.generate(manuals.manuals.length, (index) {
                    final manual = manuals.manuals[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _ManualCard(
                        index: index + 1,
                        manual: manual,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                context.l10nRead.openingManual(
                                  manual.title.read(context),
                                ),
                              ),
                              backgroundColor: AppColors.olive,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                const SizedBox(height: 8),
                const _HelpCard(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }

  void _showSearch(BuildContext context) {
    final provider = context.read<ManualProvider>();
    final l10n = context.l10nRead;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: TextField(
            autofocus: true,
            onChanged: provider.setSearchQuery,
            style: const TextStyle(color: AppColors.textWhite),
            decoration: InputDecoration(
              hintText: l10n.searchManuals,
              prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
            ),
          ),
        );
      },
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

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
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentGreen.withValues(alpha: 0.18),
            ),
            child: const Icon(
              Icons.menu_book,
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
                  l10n.technicalManuals,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  ManualProvider.heroDescription.of(context),
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
            width: 72,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.olive.withValues(alpha: 0.55),
                  AppColors.bgForest,
                ],
              ),
            ),
            child: const Icon(
              Icons.local_shipping,
              color: AppColors.accentGreen,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

class _ManualCard extends StatelessWidget {
  final int index;
  final TechnicalManual manual;
  final VoidCallback onTap;

  const _ManualCard({
    required this.index,
    required this.manual,
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
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.olive.withValues(alpha: 0.7),
                        AppColors.bgForest,
                      ],
                    ),
                    border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.menu_book, color: AppColors.gold, size: 22),
                      const SizedBox(height: 4),
                      Text(
                        l10n.pdf,
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$index. ${manual.title.of(context)}',
                        style: const TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        manual.description.of(context),
                        style: TextStyle(
                          color: AppColors.textWhite.withValues(alpha: 0.65),
                          fontSize: 12,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.picture_as_pdf,
                            color: AppColors.accentGreen,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n.pdfMeta(
                              manual.fileSizeLabel,
                              manual.pageCount,
                            ),
                            style: const TextStyle(
                              color: AppColors.mutedGreen,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.textGrey,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HelpCard extends StatelessWidget {
  const _HelpCard();

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
        children: [
          const Icon(Icons.info_outline, color: AppColors.accentGreen, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.needHelpManual,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.accentGreen,
              side: const BorderSide(color: AppColors.olive),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              l10n.requestManual,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
