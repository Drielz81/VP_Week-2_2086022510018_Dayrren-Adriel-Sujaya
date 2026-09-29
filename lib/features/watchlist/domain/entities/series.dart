import 'series_status.dart';
import 'genre.dart';
import 'watch_status.dart';

class Series {
  const Series({
    required this.id,
    required this.title,
    required this.genres,
    required this.seriesStatus,
    required this.watchStatus,
    required this.episodeDurationMinutes,
    required this.watchedEpisodes,
    this.totalEpisodes,
  });

  final String id;
  final String title;
  final List<Genre> genres;
  final SeriesStatus seriesStatus;
  final WatchStatus watchStatus;
  final int? totalEpisodes;
  final int episodeDurationMinutes;
  final int watchedEpisodes;

  double? get progress {
    final total = totalEpisodes;
    if (total == null || total == 0) return null;
    return watchedEpisodes / total;
  }

  int get totalWatchedMinutes => watchedEpisodes * episodeDurationMinutes;
}