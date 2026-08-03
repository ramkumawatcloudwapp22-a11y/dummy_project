import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/l10n/locale_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/auth_widgets.dart';
import '../../widgets/brand_header.dart';
import '../home/main_shell.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final l10n = context.l10n;
    final isHindi = context.isHindi;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A2418),
                  Color(0xFF0D140C),
                  Color(0xFF050805),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 280,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF3A4A28).withValues(alpha: 0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: _LanguageToggle(
                        isHindi: isHindi,
                        onToggle: () =>
                            context.read<LocaleProvider>().toggle(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const BrandHeader(emblemSize: 100, compact: true),
                  const SizedBox(height: 28),
                  // Login card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                    decoration: BoxDecoration(
                      color: AppColors.bgCardLight.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.borderMuted),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.military_tech_outlined,
                          color: AppColors.gold,
                          size: 36,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.welcomeBack,
                          style: const TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.loginContinue,
                          style: const TextStyle(
                            color: AppColors.mutedGreen,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 24),
                        AuthTextField(
                          label: l10n.emailAddress,
                          labelIcon: Icons.email_outlined,
                          hint: l10n.enterEmail,
                          controller: auth.emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          label: l10n.armyNumber,
                          labelIcon: Icons.badge_outlined,
                          hint: l10n.enterArmyNumber,
                          controller: auth.armyNumberController,
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          label: l10n.password,
                          labelIcon: Icons.lock_outline,
                          hint: l10n.enterPassword,
                          controller: auth.passwordController,
                          obscureText: auth.obscurePassword,
                          onToggleObscure: auth.togglePasswordVisibility,
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.gold,
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              l10n.forgotPassword,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        if (auth.errorMessage != null) ...[
                          const SizedBox(height: 10),
                          Text(
                            auth.errorMessage!,
                            style: const TextStyle(
                              color: AppColors.error,
                              fontSize: 13,
                            ),
                          ),
                        ],
                        const SizedBox(height: 18),
                        GradientActionButton(
                          label: l10n.login,
                          leadingIcon: Icons.shield_outlined,
                          isLoading: auth.isLoading,
                          onPressed: () async {
                            final ok = await context
                                .read<AuthProvider>()
                                .login(context.l10nRead);
                            if (ok && context.mounted) {
                              Navigator.of(context).pushReplacement(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) =>
                                          const MainShell(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: AppColors.borderMuted),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                l10n.secureReliable,
                                style: TextStyle(
                                  color: AppColors.textWhite.withValues(alpha: 0.7),
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: AppColors.borderMuted),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shield,
                              color: AppColors.gold,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              l10n.indianArmy,
                              style: const TextStyle(
                                color: AppColors.gold,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Create account link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.dontHaveAccount,
                              style: TextStyle(
                                color: AppColors.textWhite.withValues(alpha: 0.75),
                                fontSize: 13,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const SignupScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                l10n.createAccount,
                                style: const TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l10n.version,
                    style: TextStyle(
                      color: AppColors.textWhite.withValues(alpha: 0.45),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageToggle extends StatelessWidget {
  final bool isHindi;
  final VoidCallback onToggle;

  const _LanguageToggle({
    required this.isHindi,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.bgCard.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderMuted),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'EN',
              style: TextStyle(
                color: isHindi ? AppColors.textGrey : AppColors.gold,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                '|',
                style: TextStyle(
                  color: AppColors.textWhite.withValues(alpha: 0.4),
                  fontSize: 12,
                ),
              ),
            ),
            Text(
              'हिं',
              style: TextStyle(
                color: isHindi ? AppColors.gold : AppColors.textGrey,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
