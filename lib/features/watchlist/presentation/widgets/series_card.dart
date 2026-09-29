import 'package:flutter/material.dart';

import '../../domain/entities/series.dart';
import 'watch_progress.dart';

class SeriesCard extends StatelessWidget {
  const SeriesCard({
    super.key,
    required this.series,
    required this.onTap,
  });

  final Series series;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                series.title,
                style: theme.textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '${series.seriesStatus.label} • ${series.watchStatus.label}',
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (final genre in series.genres)
                    Chip(label: Text(genre.label)),
                ],
              ),
              const SizedBox(height: 16),
              WatchProgressBar(series: series),
            ],
          ),
        ),
      ),
    );
  }
}