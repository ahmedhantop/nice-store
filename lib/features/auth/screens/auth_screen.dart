import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/core/theme/colors.dart';
import 'package:nicestore/features/auth/widgets/auth_form_container.dart';
import 'package:nicestore/features/auth/widgets/auth_screen_header.dart';
import 'package:nicestore/features/auth/widgets/auth_tab_selector.dart';
import 'package:nicestore/features/auth/widgets/auth_welcome_section.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AnimationController _fadeController;
  late final AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      const Color(0xFF0F172A),
                      const Color(0xFF1E293B),
                      const Color(0xFF0F172A),
                    ]
                  : [
                      AppColors.primary.withValues(alpha: 0.95),
                      AppColors.primary.withValues(alpha: 0.8),
                      const Color(0xFFF8FAFC),
                    ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Decorative background elements
              _buildBackgroundDecorations(isDark),

              // Main content
              SafeArea(
                child: Column(
                  children: [
                    // Header with back button and actions
                    FadeTransition(
                      opacity: _fadeController,
                      child: AuthScreenHeader(
                        onBackPressed: () => Navigator.pop(context),
                      ),
                    ),

                    // Welcome text
                    SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _slideController,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                      child: FadeTransition(
                        opacity: _slideController,
                        child: const AuthWelcomeSection(),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Tab bar
                    SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(0, 0.5),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: _slideController,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                      child: FadeTransition(
                        opacity: _slideController,
                        child: AuthTabSelector(tabController: _tabController),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Form content
                    Expanded(
                      child: SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(0, 0.2),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: _slideController,
                                curve: Curves.easeOutCubic,
                              ),
                            ),
                        child: FadeTransition(
                          opacity: _slideController,
                          child: AuthFormContainer(
                            tabController: _tabController,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundDecorations(bool isDark) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (isDark ? Colors.blue : Colors.white).withValues(
                alpha: 0.05,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: -80,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (isDark ? Colors.purple : Colors.white).withValues(
                alpha: 0.05,
              ),
            ),
          ),
        ),
        Positioned(
          top: 200,
          left: -50,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (isDark ? Colors.cyan : Colors.white).withValues(
                alpha: 0.03,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
