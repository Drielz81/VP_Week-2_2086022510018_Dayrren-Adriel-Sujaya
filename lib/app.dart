import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/watchlist/domain/entities/series.dart';
import 'features/watchlist/presentation/pages/series_list_page.dart';

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
      title: 'Donghua Watchlist',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: SeriesListPage(loadSeries: loadSeries),
    );
  }
}