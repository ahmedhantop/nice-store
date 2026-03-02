import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nicestore/core/localization/app_strings.dart';
import 'package:nicestore/core/providers/auth_provider.dart';
import 'package:nicestore/core/providers/auth_state.dart';
import 'package:nicestore/core/theme/colors.dart';
import 'package:nicestore/core/widgets/custom_animations.dart';
import 'package:nicestore/core/widgets/custom_button.dart';
import 'package:nicestore/core/widgets/custom_text_form_field.dart';
import 'package:nicestore/features/home/navigator_screens/main_screen.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        ref.read(authProvider.notifier).clearError();
      }

      // Show success message on successful authentication
      if (next.user != null && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome back, ${next.user!.fullname}!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        // Navigation is now handled automatically by GoRouter redirect
      }
    });

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // Email Field with Animation
              SlideInAnimation(
                delay: const Duration(milliseconds: 200),
                child: CustomTextFormField(
                  controller: _emailController,
                  labelText: AppStrings.email.tr(),
                  hintText: 'Enter your email address',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      Icons.email_outlined,
                      size: 20,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.emailRequired.tr();
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return AppStrings.emailInvalid.tr();
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Password Field with Animation
              SlideInAnimation(
                delay: const Duration(milliseconds: 400),
                child: CustomTextFormField(
                  controller: _passwordController,
                  labelText: AppStrings.password.tr(),
                  hintText: 'Enter your password',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      Icons.lock_outline,
                      size: 20,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20,
                      color: isDark
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.passwordRequired.tr();
                    }
                    if (value.length < 8) {
                      return AppStrings.passwordMinLength.tr();
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 32),

              // Login Button with Animation
              SlideInAnimation(
                delay: const Duration(milliseconds: 600),
                child: CustomButton(
                  backgroundColor: AppColors.secondary,
                  text: AppStrings.login.tr(),
                  onPressed: authState.isLoading ? null : _login,
                  size: ButtonSize.large,
                  isLoading: authState.isLoading,
                  fullWidth: true,
                  elevation: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authProvider.notifier)
          .login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainHomeScreen()),
      );
    }
  }
}
