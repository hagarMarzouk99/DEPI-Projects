import 'package:flutter/material.dart';
class CategoryHeader extends StatelessWidget {
  final VoidCallback? onBellTap;
  const CategoryHeader({super.key, this.onBellTap});
  @override
  Widget build(BuildContext context) => Row(children: [
    Container(width: 36, height: 36, decoration: BoxDecoration(color: const Color(0xFF5B4FE0), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.bolt, color: Colors.white, size: 20)),
    const SizedBox(width: 10), const Text('Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)), const Spacer(),
    InkWell(onTap: onBellTap, borderRadius: BorderRadius.circular(20), child: Container(width: 36, height: 36, decoration: const BoxDecoration(color: Color(0xFFF4F4F9), shape: BoxShape.circle), child: const Icon(Icons.notifications_none, size: 20, color: Colors.black87))),
  ]);
}
