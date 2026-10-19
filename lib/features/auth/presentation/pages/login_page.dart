
import 'package:flutter/material.dart';
import 'package:week2/core/theme/app_theme.dart';
import 'package:week2/features/auth/presentation/pages/sign_up_page.dart';
import 'package:week2/features/auth/presentation/widgets/auth_button.dart';
import 'package:week2/features/auth/presentation/widgets/auth_field.dart';
import 'package:week2/features/auth/presentation/widgets/character_image_background.dart';
import 'package:week2/features/auth/presentation/widgets/glass_card.dart';
import 'package:week2/features/auth/presentation/widgets/horizontal_margin.dart';
import 'package:week2/features/watchlist/presentation/pages/series_list_page.dart';
import 'package:week2/core/theme/app_spacing.dart';
import 'package:week2/core/theme/app_images.dart';

class LoginPage extends StatefulWidget {
  static MaterialPageRoute<dynamic> route() => MaterialPageRoute(builder: (context) => const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushAndRemoveUntil(
        context,
        SeriesListPage.route(),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppTheme.seedColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const CharacterBackground(images: AppImages.characterImages),

          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.blackColor.withValues(alpha: 0.35),
                  AppTheme.blackColor.withValues(alpha: 0.65),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: HorizontalMargin().horizontalMargin(context),
                  vertical: AppSpacing.lg,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: GlassCard(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Sign In',
                            style: textTheme.headlineSmall?.copyWith(
                              color: AppTheme.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          AuthField(
                            hintText: 'Email',
                            controller: _emailController,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          AuthField(
                            hintText: 'Password',
                            controller: _passwordController,
                            isObscureText: true,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          AuthButton(
                            buttonText: 'Sign In',
                            onPressed: _submit,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                              context,
                              SignUpPage.route(),
                            ),
                            child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: 'Don\'t have an account? ',
                                style: textTheme.titleMedium?.copyWith(
                                  color: AppTheme.whiteColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: textTheme.titleMedium?.copyWith(
                                      color: AppTheme.seedColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}



