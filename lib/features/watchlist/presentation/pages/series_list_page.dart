import 'package:flutter/material.dart';

import '../../data/dummy_data.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/series.dart';
import '../../domain/entities/watch_status.dart';
import '../widgets/empty_state.dart';
import '../widgets/filter_chip_row.dart';
import '../widgets/series_card.dart';
import '../widgets/series_search_field.dart';

class SeriesListPage extends StatefulWidget {
  const SeriesListPage({super.key});

  @override
  State<SeriesListPage> createState() => _SeriesListPageState();
}

class _SeriesListPageState extends State<SeriesListPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Series> _series = const [];
  bool _isLoading = true;
  String _query = '';
  WatchStatus? _watchStatus;
  Genre? _genre;

  @override
  void initState() {
    super.initState();
    _loadSeries();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSeries() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() {
      _series = dummySeries;
      _isLoading = false;
    });
  }

  bool get _hasActiveFilter =>
      _query.isNotEmpty || _watchStatus != null || _genre != null;

  List<Series> get _visibleSeries {
    final query = _query.trim().toLowerCase();
    return _series.where((series) {
      final matchesQuery = series.title.toLowerCase().contains(query);
      final matchesStatus =
          _watchStatus == null || series.watchStatus == _watchStatus;
      final matchesGenre = _genre == null || series.genres.contains(_genre);
      return matchesQuery && matchesStatus && matchesGenre;
    }).toList();
  }

  void _resetFilters() {
    _searchController.clear();
    setState(() {
      _query = '';
      _watchStatus = null;
      _genre = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donghua Watchlist')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SeriesSearchField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value),
                ),
                const SizedBox(height: 8),
                FilterChipRow<WatchStatus>(
                  options: WatchStatus.values,
                  selected: _watchStatus,
                  labelOf: (status) => status.label,
                  onSelected: (status) => setState(() => _watchStatus = status),
                ),
                const SizedBox(height: 8),
                FilterChipRow<Genre>(
                  options: Genre.values,
                  selected: _genre,
                  labelOf: (genre) => genre.label,
                  onSelected: (genre) => setState(() => _genre = genre),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_series.isEmpty) {
      return const EmptyState(
        icon: Icons.video_library_outlined,
        title: 'Your watchlist is empty',
        message: 'Series you add will show up here.',
      );
    }

    final visible = _visibleSeries;
    if (visible.isEmpty) {
      return EmptyState(
        icon: Icons.search_off,
        title: 'No series found',
        message: _query.isEmpty
            ? 'No series match the selected filters.'
            : 'No series match "$_query".',
        onReset: _hasActiveFilter ? _resetFilters : null,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: visible.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) => SeriesCard(
        series: visible[index],
        onTap: () {},
      ),
    );
  }
}