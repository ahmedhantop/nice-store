// import 'package:flutter/material.dart';
// import 'package:nicestore/core/constants/app_icons.dart';
// import 'package:nicestore/core/constants/app_typography.dart';
// import 'package:nicestore/core/theme/colors.dart';

// enum EmptyStateType {
//   general,
//   noData,
//   noResults,
//   noBookings,
//   noFavorites,
//   noNotifications,
// }

// class EnhancedEmptyWidget extends StatelessWidget {
//   const EnhancedEmptyWidget({
//     super.key,
//     this.emptyType = EmptyStateType.general,
//     this.title,
//     this.message,
//     this.onAction,
//     this.actionButtonText,
//     this.customIcon,
//     this.iconColor,
//   });
//   final EmptyStateType emptyType;
//   final String? title;
//   final String? message;
//   final VoidCallback? onAction;
//   final String? actionButtonText;
//   final Widget? customIcon;
//   final Color? iconColor;

//   @override
//   Widget build(BuildContext context) {
//     final emptyConfig = _getEmptyConfig();

//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Empty State Icon
//             Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 color: (iconColor ?? emptyConfig.color).withValues(alpha: 0.1),
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child:
//                   customIcon ??
//                   AppIcons.icon(
//                     emptyConfig.iconPath,
//                     size: 50,
//                     color: iconColor ?? emptyConfig.color,
//                   ),
//             ),

//             const SizedBox(height: 32),

//             // Title
//             Text(
//               title ?? emptyConfig.title,
//               style: AppTypography.headlineMedium.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary,
//               ),
//               textAlign: TextAlign.center,
//             ),

//             const SizedBox(height: 16),

//             // Message
//             Text(
//               message ?? emptyConfig.message,
//               style: AppTypography.bodyLarge.copyWith(
//                 color: AppColors.textSecondary,
//               ),
//               textAlign: TextAlign.center,
//             ),

//             const SizedBox(height: 40),

//             // Action Button
//             if (onAction != null)
//               ElevatedButton.icon(
//                 onPressed: onAction,
//                 icon: Icon(emptyConfig.actionIcon, size: 20),
//                 label: Text(actionButtonText ?? emptyConfig.actionText),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: iconColor ?? emptyConfig.color,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 32,
//                     vertical: 16,
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

//   _EmptyConfig _getEmptyConfig() {
//     switch (emptyType) {
//       case EmptyStateType.noData:
//         return const _EmptyConfig(
//           iconPath: AppIcons.noData,
//           title: 'No Data Available',
//           message: 'There\'s no data to display at the moment.',
//           color: Colors.grey,
//           actionIcon: Icons.refresh,
//           actionText: 'Refresh',
//         );

//       case EmptyStateType.noResults:
//         return const _EmptyConfig(
//           iconPath: AppIcons.search,
//           title: 'No Results Found',
//           message: 'Try adjusting your search criteria or filters.',
//           color: Colors.blue,
//           actionIcon: Icons.search,
//           actionText: 'Search Again',
//         );

//       case EmptyStateType.noBookings:
//         return const _EmptyConfig(
//           iconPath: AppIcons.calendar,
//           title: 'No Bookings Yet',
//           message:
//               'Start planning your next adventure by booking a hotel or tour.',
//           color: Colors.green,
//           actionIcon: Icons.add,
//           actionText: 'Start Booking',
//         );

//       case EmptyStateType.noFavorites:
//         return const _EmptyConfig(
//           iconPath: AppIcons.heart,
//           title: 'No Favorites Yet',
//           message: 'Save your favorite hotels and tours to see them here.',
//           color: Colors.red,
//           actionIcon: Icons.explore,
//           actionText: 'Explore',
//         );

//       case EmptyStateType.noNotifications:
//         return const _EmptyConfig(
//           iconPath: AppIcons.notification,
//           title: 'No Notifications',
//           message: 'You\'re all caught up! No new notifications.',
//           color: Colors.purple,
//           actionIcon: Icons.settings,
//           actionText: 'Settings',
//         );

//       case EmptyStateType.general:
//         return const _EmptyConfig(
//           iconPath: AppIcons.emptyState,
//           title: 'Nothing Here Yet',
//           message: 'This section is empty. Check back later for updates.',
//           color: Colors.grey,
//           actionIcon: Icons.refresh,
//           actionText: 'Refresh',
//         );
//     }
//   }
// }

// class _EmptyConfig {
//   const _EmptyConfig({
//     required this.iconPath,
//     required this.title,
//     required this.message,
//     required this.color,
//     required this.actionIcon,
//     required this.actionText,
//   });
//   final String iconPath;
//   final String title;
//   final String message;
//   final Color color;
//   final IconData actionIcon;
//   final String actionText;
// }
