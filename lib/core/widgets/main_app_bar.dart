import 'package:flutter/material.dart';

class MainAppbar extends StatelessWidget {
  const MainAppbar({
    super.key,

    this.title = '',
    this.actions,

    this.showBackButton = false,
  });

  final String? title;
  final List<Widget>? actions;

  final bool? showBackButton;
  @override
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton == true
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,

      backgroundColor: Colors.grey[100],
      elevation: 0,

      title: Text(
        title!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }
}
