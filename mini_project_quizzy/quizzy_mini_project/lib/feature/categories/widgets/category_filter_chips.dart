import 'package:flutter/material.dart';
import '../cubit/category_state.dart';

class CategoryFilterChips extends StatelessWidget {
  final CategoryFilter selected;
  final ValueChanged<CategoryFilter> onSelected;
  const CategoryFilterChips({super.key, required this.selected, required this.onSelected});
  @override
  Widget build(BuildContext context) => SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: CategoryFilter.values.map((filter) {
    final active = filter == selected;
    return Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(filter.label), selected: active, onSelected: (_) => onSelected(filter), selectedColor: const Color(0xFF1A1A5E), labelStyle: TextStyle(fontSize: 12, color: active ? Colors.white : Colors.black87), showCheckmark: false));
  }).toList()));
}
