import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/l10n/locale_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/profile_provider.dart';
import '../../screens/auth/login_screen.dart';
import '../../widgets/brand_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    final l10n = context.l10n;

    return ColoredBox(
      color: AppColors.bgDark,
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const _Header(),
            const SizedBox(height: 12),
            _ProfileHero(profile: profile),
            const SizedBox(height: 16),
            _StatsRow(profile: profile),
            const SizedBox(height: 16),
            _InfoCard(profile: profile),
            const SizedBox(height: 16),
            const _LanguageTile(),
            const SizedBox(height: 12),
            _NotificationsTile(profile: profile),
            const SizedBox(height: 12),
            ...profile.menuItems.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _MenuTile(
                  item: item,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          l10n.comingSoon(item.title.of(context)),
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
            _LogoutButton(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shield, color: AppColors.gold, size: 14),
                const SizedBox(width: 6),
                Text(
                  l10n.indianArmyTechYodha,
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.profile,
            style: const TextStyle(
              color: AppColors.textWhite,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const TechYodhaEmblem(size: 40),
      ],
    );
  }
}

class _ProfileHero extends StatelessWidget {
  final ProfileProvider profile;

  const _ProfileHero({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A2A14), Color(0xFF0C140A)],
        ),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gold, width: 2),
              color: AppColors.bgCard,
            ),
            child: const Icon(Icons.person, color: AppColors.mutedGreen, size: 40),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        profile.name,
                        style: const TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.verified, color: AppColors.gold, size: 16),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  profile.unit.of(context),
                  style: TextStyle(
                    color: AppColors.textWhite.withValues(alpha: 0.75),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.trade.of(context),
                  style: const TextStyle(
                    color: AppColors.accentGreen,
                    fontSize: 12,
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

class _StatsRow extends StatelessWidget {
  final ProfileProvider profile;

  const _StatsRow({required this.profile});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final stats = [
      (l10n.manuals, '${profile.manualsViewed}', Icons.menu_book_outlined),
      (l10n.videos, '${profile.videosWatched}', Icons.videocam_outlined),
      (l10n.downloads, '${profile.downloadsCount}', Icons.download_outlined),
      (l10n.saved, '${profile.bookmarksCount}', Icons.bookmark_outline),
    ];

    return Row(
      children: stats.map((s) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Icon(s.$3, color: AppColors.accentGreen, size: 18),
                const SizedBox(height: 6),
                Text(
                  s.$2,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  s.$1,
                  style: const TextStyle(
                    color: AppColors.mutedGreen,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final ProfileProvider profile;

  const _InfoCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final rows = [
      (l10n.armyNumber, profile.armyNumber, Icons.badge_outlined),
      (l10n.email, profile.email, Icons.email_outlined),
      (l10n.station, profile.station, Icons.location_on_outlined),
      (l10n.rank, profile.rank, Icons.military_tech_outlined),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: Column(
        children: List.generate(rows.length, (i) {
          final row = rows[i];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              border: i == rows.length - 1
                  ? null
                  : const Border(
                      bottom: BorderSide(color: AppColors.border),
                    ),
            ),
            child: Row(
              children: [
                Icon(row.$3, color: AppColors.mutedGreen, size: 18),
                const SizedBox(width: 10),
                Text(
                  row.$1,
                  style: const TextStyle(
                    color: AppColors.mutedGreen,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                Flexible(
                  child: Text(
                    row.$2,
                    style: const TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isHindi = context.isHindi;

    return Material(
      color: AppColors.bgCard,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderMuted),
        ),
        child: SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(
            Icons.language,
            color: AppColors.accentGreen,
          ),
          title: Text(
            l10n.language,
            style: const TextStyle(
              color: AppColors.textWhite,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            isHindi ? l10n.hindi : l10n.english,
            style: const TextStyle(color: AppColors.mutedGreen, fontSize: 12),
          ),
          value: isHindi,
          activeThumbColor: AppColors.accentGreen,
          onChanged: (_) => context.read<LocaleProvider>().toggle(),
        ),
      ),
    );
  }
}

class _NotificationsTile extends StatelessWidget {
  final ProfileProvider profile;

  const _NotificationsTile({required this.profile});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Material(
      color: AppColors.bgCard,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderMuted),
        ),
        child: SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(
            Icons.notifications_outlined,
            color: AppColors.accentGreen,
          ),
          title: Text(
            l10n.notifications,
            style: const TextStyle(
              color: AppColors.textWhite,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            l10n.notificationsSubtitle,
            style: const TextStyle(color: AppColors.mutedGreen, fontSize: 12),
          ),
          value: profile.notificationsEnabled,
          activeThumbColor: AppColors.accentGreen,
          onChanged: profile.toggleNotifications,
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final ProfileMenuItem item;
  final VoidCallback onTap;

  const _MenuTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.accentGreen.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(item.icon, color: AppColors.accentGreen, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title.of(context),
                        style: const TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (item.subtitle != null)
                        Text(
                          item.subtitle!.of(context),
                          style: const TextStyle(
                            color: AppColors.mutedGreen,
                            fontSize: 11,
                          ),
                        ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.textGrey,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.error,
          side: const BorderSide(color: AppColors.error),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.logout, size: 18),
        label: Text(
          l10n.logout,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
