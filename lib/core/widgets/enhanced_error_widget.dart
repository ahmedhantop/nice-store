// import 'package:flutter/material.dart';
// import 'package:nicestore/core/constants/app_icons.dart';
// import 'package:nicestore/core/constants/app_typography.dart';
// import 'package:nicestore/core/theme/colors.dart';

// enum ErrorType { general, network, server, auth, noInternet }

// class EnhancedErrorWidget extends StatelessWidget {
//   const EnhancedErrorWidget({
//     super.key,
//     this.errorType = ErrorType.general,
//     this.title,
//     this.message,
//     this.onRetry,
//     this.retryButtonText,
//     this.customIcon,
//     this.iconColor,
//   });
//   final ErrorType errorType;
//   final String? title;
//   final String? message;
//   final VoidCallback? onRetry;
//   final String? retryButtonText;
//   final Widget? customIcon;
//   final Color? iconColor;

//   @override
//   Widget build(BuildContext context) {
//     final errorConfig = _getErrorConfig();

//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Error Icon
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: (iconColor ?? errorConfig.color).withValues(alpha: 0.1),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child:
//                   customIcon ??
//                   AppIcons.icon(
//                     errorConfig.iconPath,
//                     size: 40,
//                     color: iconColor ?? errorConfig.color,
//                   ),
//             ),

//             const SizedBox(height: 24),

//             // Title
//             Text(
//               title ?? errorConfig.title,
//               style: AppTypography.headlineSmall.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary,
//               ),
//               textAlign: TextAlign.center,
//             ),

//             const SizedBox(height: 12),

//             // Message
//             Text(
//               message ?? errorConfig.message,
//               style: AppTypography.bodyMedium.copyWith(
//                 color: AppColors.textSecondary,
//               ),
//               textAlign: TextAlign.center,
//             ),

//             const SizedBox(height: 32),

//             // Retry Button
//             if (onRetry != null)
//               ElevatedButton.icon(
//                 onPressed: onRetry,
//                 icon: const Icon(Icons.refresh, size: 20),
//                 label: Text(retryButtonText ?? 'Try Again'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: iconColor ?? errorConfig.color,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 12,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   _ErrorConfig _getErrorConfig() {
//     switch (errorType) {
//       case ErrorType.network:
//         return const _ErrorConfig(
//           iconPath: AppIcons.networkError,
//           title: 'Network Error',
//           message: 'Please check your internet connection and try again.',
//           color: Colors.orange,
//         );

//       case ErrorType.server:
//         return const _ErrorConfig(
//           iconPath: AppIcons.serverError,
//           title: 'Server Error',
//           message: 'Something went wrong on our end. Please try again later.',
//           color: Colors.red,
//         );

//       case ErrorType.auth:
//         return const _ErrorConfig(
//           iconPath: AppIcons.authError,
//           title: 'Authentication Error',
//           message: 'Please sign in again to continue.',
//           color: Colors.purple,
//         );

//       case ErrorType.noInternet:
//         return const _ErrorConfig(
//           iconPath: AppIcons.noInternet,
//           title: 'No Internet Connection',
//           message: 'Please check your internet connection and try again.',
//           color: Colors.grey,
//         );

//       case ErrorType.general:
//         return const _ErrorConfig(
//           iconPath: AppIcons.error,
//           title: 'Something went wrong',
//           message: 'An unexpected error occurred. Please try again.',
//           color: Colors.red,
//         );
//     }
//   }
// }

// class _ErrorConfig {
//   const _ErrorConfig({
//     required this.iconPath,
//     required this.title,
//     required this.message,
//     required this.color,
//   });
//   final String iconPath;
//   final String title;
//   final String message;
//   final Color color;
// }
