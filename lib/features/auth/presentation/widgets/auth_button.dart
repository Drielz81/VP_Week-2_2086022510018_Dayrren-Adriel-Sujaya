import 'package:flutter/material.dart';
import 'package:week2/core/theme/app_theme.dart';
import 'package:week2/core/theme/app_size.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String buttonText;
  final VoidCallback? onPressed;
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final middleColor = isDark ? AppTheme.blackColor : AppTheme.whiteColor;
    final textColor = isDark ? AppTheme.whiteColor : AppTheme.blackColor;

    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.seedColor, middleColor, AppTheme.gradientColor1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 16,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(AppSize.maxSize, AppSize.minimumHeight),
          backgroundColor: AppTheme.transparentColor,
          shadowColor: AppTheme.transparentColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
