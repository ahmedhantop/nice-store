import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary, outline, text, danger }

enum ButtonSize { small, medium, large }

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.elevation,
    this.fullWidth = false,
  });
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final Widget? icon;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? elevation;
  final bool fullWidth;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (!widget.isDisabled && !widget.isLoading) {
      _animationController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = widget.isDisabled || widget.isLoading;

    // Size configurations
    final sizeConfig = _getSizeConfig();

    // Color configurations
    final colorConfig = _getColorConfig(theme);

    final Widget buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.leadingIcon != null) ...[
          widget.leadingIcon!,
          const SizedBox(width: 8),
        ],
        if (widget.isLoading)
          SizedBox(
            width: sizeConfig.iconSize,
            height: sizeConfig.iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                colorConfig.foregroundColor,
              ),
            ),
          )
        else if (widget.icon != null)
          widget.icon!
        else
          Text(
            widget.text,
            style:
                widget.textStyle ??
                sizeConfig.textStyle.copyWith(
                  color: colorConfig.foregroundColor,
                ),
          ),
        if (widget.trailingIcon != null) ...[
          const SizedBox(width: 8),
          widget.trailingIcon!,
        ],
      ],
    );

    final Widget button = AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: Container(
          width: widget.fullWidth ? double.infinity : widget.width,
          height: widget.height ?? sizeConfig.height,
          decoration: BoxDecoration(
            color: colorConfig.backgroundColor,
            borderRadius: widget.borderRadius ?? sizeConfig.borderRadius,
            border: colorConfig.borderColor != null
                ? Border.all(color: colorConfig.borderColor!, width: 1.5)
                : null,
            boxShadow: widget.elevation != null
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: widget.elevation! * 2,
                      offset: Offset(0, widget.elevation!),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: widget.elevation!,
                      offset: Offset(0, widget.elevation! / 2),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isDisabled ? null : widget.onPressed,
              borderRadius: widget.borderRadius ?? sizeConfig.borderRadius,
              splashColor: colorConfig.foregroundColor.withValues(alpha: 0.1),
              highlightColor: colorConfig.foregroundColor.withValues(
                alpha: 0.05,
              ),
              child: Container(
                padding: widget.padding ?? sizeConfig.padding,
                child: buttonChild,
              ),
            ),
          ),
        ),
      ),
    );

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Opacity(opacity: isDisabled ? 0.6 : 1.0, child: button),
    );
  }

  _ButtonSizeConfig _getSizeConfig() {
    switch (widget.size) {
      case ButtonSize.small:
        return _ButtonSizeConfig(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          iconSize: 16,
          borderRadius: BorderRadius.circular(8),
        );
      case ButtonSize.medium:
        return _ButtonSizeConfig(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
          iconSize: 20,
          borderRadius: BorderRadius.circular(12),
        );
      case ButtonSize.large:
        return _ButtonSizeConfig(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
          iconSize: 24,
          borderRadius: BorderRadius.circular(16),
        );
    }
  }

  _ButtonColorConfig _getColorConfig(ThemeData theme) {
    switch (widget.variant) {
      case ButtonVariant.primary:
        return _ButtonColorConfig(
          backgroundColor: widget.backgroundColor ?? theme.primaryColor,
          foregroundColor: widget.foregroundColor ?? Colors.white,
          borderColor: widget.borderColor,
        );
      case ButtonVariant.secondary:
        return _ButtonColorConfig(
          backgroundColor:
              widget.backgroundColor ?? theme.colorScheme.secondary,
          foregroundColor: widget.foregroundColor ?? Colors.white,
          borderColor: widget.borderColor,
        );
      case ButtonVariant.outline:
        return _ButtonColorConfig(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          foregroundColor: widget.foregroundColor ?? theme.primaryColor,
          borderColor: widget.borderColor ?? theme.primaryColor,
        );
      case ButtonVariant.text:
        return _ButtonColorConfig(
          backgroundColor: widget.backgroundColor ?? Colors.transparent,
          foregroundColor: widget.foregroundColor ?? theme.primaryColor,
          borderColor: widget.borderColor,
        );
      case ButtonVariant.danger:
        return _ButtonColorConfig(
          backgroundColor: widget.backgroundColor ?? theme.colorScheme.error,
          foregroundColor: widget.foregroundColor ?? Colors.white,
          borderColor: widget.borderColor,
        );
    }
  }
}

class _ButtonSizeConfig {
  const _ButtonSizeConfig({
    required this.height,
    required this.padding,
    required this.textStyle,
    required this.iconSize,
    required this.borderRadius,
  });
  final double height;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
  final double iconSize;
  final BorderRadius borderRadius;
}

class _ButtonColorConfig {
  const _ButtonColorConfig({
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
  });
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
}
