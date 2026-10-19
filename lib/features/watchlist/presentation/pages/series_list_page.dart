import 'package:flutter/material.dart';
import 'package:week2/features/watchlist/data/dummy_data.dart';

import '../../domain/entities/genre.dart';
import '../../domain/entities/series.dart';
import '../../domain/entities/watch_status.dart';
import '../widgets/empty_state.dart';
import '../widgets/series_card.dart';
import '../widgets/series_filters.dart';

class SeriesListPage extends StatefulWidget {
  static MaterialPageRoute<dynamic> route() =>
      MaterialPageRoute(builder: (context) => const SeriesListPage());
  const SeriesListPage({super.key, this.loadSeries = loadDummySeries});

  final Future<List<Series>> Function() loadSeries;

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
    setState(() => _isLoading = true);
    final series = await widget.loadSeries();
    if (!mounted) return;
    setState(() {
      _series = series;
      _isLoading = false;
    });
  }


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

  static const double _wideBreakpoint = 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donghua Watchlist')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= _wideBreakpoint;
          final filters = SizedBox(
            child: SeriesFilters(
              searchController: _searchController,
              watchStatus: _watchStatus,
              genre: _genre,
              onQueryChanged: (value) => setState(() => _query = value),
              onWatchStatusChanged: (status) =>
                  setState(() => _watchStatus = status),
              onGenreChanged: (genre) => setState(() => _genre = genre),
              wrapChips: isWide,
            ),
          );

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 320,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: filters,
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(child: CustomScrollView(slivers: _buildSlivers())),
              ],
            );
          }

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                sliver: SliverToBoxAdapter(child: filters),
              ),
              ..._buildSlivers(),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildSlivers() {
    if (_isLoading) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }

    if (_series.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyState(
            icon: Icons.video_library_outlined,
            title: 'Your watchlist is empty',
            message: 'Series you add will show up here.',
            actionLabel: 'Reload',
            onAction: _loadSeries,
          ),
        ),
      ];
    }

    final visible = _visibleSeries;
    if (visible.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyState(
            icon: Icons.search_off,
            title: 'No series found',
            message: _query.isEmpty
                ? 'No series match the selected filters.'
                : 'No series match "$_query".',
            actionLabel: 'Clear filters',
            onAction: _resetFilters,
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        sliver: SliverList.separated(
          itemCount: visible.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) =>
              SeriesCard(series: visible[index], onTap: () {}),
        ),
      ),
    ];
  }
}
