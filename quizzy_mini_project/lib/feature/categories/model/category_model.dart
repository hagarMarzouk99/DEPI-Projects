import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final String description;
  final int quizzesCount;
  final int questionsCount;
  final IconData icon;
  final Color color;
 
 // filter
  final bool isPopular;
  final bool isRecent;
  final bool isTrending;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.quizzesCount,
    required this.questionsCount,
    required this.icon,
    required this.color,
    this.isPopular = false,
    this.isRecent = false,
    this.isTrending = false,
  });
}