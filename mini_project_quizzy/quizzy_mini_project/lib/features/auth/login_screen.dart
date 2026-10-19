import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import 'logic/auth_cubit.dart';
import 'logic/auth_state.dart';
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
      context.read<AuthCubit>().login(
            email: _email.text,
            password: _password.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        // The register screen can sit on top of this one: only the screen the
        // user is looking at reacts, so we never navigate twice.
        if (ModalRoute.of(context)?.isCurrent != true) return;

        if (state.isAuthenticated) {
          // Clear the whole stack: back must not return to login.
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (route) => false,
          );
        } else if (state.status == AuthStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.message ?? 'Something went wrong')),
            );
        }
      },
      builder: (context, state) {
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
              isLoading: state.isLoading,
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
      },
    );
  }
}
