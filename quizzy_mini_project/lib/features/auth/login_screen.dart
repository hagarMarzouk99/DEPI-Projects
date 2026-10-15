import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import 'widgets/auth_footer_link.dart';
import 'widgets/auth_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Welcome Back',
      subtitle: 'Log in to continue your quiz journey.',
      formKey: _formKey,
      children: [
        CustomTextField(
          label: 'Email',
          hint: 'Enter your email',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          controller: _email,
          validator: Validators.email,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          label: 'Password',
          hint: 'Enter your password',
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          controller: _password,
          validator: Validators.password,
        ),
        const SizedBox(height: 32),
        CustomButton(
          text: 'Login',
          icon: Icons.arrow_forward,
          onPressed: _onLogin,
        ),
        const SizedBox(height: 24),
        AuthFooterLink(
          text: "Don't have an account?",
          actionText: 'Register',
          onTap: () => Navigator.pushNamed(context, AppRoutes.register),
        ),
      ],
    );
  }
}