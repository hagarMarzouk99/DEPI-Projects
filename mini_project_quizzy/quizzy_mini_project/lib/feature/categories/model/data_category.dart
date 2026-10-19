import 'package:flutter/material.dart';
import 'category_model.dart';

const List<CategoryModel> categoriesData = [
  CategoryModel(id: 'science', name: 'Science', description: 'Physics, chemistry & universe', quizzesCount: 12, questionsCount: 140, icon: Icons.science_outlined, color: Color(0xFF5B4FE0), isPopular: true, isTrending: true),
  CategoryModel(id: 'technology', name: 'Technology', description: 'AI, coding, gadgets & web', quizzesCount: 16, questionsCount: 185, icon: Icons.computer_outlined, color: Color(0xFF3F51B5), isPopular: true, isRecent: true, isTrending: true),
  CategoryModel(id: 'history', name: 'History', description: 'Ancient eras, wars & events', quizzesCount: 10, questionsCount: 115, icon: Icons.account_balance_outlined, color: Color(0xFF8D6E63), isRecent: true),
  CategoryModel(id: 'sports', name: 'Sports', description: 'Champions, rules & tournaments', quizzesCount: 14, questionsCount: 160, icon: Icons.emoji_events_outlined, color: Color(0xFF2E9E5B), isPopular: true),
  CategoryModel(id: 'geography', name: 'Geography', description: 'Flags, capitals & world landmarks', quizzesCount: 11, questionsCount: 130, icon: Icons.public, color: Color(0xFF0288D1), isTrending: true),
  CategoryModel(id: 'general', name: 'General', description: 'Trivia, pop culture & mixed facts', quizzesCount: 20, questionsCount: 220, icon: Icons.lightbulb_outline, color: Color(0xFF7CB342), isRecent: true),
];
