import 'package:flutter/material.dart';
import 'package:nicestore/features/auth/widgets/form_wrapper.dart';
import 'package:nicestore/features/auth/widgets/login_form.dart';
import 'package:nicestore/features/auth/widgets/otp_screen.dart';

class AuthFormContainer extends StatelessWidget {
  const AuthFormContainer({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        child: TabBarView(
          controller: tabController,
          physics: const BouncingScrollPhysics(),
          children: const [
            FormWrapper(child: OtpScreen()),
            FormWrapper(child: LoginForm()),
          ],
        ),
      ),
    );
  }
}
