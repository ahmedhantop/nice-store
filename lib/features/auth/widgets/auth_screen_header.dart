import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/core/providers/theme_provider.dart';
import 'package:nicestore/core/theme/colors.dart';

class AuthScreenHeader extends ConsumerWidget {
  const AuthScreenHeader({super.key, this.onBackPressed});

  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          _HeaderIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onPressed: onBackPressed ?? () => Navigator.pop(context),
            isDark: isDark,
          ),

          // Action buttons
          Row(
            children: [
              _HeaderIconButton(
                icon: isDark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  ref.read(themeModeProvider.notifier).toggleTheme();
                },
                isDark: isDark,
              ),
              const SizedBox(width: 8),
              _HeaderIconButton(
                icon: Icons.language_rounded,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  _showLanguageSheet(context);
                },
                isDark: isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLanguageSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Select Language',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            _LanguageOption(
              title: 'English',
              code: 'EN',
              isSelected: true,
              isDark: isDark,
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 12),
            _LanguageOption(
              title: 'العربية',
              code: 'AR',
              isSelected: false,
              isDark: isDark,
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onPressed,
    required this.isDark,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              icon,
              color: isDark ? Colors.white : Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.title,
    required this.code,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  final String title;
  final String code;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.1)
                : (isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.grey.withValues(alpha: 0.05)),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.15)
                      : (isDark
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.grey.withValues(alpha: 0.1)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    code,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? AppColors.primary
                          : (isDark ? Colors.white70 : Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              if (isSelected)
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
