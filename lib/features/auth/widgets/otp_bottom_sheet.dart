import 'package:flutter/material.dart';
import 'package:nicestore/features/home/navigator_screens/main_screen.dart';
import 'package:pinput/pinput.dart';

class OtpBottomSheet extends StatefulWidget {
  const OtpBottomSheet({super.key});

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  int otp = 0;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22, color: Color(0xFF1F2937)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2DD4BF)),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close Button
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Title
          const Text(
            'رمز التحقق OTP',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00898A), // Teal
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          const Text(
            'أدخل رمز التحقق لتأكيد بريدك الالكتروني',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              color: Color(0xFF4B5563),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // OTP Input
          Pinput(
            defaultPinTheme: defaultPinTheme,
            length: 4,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => setState(() {
              otp = int.parse(pin);
            }),

            //print(pin),
          ),
          const SizedBox(height: 16),

          // Error/Resend Text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'تم إدخال رمز خاطئ. ',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  color: Colors.red, // Assuming red for error
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Resend logic
                },
                child: const Text(
                  'إرسال مرة أخرى',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    color: Color(0xFF1E3A8A),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Verify Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (otp == 0000) {
                  debugPrint("رمز التحقق:$otp");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainHomeScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("رمز التحقق غير صحيح. حاول مرة أخرى."),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00898A), // Teal
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'verify',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
