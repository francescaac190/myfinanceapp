import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfinanceapp/core/index.dart';
import 'package:myfinanceapp/features/auth/presentation/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

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
                  GradientCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: AppTextStyles.headlineLarge,
                        ),
                        AppSpacing.gapXs,
                        Text(
                          'Sign in to continue managing your finances',
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.gapLg,
                  AppTextField(
                    controller: _email,
                    hint: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  AppSpacing.gapMd,
                  AppTextField.password(
                    controller: _password,
                    textInputAction: TextInputAction.done,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot password?',
                        style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.accentBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      )),
                  AppButton.primary(
                    label: 'Log In',
                    loading: loading,
                    onPressed: () => ctx.read<AuthBloc>().add(
                          AuthLoginRequested(
                              _email.text.trim(), _password.text),
                        ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'New here? Create an account',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textMuted,
                        ),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
