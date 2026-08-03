import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/dashboard_provider.dart';
import '../section/b_veh_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dash = context.watch<DashboardProvider>();

    return ColoredBox(
      color: AppColors.bgDark,
      child: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _HeaderBlock(dash: dash)),
            SliverToBoxAdapter(child: _SearchBar(dash: dash)),
            SliverToBoxAdapter(child: _StatsRow(dash: dash)),
            SliverToBoxAdapter(child: _TechnicalSections(dash: dash)),
            const SliverToBoxAdapter(child: _ContinueLearningBanner()),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

// ── Header: Top bar + Profile ────────────────────────────────

class _HeaderBlock extends StatelessWidget {
  final DashboardProvider dash;

  const _HeaderBlock({required this.dash});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0F2113), Color(0xFF0A160C), AppColors.bgDark],
          stops: [0.0, 0.7, 1.0],
        ),
      ),
      child: Column(
        children: [
          _TopBar(badge: dash.notificationCount),
          _ProfileHeader(dash: dash),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final int badge;

  const _TopBar({required this.badge});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: AppColors.textWhite),
          ),
          Expanded(
            child: Text(
              l10n.appName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textWhite,
                ),
              ),
              if (badge > 0)
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final DashboardProvider dash;

  const _ProfileHeader({required this.dash});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.olive, width: 2),
              color: AppColors.bgCard,
            ),
            child: const Icon(Icons.person, color: AppColors.mutedGreen, size: 32),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dash.greeting.of(context),
                  style: TextStyle(
                    color: AppColors.textWhite.withValues(alpha: 0.9),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dash.userName,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.shield, color: AppColors.goldLight, size: 14),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        dash.unit.of(context),
                        style: TextStyle(
                          color: AppColors.gold.withValues(alpha: 0.9),
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Search Bar ───────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final DashboardProvider dash;

  const _SearchBar({required this.dash});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: TextField(
        onChanged: dash.setSearchQuery,
        style: const TextStyle(color: AppColors.textWhite, fontSize: 14),
        decoration: InputDecoration(
          hintText: context.l10n.searchHint,
          hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 13),
          prefixIcon: const Icon(Icons.search, color: AppColors.textGrey),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic, color: AppColors.olive),
          ),
          filled: true,
          fillColor: AppColors.bgCard,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: AppColors.borderMuted),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: AppColors.borderMuted),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: AppColors.accentGreen, width: 1.5),
          ),
        ),
      ),
    );
  }
}

// ── Stats Row ────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final DashboardProvider dash;

  const _StatsRow({required this.dash});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
      child: Row(
        children: dash.stats.map((stat) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 14, 6, 10),
                    child: Column(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1A2E1A),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            stat.icon,
                            color: AppColors.textWhite,
                            size: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          stat.value,
                          style: const TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          stat.label.of(context),
                          style: const TextStyle(
                            color: AppColors.mutedGreen,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 3,
                    decoration: const BoxDecoration(
                      color: AppColors.olive,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── Technical Sections Grid ──────────────────────────────────

class _TechnicalSections extends StatelessWidget {
  final DashboardProvider dash;

  const _TechnicalSections({required this.dash});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                l10n.technicalSections,
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
                        color: AppColors.textGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.chevron_right,
                      color: AppColors.textGrey,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dash.sections.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.88,
            ),
            itemBuilder: (context, index) {
              final section = dash.sections[index];
              return GestureDetector(
                onTap: () {
                  if (section.id == 'b_veh') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        settings: const RouteSettings(name: 'b_veh'),
                        builder: (_) => const BVehScreen(),
                      ),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        context.l10nRead.comingSoon(section.label),
                      ),
                      backgroundColor: AppColors.olive,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.textWhite,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        section.icon,
                        color: AppColors.bgForest,
                        size: 28,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        section.label,
                        style: const TextStyle(
                          color: AppColors.bgForest,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Continue Learning Banner ─────────────────────────────────

class _ContinueLearningBanner extends StatelessWidget {
  const _ContinueLearningBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 110,
          child: Stack(
            children: [
              // Right side atmosphere
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color(0xFF0F2113),
                        const Color(0xFF1A2E1A),
                        AppColors.olive.withValues(alpha: 0.85),
                        AppColors.oliveDark,
                      ],
                      stops: const [0.0, 0.42, 0.55, 1.0],
                    ),
                  ),
                ),
              ),
              // Diagonal cut overlay on left
              Positioned.fill(
                child: CustomPaint(
                  painter: _DiagonalBannerPainter(),
                ),
              ),
              // Soft pattern on right
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: MediaQuery.sizeOf(context).width * 0.45,
                child: Opacity(
                  opacity: 0.25,
                  child: CustomPaint(
                    painter: _TerrainPatternPainter(),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.school,
                                color: AppColors.goldLight,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                context.tr(
                                  'Continue Learning',
                                  'सीखना जारी रखें',
                                ),
                                style: const TextStyle(
                                  color: AppColors.goldLight,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            context.tr(
                              'Enhance your skills with our\ntraining resources',
                              'हमारे प्रशिक्षण संसाधनों से\nअपने कौशल बढ़ाएँ',
                            ),
                            style: TextStyle(
                              color: AppColors.textWhite.withValues(alpha: 0.9),
                              fontSize: 12,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Material(
                      color: AppColors.bgDark.withValues(alpha: 0.7),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.chevron_right,
                            color: AppColors.textWhite,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiagonalBannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.58, 0)
      ..lineTo(size.width * 0.42, size.height)
      ..lineTo(0, size.height)
      ..close();

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0F2113), Color(0xFF142818)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TerrainPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textWhite.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    // Simple mountain/terrain silhouettes
    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..lineTo(size.width * 0.2, size.height * 0.35)
      ..lineTo(size.width * 0.38, size.height * 0.55)
      ..lineTo(size.width * 0.55, size.height * 0.25)
      ..lineTo(size.width * 0.75, size.height * 0.5)
      ..lineTo(size.width, size.height * 0.3);

    canvas.drawPath(path, paint);

    final fill = Paint()
      ..color = AppColors.bgForest.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(fillPath, fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
