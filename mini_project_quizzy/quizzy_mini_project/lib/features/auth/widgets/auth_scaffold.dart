import 'package:flutter/material.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class AuthScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final GlobalKey<FormState> formKey;
  final List<Widget> children;

  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.formKey,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset(AppAssets.logo, height: 80)),
                const SizedBox(height: 32),
                Text(title,
                    style: AppStyles.headline
                        .copyWith(color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                Text(subtitle,
                    style: AppStyles.body
                        .copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 32),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}