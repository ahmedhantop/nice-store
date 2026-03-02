import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:nicestore/core/theme/assets_maneger.dart';
import 'package:nicestore/features/auth/screens/auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final LiquidController _liquidController = LiquidController();

  void _navigateToHome() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const AuthScreen()));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            LiquidSwipe(
              pages: [
                _buildPage(
                  color: const Color(0xFF2DD4BF),
                  backgroundColor: const Color(0xFFE5E7EB), // Next page color
                  imagePath: AssetsManager.logo,
                  title: "get what you need",
                  description:
                      'we sell any thing , just start a journey inside our store',
                  textColor: Colors.white,
                ),
                _buildPage(
                  color: const Color(0xFFE5E7EB),
                  backgroundColor: const Color(0xFF1E3A8A), // Next page color
                  imagePath: AssetsManager.logo,
                  title: "get what you need",
                  description:
                      'we sell any thing , just start a journey inside our store',
                  textColor: const Color(0xFF1F2937),
                ),
                _buildPage(
                  color: const Color(0xFF1E3A8A),
                  backgroundColor: Colors.white, // No next page
                  imagePath: AssetsManager.logo,
                  title: "get what you need",
                  description:
                      'we sell any thing , just start a journey inside our store',
                  textColor: Colors.white,
                ),
                // Dummy page for detecting "slide to exit"
                Container(color: Colors.white),
              ],
              liquidController: _liquidController,
              onPageChangeCallback: (activePageIndex) {
                // If we reached the dummy page (index 3), navigate home
                if (activePageIndex == 3) {
                  _navigateToHome();
                } else {
                  setState(() {
                    _currentPage = activePageIndex;
                  });
                }
              },
              waveType: WaveType.liquidReveal,
              slideIconWidget: Container(
                padding: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              positionSlideIcon: 0.5,
              enableSideReveal: true,
              enableLoop: false,
              ignoreUserGestureWhileAnimating: true,
            ),
            // Skip button
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              child: TextButton(
                onPressed: _navigateToHome,
                child: Text(
                  'تخطي',
                  style: TextStyle(
                    color: _currentPage == 1
                        ? const Color(0xFF1F2937)
                        : Colors.white,
                    fontSize: 16,

                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Bottom controls
            Positioned(
              bottom: 40,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Page indicators
                  Row(
                    children: List.generate(3, (index) {
                      final isActive = _currentPage == index;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? (_currentPage == 1
                                    ? const Color(0xFF1F2937)
                                    : Colors.white)
                              : (_currentPage == 1
                                        ? const Color(0xFF1F2937)
                                        : Colors.white)
                                    .withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required Color color,
    required Color backgroundColor,
    required String imagePath,
    required String title,
    required String description,
    required Color textColor,
  }) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          // Wave Background
          ClipPath(
            child: Container(
              color: color,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  // Image/Illustration
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Image.asset(
                        imagePath,
                        height: 280,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Text content
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            fontFamily: 'Cairo',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: textColor.withOpacity(0.8),
                            fontFamily: 'Cairo',
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StaticWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Start from top-left (RTL reversed logic if needed, but coordinate system is standard)
    // Actually, screen coordinates are usually LTR unless transformed.
    // Let's assume standard coordinates: (0,0) is top-left.

    // We want the wave on the RIGHT side.
    path.lineTo(size.width * 0.85, 0);

    // Wave 1
    path.quadraticBezierTo(
      size.width * 1.0,
      size.height * 0.15,
      size.width * 0.85,
      size.height * 0.3,
    );

    // Wave 2
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.45,
      size.width * 0.85,
      size.height * 0.6,
    );

    // Wave 3
    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * 0.75,
      size.width * 0.85,
      size.height,
    );

    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
