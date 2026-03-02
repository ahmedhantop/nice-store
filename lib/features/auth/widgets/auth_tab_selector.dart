import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nicestore/core/theme/colors.dart';
import 'package:nicestore/features/auth/widgets/auth_tab.dart';

class AuthTabSelector extends StatelessWidget {
  const AuthTabSelector({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.3),
          ),
        ),
        child: TabBar(
          controller: tabController,
          onTap: (_) => HapticFeedback.selectionClick(),
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.white.withValues(alpha: 0.8),
          labelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          tabs: const [
            AuthTab(icon: Icons.message, label: 'with Otp'),
            AuthTab(icon: Icons.email, label: 'with Email'),
          ],
        ),
      ),
    );
  }
}
