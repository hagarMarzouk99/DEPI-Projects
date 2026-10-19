import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../progress/logic/progress_cubit.dart';
import 'logic/auth_cubit.dart';
import 'logic/auth_state.dart';
import 'widgets/auth_footer_link.dart';
import 'widgets/auth_scaffold.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
            name: _name.text,
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
        if (ModalRoute.of(context)?.isCurrent != true) return;

        if (state.isAuthenticated) {
          // A new account starts from zero: reload the saved progress.
          context.read<ProgressCubit>().reload();
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
          title: 'Create Account',
          subtitle: 'Join Quizzy and start challenging yourself.',
          formKey: _formKey,
          children: [
            CustomTextField(
              label: 'Full Name',
              hint: 'Enter your name',
              prefixIcon: Icons.person_outline,
              controller: _name,
              validator: Validators.name,
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Confirm Password',
              hint: 'Re-enter your password',
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              controller: _confirm,
              validator: (v) => Validators.confirmPassword(_password.text)(v),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Register',
              icon: Icons.arrow_forward,
              isLoading: state.isLoading,
              onPressed: _onRegister,
            ),
            const SizedBox(height: 24),
            AuthFooterLink(
              text: 'Already have an account?',
              actionText: 'Login',
              // Register was pushed on top of Login, so just go back to it.
              onTap: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
