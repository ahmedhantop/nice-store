import 'package:flutter/material.dart';

// Fade In Animation
class FadeInAnimation extends StatefulWidget {
  const FadeInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeInOut,
    this.autoStart = true,
  });
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final bool autoStart;

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    if (widget.autoStart) {
      _startAnimation();
    }
  }

  Future<void> _startAnimation() async {
    if (widget.delay != Duration.zero) {
      await Future.delayed(widget.delay);
    }
    if (mounted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _animation,
    builder: (context, child) =>
        Opacity(opacity: _animation.value, child: widget.child),
  );
}

// Slide In Animation
class SlideInAnimation extends StatefulWidget {
  const SlideInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.easeInOut,
    this.begin = const Offset(0, 1),
    this.end = Offset.zero,
    this.autoStart = true,
  });
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Offset begin;
  final Offset end;
  final bool autoStart;

  @override
  State<SlideInAnimation> createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _slideAnimation = Tween<Offset>(
      begin: widget.begin,
      end: widget.end,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    if (widget.autoStart) {
      _startAnimation();
    }
  }

  Future<void> _startAnimation() async {
    if (widget.delay != Duration.zero) {
      await Future.delayed(widget.delay);
    }
    if (mounted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (context, child) => SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(opacity: _fadeAnimation, child: widget.child),
    ),
  );
}

// Scale Animation
class ScaleAnimation extends StatefulWidget {
  const ScaleAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.curve = Curves.elasticOut,
    this.begin = 0.0,
    this.end = 1.0,
    this.autoStart = true,
  });
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double begin;
  final double end;
  final bool autoStart;

  @override
  State<ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _scaleAnimation = Tween<double>(
      begin: widget.begin,
      end: widget.end,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.autoStart) {
      _startAnimation();
    }
  }

  Future<void> _startAnimation() async {
    if (widget.delay != Duration.zero) {
      await Future.delayed(widget.delay);
    }
    if (mounted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (context, child) => Transform.scale(
      scale: _scaleAnimation.value,
      child: FadeTransition(opacity: _fadeAnimation, child: widget.child),
    ),
  );
}

// Staggered List Animation
class StaggeredListAnimation extends StatefulWidget {
  const StaggeredListAnimation({
    super.key,
    required this.children,
    this.duration = const Duration(milliseconds: 500),
    this.staggerDelay = const Duration(milliseconds: 100),
    this.curve = Curves.easeInOut,
    this.direction = Axis.vertical,
    this.autoStart = true,
  });
  final List<Widget> children;
  final Duration duration;
  final Duration staggerDelay;
  final Curve curve;
  final Axis direction;
  final bool autoStart;

  @override
  State<StaggeredListAnimation> createState() => _StaggeredListAnimationState();
}

class _StaggeredListAnimationState extends State<StaggeredListAnimation> {
  @override
  Widget build(BuildContext context) => Column(
    children: widget.children.asMap().entries.map((entry) {
      final index = entry.key;
      final child = entry.value;

      return SlideInAnimation(
        delay: Duration(
          milliseconds: index * widget.staggerDelay.inMilliseconds,
        ),
        duration: widget.duration,
        curve: widget.curve,
        begin: widget.direction == Axis.vertical
            ? const Offset(0, 0.5)
            : const Offset(0.5, 0),
        autoStart: widget.autoStart,
        child: child,
      );
    }).toList(),
  );
}

// Bounce Animation
class BounceAnimation extends StatefulWidget {
  const BounceAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
    this.repeat = false,
    this.autoStart = true,
  });
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool repeat;
  final bool autoStart;

  @override
  State<BounceAnimation> createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));

    if (widget.autoStart) {
      _startAnimation();
    }
  }

  Future<void> _startAnimation() async {
    if (widget.delay != Duration.zero) {
      await Future.delayed(widget.delay);
    }
    if (mounted) {
      if (widget.repeat) {
        await _controller.repeat();
      } else {
        await _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _animation,
    builder: (context, child) =>
        Transform.scale(scale: _animation.value, child: widget.child),
  );
}

// Shimmer Loading Animation
class ShimmerAnimation extends StatefulWidget {
  const ShimmerAnimation({
    super.key,
    required this.child,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.duration = const Duration(milliseconds: 1500),
  });
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;

  @override
  State<ShimmerAnimation> createState() => _ShimmerAnimationState();
}

class _ShimmerAnimationState extends State<ShimmerAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _animation = Tween<double>(
      begin: -1,
      end: 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _animation,
    builder: (context, child) => ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [widget.baseColor, widget.highlightColor, widget.baseColor],
        stops: [
          _animation.value - 0.3,
          _animation.value,
          _animation.value + 0.3,
        ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
      ).createShader(bounds),
      child: widget.child,
    ),
  );
}
