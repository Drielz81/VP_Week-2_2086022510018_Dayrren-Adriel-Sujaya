import 'package:flutter/material.dart';
import 'package:week2/core/theme/app_theme.dart';

class CharacterBackground extends StatelessWidget {
  const CharacterBackground({super.key, required this.images});

  final List<String> images;

  int _visibleCount(double width) {
    final int count;
    if (width < 600) {
      count = 4;
    } else if (width < 900) {
      count = 6;
    } else {
      count = 8;
    }
    return count.clamp(1, images.length);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = _visibleCount(constraints.maxWidth);

        return Row(
          children: [
            for (final path in images.take(count))
              Expanded(
                child: SizedBox(
                  height: constraints.maxHeight,
                  child: Image.asset(
                    path,
                    fit: BoxFit.cover, 
                    alignment: Alignment.topCenter,
                    errorBuilder: (_, _, _) => const ColoredBox(
                      color: AppTheme.seedColor,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}