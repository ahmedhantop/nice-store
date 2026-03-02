import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nicestore/core/theme/assets_maneger.dart';
import 'package:nicestore/features/auth/widgets/otp_bottom_sheet.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _showOtpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => OtpBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // Phone Number Label
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'رقم الجوال',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A), // Dark blue
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Phone Input Field
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF2DD4BF),
                ), // Teal border
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: '5xxxxxxxx',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      style: const TextStyle(fontFamily: 'Cairo'),
                    ),
                  ),
                  Container(height: 48, width: 1, color: Colors.grey.shade300),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '966+',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Color(0xFF1E3A8A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Helper Text
            const Text(
              'سيتم استخدام رقم الهاتف لتسجيل الدخول أو إنشاء حساب جديد',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 32),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _showOtpBottomSheet(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D4761), // Dark Navy Blue
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'متابعة',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
