import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nicestore/core/theme/assets_maneger.dart';

class AuthWelcomeSection extends StatelessWidget {
  const AuthWelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App logo/icon

          // Logo
          Image.asset(AssetsManager.logo, height: 120),

          const SizedBox(height: 20),

          // Welcome text
          // Text(
          //   'Welcome',
          //   style: TextStyle(
          //     fontSize: 32,
          //     fontWeight: FontWeight.w800,
          //     color: Colors.white,
          //     letterSpacing: -0.5,
          //     height: 1.1,
          //     shadows: isDark
          //         ? null
          //         : [
          //             Shadow(
          //               color: Colors.black.withValues(alpha: 0.1),
          //               blurRadius: 8,
          //               offset: const Offset(0, 2),
          //             ),
          //           ],
          //   ),
          // ),

          // const SizedBox(height: 8),

          // Subtitle
          Text(
            'Login to continue your journey',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.85),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
