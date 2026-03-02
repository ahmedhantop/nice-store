import 'package:flutter/material.dart';

class FormWrapper extends StatelessWidget {
  const FormWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: child,
    );
  }
}
