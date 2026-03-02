import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nicestore/features/category/category_screen.dart';
import 'package:nicestore/features/home/products/screen/products_screen.dart';
import 'package:nicestore/features/cart/presentation/cart_screen.dart';
import 'package:nicestore/features/profile/profile_screen.dart';

class MainHomeScreen extends ConsumerStatefulWidget {
  const MainHomeScreen({super.key});

  @override
  ConsumerState<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends ConsumerState<MainHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    // const HomeScreen(),
    const ProductsScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  final List<String> _titles = [
    "Home",
    "Categories",
    "Cart",
    "Profile",
    // Settings.tr,
  ];

  @override
  Widget build(BuildContext context) {
    ////
    ///

    //    @override
    // Widget build(BuildContext context) {
    // Listen to auth state changes for logout feedback
    // ref.listen(authViewModelProvider, (previous, next) {
    //   // Show logout success message
    //   if (previous?.isAuthenticated == true &&
    //       !next.isAuthenticated &&
    //       !next.isLoading) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: const Text('Successfully logged out'),
    //         backgroundColor: Colors.green,
    //         behavior: SnackBarBehavior.floating,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(12),
    //         ),
    //       ),
    //     );
    //   }

    //   // Show logout error if any
    //   if (next.error != null && previous?.error != next.error) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(next.error!),
    //         backgroundColor: Theme.of(context).colorScheme.error,
    //         behavior: SnackBarBehavior.floating,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(12),
    //         ),
    //       ),
    //     );
    //   }
    // });

    ///
    ///
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(
          context,
        ).colorScheme.onSurface.withValues(alpha: 0.6),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 8,

        selectedFontSize: 12.sp,
        unselectedFontSize: 10.sp,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24.sp),
            activeIcon: Icon(Icons.home_filled, size: 28.sp),
            label: _titles[0],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, size: 24.sp),
            activeIcon: Icon(Icons.category, size: 26.sp),
            label: _titles[1],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, size: 24.sp),
            activeIcon: Icon(
              Icons.dashboard_rounded,
              color: Colors.yellow.shade500,
              size: 28.sp,
            ),
            label: _titles[2],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24.sp),
            activeIcon: Icon(Icons.person, size: 26.sp),
            label: _titles[3],
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings, size: 24.sp),
          //   activeIcon: Icon(Icons.settings, size: 26.sp),
          //   label: Settings.tr,
          // ),
        ],
      ),
    );
  }
}
