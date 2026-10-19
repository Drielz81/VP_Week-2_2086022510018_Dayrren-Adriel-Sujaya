import 'package:flutter/material.dart';

import '../../domain/entities/genre.dart';
import '../../domain/entities/watch_status.dart';
import 'filter_chip_row.dart';
import 'series_search_field.dart';

class SeriesFilters extends StatelessWidget {
  const SeriesFilters({
    super.key,
    required this.searchController,
    required this.watchStatus,
    required this.genre,
    required this.onQueryChanged,
    required this.onWatchStatusChanged,
    required this.onGenreChanged,
    this.wrapChips = false,
  });

  final TextEditingController searchController;
  final WatchStatus? watchStatus;
  final Genre? genre;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<WatchStatus?> onWatchStatusChanged;
  final ValueChanged<Genre?> onGenreChanged;
  final bool wrapChips;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SeriesSearchField(
          controller: searchController,
          onChanged: onQueryChanged,
        ),
        const SizedBox(height: 8),
        FilterChipRow<WatchStatus>(
          options: WatchStatus.values,
          selected: watchStatus,
          labelOf: (status) => status.label,
          onSelected: onWatchStatusChanged,
          wrap: wrapChips,
        ),
        const SizedBox(height: 8),
        FilterChipRow<Genre>(
          options: Genre.values,
          selected: genre,
          labelOf: (g) => g.label,
          onSelected: onGenreChanged,
          wrap: wrapChips,
        ),
      ],
    );
  }
}
