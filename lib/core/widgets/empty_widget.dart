import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nicestore/core/constants/app_icons.dart';
import 'package:nicestore/core/localization/app_strings.dart';

class EmptyWidget extends StatefulWidget {
  const EmptyWidget({super.key, this.message, this.icon, this.iconPath});
  final String? message;
  final IconData? icon;
  final String? iconPath;

  @override
  State<EmptyWidget> createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _floatAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _floatAnimation,
                builder: (context, child) => Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.grey.shade700
                          : Colors.grey.shade200,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: widget.iconPath != null
                        ? AppIcons.icon(
                            widget.iconPath!,
                            size: 56,
                            color: isDark
                                ? Colors.grey.shade500
                                : Colors.grey.shade600,
                          )
                        : Icon(
                            widget.icon ?? Icons.inbox_outlined,
                            size: 56,
                            color: isDark
                                ? Colors.grey.shade500
                                : Colors.grey.shade600,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      widget.message ?? AppStrings.noData.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? Colors.grey.shade300
                            : Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Pull to refresh or try again later',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? Colors.grey.shade500
                            : Colors.grey.shade500,
                      ),
                      textAlign: TextAlign.center,
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
}
