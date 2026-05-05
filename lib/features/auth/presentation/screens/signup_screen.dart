import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/auth/presentation/bloc/auth_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  void _submit(BuildContext ctx) {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidate = AutovalidateMode.onUserInteraction);
      return;
    }
    ctx.read<AuthBloc>().add(
          AuthRegisterRequested(
            firstName: _firstName.text.trim(),
            lastName: _lastName.text.trim(),
            email: _email.text.trim(),
            password: _password.text,
          ),
        );
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (ctx, s) {
        if (s is AuthUnauthenticated && s.message != null) {
          AppToast.error(ctx, s.message!);
        }
        if (s is AuthAuthenticated) {
          AppToast.success(ctx, 'Welcome back, ${s.user.firstName}!');
        }
      },
      builder: (ctx, s) {
        final loading = s is AuthLoading;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Account',
                        style: AppTextStyles.headlineLarge,
                      ),
                      AppSpacing.gapXs,
                      Text(
                        'Set up your account to track budgets, bills, and savings.',
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textMuted),
                      ),
                    ],
                  ),
                  AppSpacing.gapLg,
                  GradientCard(
                    padding: 16,
                    child: Form(
                      key: _formKey,
                      autovalidateMode: _autovalidate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            controller: _firstName,
                            hint: 'First Name',
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (v) =>
                                Validators.name(v, field: 'First name'),
                          ),
                          AppSpacing.gapMd,
                          AppTextField(
                            controller: _lastName,
                            hint: 'Last Name',
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (v) =>
                                Validators.name(v, field: 'Last name'),
                          ),
                          AppSpacing.gapMd,
                          AppTextField(
                            controller: _email,
                            hint: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: Validators.email,
                          ),
                          AppSpacing.gapMd,
                          AppTextField(
                            controller: _password,
                            hint: 'Password',
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            validator: Validators.password,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacing.gapSm,
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(
                      'Already have an account? Log in',
                      style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.accentBlue,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ),
                  AppSpacing.gapSm,
                  AppButton.primary(
                    label: 'Create account',
                    loading: loading,
                    onPressed: () => _submit(ctx),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
