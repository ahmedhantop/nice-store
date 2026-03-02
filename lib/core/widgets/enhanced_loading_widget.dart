// import 'package:flutter/material.dart';
// import 'package:nicestore/core/constants/app_icons.dart';
// import 'package:nicestore/core/constants/app_typography.dart';
// import 'package:nicestore/core/theme/colors.dart';

// class EnhancedLoadingWidget extends StatefulWidget {
//   const EnhancedLoadingWidget({
//     super.key,
//     this.message,
//     this.color,
//     this.size,
//     this.showIcon = true,
//   });
//   final String? message;
//   final Color? color;
//   final double? size;
//   final bool showIcon;

//   @override
//   State<EnhancedLoadingWidget> createState() => _EnhancedLoadingWidgetState();
// }

// class _EnhancedLoadingWidgetState extends State<EnhancedLoadingWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _rotationAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );
//     _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.linear),
//     );
//     _animationController.repeat();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         if (widget.showIcon) ...[
//           // Animated Loading Icon
//           AnimatedBuilder(
//             animation: _rotationAnimation,
//             builder: (context, child) => Transform.rotate(
//               angle: _rotationAnimation.value * 2 * 3.14159,
//               child: Container(
//                 width: widget.size ?? 60,
//                 height: widget.size ?? 60,
//                 decoration: BoxDecoration(
//                   color: (widget.color ?? AppColors.primary).withValues(
//                     alpha: 0.1,
//                   ),
//                   borderRadius: BorderRadius.circular((widget.size ?? 60) / 4),
//                 ),
//                 child: AppIcons.loadingIcon(
//                   size: (widget.size ?? 60) * 0.5,
//                   color: widget.color ?? AppColors.primary,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 24),
//         ],

//         // Loading Message
//         if (widget.message != null)
//           Text(
//             widget.message!,
//             style: AppTypography.bodyMedium.copyWith(
//               color: AppColors.textSecondary,
//             ),
//             textAlign: TextAlign.center,
//           ),

//         // Default loading indicator if no icon
//         if (!widget.showIcon)
//           CircularProgressIndicator(color: widget.color ?? AppColors.primary),
//       ],
//     ),
//   );
// }

// // Predefined loading widgets for common scenarios
// class LoadingWidgets {
//   static Widget general({String? message}) =>
//       EnhancedLoadingWidget(message: message ?? 'Loading...');

//   static Widget hotels() =>
//       const EnhancedLoadingWidget(message: 'Loading hotels...');

//   static Widget bookings() =>
//       const EnhancedLoadingWidget(message: 'Loading your bookings...');

//   static Widget search() =>
//       const EnhancedLoadingWidget(message: 'Searching...');

//   static Widget auth() => const EnhancedLoadingWidget(
//     message: 'Signing you in...',
//     color: Colors.blue,
//   );

//   static Widget small() =>
//       const EnhancedLoadingWidget(size: 30, showIcon: false);
// }
