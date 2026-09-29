import 'package:flutter/material.dart';

import '../../domain/entities/series.dart';

class WatchProgressBar extends StatelessWidget {
  const WatchProgressBar({
    super.key,
    required this.series,
  });

  final Series series;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall;
    final progress = series.progress;

    if (progress == null) {
      return Text('${series.watchedEpisodes} ep watched', style: textStyle);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(value: progress),
        const SizedBox(height: 4),
        Text(
          '${series.watchedEpisodes} / ${series.totalEpisodes} ep',
          style: textStyle,
        ),
      ],
    );
  }
}