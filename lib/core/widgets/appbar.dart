import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,

    this.title = '',
    this.actions,
    this.bottom,
    this.showSearch = false,
    this.showBackButton = false,
  });

  final String? title;
  final List<Widget>? actions;
  final Widget? bottom;
  final bool? showSearch;
  final bool? showBackButton;
  @override
  State<CustomAppbar> createState() => _CustomAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(20),

      child: _buildAppBar(
        context: context,
        title: widget.title!,
        actions: widget.actions,
        bottom: widget.bottom,
        showSearch: widget.showSearch,
        showBackButton: widget.showBackButton,
      ),
    );
  }
}

Widget _buildAppBar({
  required String title,
  required BuildContext context,
  final List<Widget>? actions,
  final Widget? bottom,
  final bool? showSearch,
  final bool? showBackButton,
}) {
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
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Colors.black,
      ),
    ),
    centerTitle: true,
    actions: actions,

    // ✅ SEARCH BAR IN BOTTOM SECTION
    bottom: bottom != null
        ? PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(30),
                child: bottom,
              ),
            ),
          )
        : null,
  );
}
