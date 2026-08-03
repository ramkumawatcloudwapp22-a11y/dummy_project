import 'package:flutter/material.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/brand_header.dart';

class DroneScreen extends StatelessWidget {
  const DroneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ColoredBox(
      color: AppColors.bgDark,
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.drone,
                        style: const TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.droneSubtitle,
                        style: const TextStyle(
                          color: AppColors.mutedGreen,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const TechYodhaEmblem(size: 40),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.borderMuted),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accentGreen.withValues(alpha: 0.18),
                    ),
                    child: const Icon(
                      Icons.flight,
                      color: AppColors.accentGreen,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.droneSystems,
                          style: const TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          l10n.droneSystemsDesc,
                          style: const TextStyle(
                            color: AppColors.mutedGreen,
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
            const SizedBox(height: 16),
            Text(
              l10n.quickModules,
              style: const TextStyle(
                color: AppColors.textWhite,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            _ModuleTile(
              icon: Icons.flight_takeoff,
              title: l10n.flightOps,
              subtitle: l10n.flightOpsDesc,
            ),
            _ModuleTile(
              icon: Icons.settings_remote,
              title: l10n.groundControl,
              subtitle: l10n.groundControlDesc,
            ),
            _ModuleTile(
              icon: Icons.videocam_outlined,
              title: l10n.payloadSensors,
              subtitle: l10n.payloadSensorsDesc,
            ),
            _ModuleTile(
              icon: Icons.build_circle_outlined,
              title: l10n.maintenance,
              subtitle: l10n.maintenanceDesc,
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ModuleTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.accentGreen.withValues(alpha: 0.12),
            ),
            child: Icon(icon, color: AppColors.accentGreen, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.mutedGreen,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textGrey, size: 20),
        ],
      ),
    );
  }
}
