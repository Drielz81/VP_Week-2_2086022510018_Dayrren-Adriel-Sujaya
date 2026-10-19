import 'package:flutter/material.dart';
// import 'package:week2/features/auth/presentation/pages/login_page.dart';
import 'package:week2/features/auth/presentation/pages/sign_up_page.dart';

import 'core/theme/app_theme.dart';
import 'features/watchlist/domain/entities/series.dart';

// import 'features/auth/presentation/pages/sign_up_page.dart';

class DonghuaWatchlistApp extends StatelessWidget {
  const DonghuaWatchlistApp({
    super.key,
    required this.loadSeries,
    this.themeMode = ThemeMode.system,
  });

  final Future<List<Series>> Function() loadSeries;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Donghua Watchlist',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: const SignUpPage(),
    );
  }
}
