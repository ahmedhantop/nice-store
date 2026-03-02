import 'package:flutter/material.dart';
import 'package:nicestore/core/localization/app_strings.dart';
import 'package:nicestore/core/theme/colors.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController searchController;
  const SearchWidget({super.key, required this.searchController});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(30),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            // Handle search logic here, e.g., filter products based on the search query
          });
        },
        controller: widget.searchController,
        decoration: InputDecoration(
          hintText: AppStrings.search,
          hintStyle: const TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: const Icon(Icons.search, color: AppColors.secondary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      ),
    );
  }
}
