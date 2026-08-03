import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class GradientActionButton extends StatelessWidget {
  final String label;
  final IconData? leadingIcon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool showArrow;

  const GradientActionButton({
    super.key,
    required this.label,
    this.leadingIcon,
    this.onPressed,
    this.isLoading = false,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.olive, AppColors.oliveDark],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.olive.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLoading ? null : onPressed,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: isLoading
                  ? const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AppColors.textWhite,
                        ),
                      ),
                    )
                  : leadingIcon != null
                      ? Row(
                          children: [
                            Icon(leadingIcon, color: AppColors.textWhite, size: 22),
                            const Spacer(),
                            Text(
                              label,
                              style: const TextStyle(
                                color: AppColors.textWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const Spacer(),
                            if (showArrow)
                              const Icon(
                                Icons.arrow_forward,
                                color: AppColors.textWhite,
                                size: 22,
                              )
                            else
                              const SizedBox(width: 22),
                          ],
                        )
                      : Center(
                          child: Text(
                            label,
                            style: const TextStyle(
                              color: AppColors.textWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthTextField extends StatelessWidget {
  final String label;
  final IconData? labelIcon;
  final IconData? fieldIcon;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final TextInputType keyboardType;
  final Widget? prefix;
  final Widget? suffix;
  final String? helperText;
  final bool readOnly;
  final VoidCallback? onTap;

  const AuthTextField({
    super.key,
    required this.label,
    this.labelIcon,
    this.fieldIcon,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.onToggleObscure,
    this.keyboardType = TextInputType.text,
    this.prefix,
    this.suffix,
    this.helperText,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (labelIcon != null) ...[
              Icon(labelIcon, size: 16, color: AppColors.mutedGreen),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: const TextStyle(
                color: AppColors.mutedGreen,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          style: const TextStyle(color: AppColors.textWhite, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: fieldIcon != null
                ? Icon(fieldIcon, color: AppColors.textGrey, size: 20)
                : prefix,
            suffixIcon: onToggleObscure != null
                ? IconButton(
                    onPressed: onToggleObscure,
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textGrey,
                      size: 20,
                    ),
                  )
                : suffix,
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 6),
          Text(
            helperText!,
            style: const TextStyle(
              color: AppColors.textGrey,
              fontSize: 11,
            ),
          ),
        ],
      ],
    );
  }
}
