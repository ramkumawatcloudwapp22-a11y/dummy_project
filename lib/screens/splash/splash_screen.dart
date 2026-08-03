import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/splash_provider.dart';
import '../../widgets/brand_header.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashProvider>().startLoading(
            onComplete: () {
              if (!mounted) return;
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const LoginScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
                  transitionDuration: const Duration(milliseconds: 600),
                ),
              );
            },
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Atmospheric military background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A2A1A),
                  Color(0xFF0A120A),
                  Color(0xFF050805),
                  Color(0xFF020402),
                ],
                stops: [0.0, 0.35, 0.7, 1.0],
              ),
            ),
          ),
          // Top glow (sunset sky feel)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 220,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF3D4A28).withValues(alpha: 0.55),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Soft topo-line hints
          Positioned.fill(
            child: CustomPaint(painter: _TopoPainter()),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                const BrandHeader(emblemSize: 130),
                const Spacer(flex: 3),
                // Tagline with flag-colored bars
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.saffron, Colors.transparent],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          l10n.servingNation,
                          style: const TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, AppColors.indiaGreen],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                // Progress bar (Provider-driven)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Consumer<SplashProvider>(
                    builder: (context, splash, _) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: splash.progress,
                              minHeight: 5,
                              backgroundColor: const Color(0xFF2A2A2A),
                              valueColor: const AlwaysStoppedAnimation(
                                AppColors.goldLight,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n.loading,
                            style: const TextStyle(
                              color: AppColors.textWhite,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gold.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 0; i < 6; i++) {
      final path = Path();
      final baseY = size.height * 0.15 + i * 40.0;
      path.moveTo(0, baseY);
      for (var x = 0.0; x < size.width; x += 20) {
        final y = baseY +
            8 * math.sin(x / 40 + i) +
            4 * math.sin(x / 18);
        path.lineTo(x, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
