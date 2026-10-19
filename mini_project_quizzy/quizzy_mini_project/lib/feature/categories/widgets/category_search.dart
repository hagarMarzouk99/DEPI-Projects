import 'package:flutter/material.dart';
class CategorySearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const CategorySearchBar({super.key, required this.onChanged});
  @override
  Widget build(BuildContext context) => TextField(onChanged: onChanged, decoration: InputDecoration(hintText: 'Search categories...', hintStyle: const TextStyle(fontSize: 13, color: Colors.grey), prefixIcon: const Icon(Icons.search, size: 20), filled: true, fillColor: const Color(0xFFF4F4F9), contentPadding: const EdgeInsets.symmetric(vertical: 0), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none)));
}
