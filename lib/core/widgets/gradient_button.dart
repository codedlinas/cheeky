import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/theme_provider.dart';

class GradientButton extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final variant = ref.watch(themeVariantProvider);
    final gradient = getButtonGradient(variant);
    final borderRadius = getButtonBorderRadius(variant);
    final primaryColor = getThemePrimaryColor(variant);

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: variant == AppThemeVariant.v3DarkNeon
            ? [
                BoxShadow(
                  color: const Color(0xFF00FFFF).withValues(alpha: 0.5),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
            : [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
        border: variant == AppThemeVariant.v5LuxuryGoldBlack
            ? Border.all(color: const Color(0xFFD4AF37), width: 1)
            : null,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: variant == AppThemeVariant.v3DarkNeon 
                      ? const Color(0xFF00FFFF) 
                      : Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                variant == AppThemeVariant.v5LuxuryGoldBlack 
                    ? text.toUpperCase() 
                    : text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: variant == AppThemeVariant.v5LuxuryGoldBlack ? 3 : 0,
                ),
              ),
      ),
    );
  }
}
