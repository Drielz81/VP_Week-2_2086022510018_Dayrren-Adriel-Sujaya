import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/watchlist/presentation/pages/series_list_page.dart';

void main() {
  runApp(const DonghuaWatchlistApp());
}

class DonghuaWatchlistApp extends StatelessWidget {
  const DonghuaWatchlistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donghua Watchlist',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const SeriesListPage(),
    );
  }
}