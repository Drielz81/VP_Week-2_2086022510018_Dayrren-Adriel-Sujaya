import 'package:flutter/material.dart';
import 'package:week2/core/theme/app_spacing.dart';

class HorizontalMargin {
  
  double horizontalMargin(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 360) return AppSpacing.md; 
    if (width < 600) return AppSpacing.lg; 
    return AppSpacing.xl; 
  }
}