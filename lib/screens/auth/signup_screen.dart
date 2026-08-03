import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/l10n/l10n_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/signup_provider.dart';
import '../../widgets/auth_widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupProvider(),
      child: const _SignupView(),
    );
  }
}

class _SignupView extends StatelessWidget {
  const _SignupView();

  Future<void> _pickDob(BuildContext context) async {
    final signup = context.read<SignupProvider>();
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: signup.dateOfBirth ?? DateTime(now.year - 20),
      firstDate: DateTime(1950),
      lastDate: DateTime(now.year - 16),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.accentGreen,
              surface: AppColors.bgCard,
              onSurface: AppColors.textWhite,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      signup.setDateOfBirth(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signup = context.watch<SignupProvider>();
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: AppColors.bgDark,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
        ),
        title: Text(
          l10n.createAccount,
          style: const TextStyle(
            color: AppColors.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.joinTechYodha,
                style: const TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.createAccountSubtitle,
                style: TextStyle(
                  color: AppColors.textWhite.withValues(alpha: 0.65),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                l10n.selectCategory,
                style: const TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _CategoryCard(
                      title: l10n.agniveer,
                      subtitle: l10n.agniveerDesc,
                      icon: Icons.person,
                      selected: signup.category == UserCategory.agniveer,
                      onTap: () => context
                          .read<SignupProvider>()
                          .setCategory(UserCategory.agniveer),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _CategoryCard(
                      title: l10n.jco,
                      subtitle: l10n.jcoDesc,
                      icon: Icons.military_tech,
                      selected: signup.category == UserCategory.jco,
                      onTap: () => context
                          .read<SignupProvider>()
                          .setCategory(UserCategory.jco),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _CategoryCard(
                      title: l10n.officers,
                      subtitle: l10n.officersDesc,
                      icon: Icons.workspace_premium,
                      selected: signup.category == UserCategory.officers,
                      onTap: () => context
                          .read<SignupProvider>()
                          .setCategory(UserCategory.officers),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const _ArmyNumberFormatBox(),
              const SizedBox(height: 18),
              AuthTextField(
                label: l10n.armyNumber,
                fieldIcon: Icons.badge_outlined,
                hint: l10n.enterArmyNumberHint,
                controller: signup.armyNumberController,
                helperText: l10n.armyNumberHintNote,
              ),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AuthTextField(
                      label: l10n.fullName,
                      fieldIcon: Icons.person_outline,
                      hint: l10n.enterFullName,
                      controller: signup.fullNameController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AuthTextField(
                      label: l10n.dateOfBirth,
                      fieldIcon: Icons.calendar_today_outlined,
                      hint: l10n.dobHint,
                      controller: signup.dobController,
                      readOnly: true,
                      onTap: () => _pickDob(context),
                      suffix: IconButton(
                        onPressed: () => _pickDob(context),
                        icon: const Icon(
                          Icons.calendar_month,
                          color: AppColors.textGrey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              AuthTextField(
                label: l10n.mobileNumber,
                fieldIcon: Icons.phone_outlined,
                hint: l10n.enterMobile,
                controller: signup.mobileController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 14),
              AuthTextField(
                label: l10n.emailId,
                fieldIcon: Icons.email_outlined,
                hint: l10n.enterEmailId,
                controller: signup.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),
              AuthTextField(
                label: l10n.password,
                fieldIcon: Icons.lock_outline,
                hint: l10n.createStrongPassword,
                controller: signup.passwordController,
                obscureText: signup.obscurePassword,
                onToggleObscure: signup.togglePasswordVisibility,
              ),
              if (signup.errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  signup.errorMessage!,
                  style: const TextStyle(color: AppColors.error, fontSize: 13),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: signup.agreedToTerms,
                      onChanged: (v) => context
                          .read<SignupProvider>()
                          .setAgreedToTerms(v ?? false),
                      activeColor: AppColors.accentGreen,
                      checkColor: AppColors.bgDark,
                      side: const BorderSide(color: AppColors.borderMuted),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          color: AppColors.textWhite.withValues(alpha: 0.75),
                          fontSize: 13,
                          height: 1.35,
                        ),
                        children: [
                          TextSpan(text: l10n.iAgreeTo),
                          TextSpan(
                            text: l10n.termsConditions,
                            style: const TextStyle(
                              color: AppColors.accentGreen,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          TextSpan(text: l10n.and),
                          TextSpan(
                            text: l10n.privacyPolicy,
                            style: const TextStyle(
                              color: AppColors.accentGreen,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GradientActionButton(
                label: l10n.signUp,
                showArrow: false,
                isLoading: signup.isLoading,
                onPressed: () async {
                  final ok = await context
                      .read<SignupProvider>()
                      .createAccount(context.l10nRead);
                  if (ok && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(context.l10nRead.accountCreated),
                        backgroundColor: AppColors.olive,
                      ),
                    );
                    Navigator.of(context).pop();
                  }
                },
              ),
              const SizedBox(height: 18),
              Center(
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: AppColors.textWhite.withValues(alpha: 0.75),
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(text: l10n.alreadyHaveAccount),
                      TextSpan(
                        text: l10n.loginLink,
                        style: const TextStyle(
                          color: AppColors.accentGreen,
                          fontWeight: FontWeight.w700,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            color: selected
                ? AppColors.accentGreen.withValues(alpha: 0.12)
                : AppColors.bgCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.accentGreen : AppColors.borderMuted,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    size: 16,
                    color: selected
                        ? AppColors.accentGreen
                        : AppColors.textGrey,
                  ),
                ),
                Icon(
                  icon,
                  color: selected
                      ? AppColors.accentGreen
                      : AppColors.mutedGreen,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: selected
                        ? AppColors.accentGreen
                        : AppColors.textWhite,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.textWhite.withValues(alpha: 0.55),
                    fontSize: 9,
                    height: 1.25,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ArmyNumberFormatBox extends StatelessWidget {
  const _ArmyNumberFormatBox();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.olive.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderMuted),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: AppColors.accentGreen, size: 16),
              const SizedBox(width: 6),
              Text(
                l10n.armyNumberFormat,
                style: const TextStyle(
                  color: AppColors.accentGreen,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _FormatColumn(
                  label: l10n.agniveer,
                  example: 'A5603686K',
                ),
              ),
              Expanded(
                child: _FormatColumn(
                  label: l10n.jco,
                  example: 'JC-561278',
                ),
              ),
              Expanded(
                child: _FormatColumn(
                  label: l10n.officers,
                  example: 'IC-24573',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FormatColumn extends StatelessWidget {
  final String label;
  final String example;

  const _FormatColumn({required this.label, required this.example});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textWhite.withValues(alpha: 0.65),
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          example,
          style: const TextStyle(
            color: AppColors.textWhite,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
