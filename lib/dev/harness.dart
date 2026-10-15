import 'package:flutter/material.dart';

import '../app.dart';
import '../features/watchlist/data/dummy_data.dart';
import '../features/watchlist/domain/entities/watch_status.dart';
import '../features/watchlist/domain/entities/genre.dart';
import '../features/watchlist/domain/entities/series.dart';
import '../features/watchlist/domain/entities/series_status.dart';

enum _Device {
  small('Small phone', Size(320, 568)),
  large('Large phone', Size(430, 932)),
  tablet('Tablet', Size(800, 1280));

  const _Device(this.label, this.size);

  final String label;
  final Size size;
}

enum _Data {
  normal('Normal'),
  longName('200-char name'),
  empty('Zero items'),
  big('500 items');

  const _Data(this.label);

  final String label;

  List<Series> get items => switch (this) {
        _Data.normal => dummySeries,
        _Data.longName => [
            _testSeries(0, title: ('Long title ' * 17).substring(0, 200)),
            ...dummySeries,
          ],
        _Data.empty => const <Series>[],
        _Data.big => List.generate(500, _testSeries),
      };
}

Series _testSeries(int i, {String? title}) => Series(
      id: 'test-$i',
      title: title ?? 'Test series ${i + 1}',
      genres: [Genre.values[i % Genre.values.length]],
      seriesStatus: i.isEven ? SeriesStatus.ongoing : SeriesStatus.completed,
      watchStatus: WatchStatus.values[i % WatchStatus.values.length],
      totalEpisodes: 24,
      episodeDurationMinutes: 20,
      watchedEpisodes: i % 25,
    );

class LabHarness extends StatefulWidget {
  const LabHarness({super.key});

  @override
  State<LabHarness> createState() => _LabHarnessState();
}

class _LabHarnessState extends State<LabHarness> {
  _Device _device = _Device.small;
  _Data _data = _Data.normal;
  bool _landscape = false;
  bool _keyboard = false;
  bool _dark = false;
  bool _insets = false;

  Size get _screen => _landscape ? _device.size.flipped : _device.size;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Row(
            children: [
              SizedBox(width: 280, child: _panel(context)),
              const VerticalDivider(width: 1),
              Expanded(child: _stage(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _panel(BuildContext context) {
    final text = Theme.of(context).textTheme;

    Widget group(String title, List<Widget> chips) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: text.labelLarge),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: chips),
            const SizedBox(height: 16),
          ],
        );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        group('Screen', _choices(_Device.values, _device, (d) => d.label,
            (d) => _device = d)),
        group('Data', _choices(_Data.values, _data, (d) => d.label,
            (d) => _data = d)),
        group('Conditions', [
          _toggle('Landscape', _landscape, (v) => _landscape = v),
          _toggle('Keyboard open', _keyboard, (v) => _keyboard = v),
          _toggle('Dark mode', _dark, (v) => _dark = v),
          _toggle('Notch + gesture bar', _insets, (v) => _insets = v),
        ]),
        Text('${_screen.width.toInt()} x ${_screen.height.toInt()} dp',
            style: text.bodySmall),
      ],
    );
  }

  List<Widget> _choices<T>(
    List<T> values,
    T current,
    String Function(T) label,
    void Function(T) pick,
  ) {
    return [
      for (final v in values)
        ChoiceChip(
          label: Text(label(v)),
          selected: v == current,
          onSelected: (_) => setState(() => pick(v)),
        ),
    ];
  }

  Widget _toggle(String label, bool on, void Function(bool) assign) {
    return FilterChip(
      label: Text(label),
      selected: on,
      onSelected: (v) => setState(() => assign(v)),
    );
  }

  Widget _stage(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final kb = _keyboard ? (_landscape ? 180.0 : 260.0) : 0.0;
    final inset = _insets
        ? EdgeInsets.only(
            top: _landscape ? 0 : 32, left: _landscape ? 32 : 0, bottom: 20)
        : EdgeInsets.zero;
    final safe = kb > 0 ? inset.copyWith(bottom: 0) : inset;
    final media = MediaQuery.of(context).copyWith(
      size: _screen,
      padding: safe,
      viewPadding: safe,
      viewInsets: EdgeInsets.only(bottom: kb),
    );

    return ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox.fromSize(
            size: _screen,
            child: MediaQuery(
              data: media,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  DonghuaWatchlistApp(
                    key: ValueKey(_data),
                    loadSeries: () async => _data.items,
                    themeMode: _dark ? ThemeMode.dark : ThemeMode.light,
                  ),
                  if (safe.top > 0)
                    _fake(Alignment.topCenter, scheme.scrim, h: safe.top),
                  if (safe.left > 0)
                    _fake(Alignment.centerLeft, scheme.scrim, w: safe.left),
                  if (safe.bottom > 0)
                    _fake(Alignment.bottomCenter, scheme.scrim, h: safe.bottom),
                  if (kb > 0)
                    _fake(Alignment.bottomCenter, scheme.inverseSurface, h: kb),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fake(Alignment at, Color color, {double? w, double? h}) {
    return Align(
      alignment: at,
      child: IgnorePointer(
        child: SizedBox(width: w, height: h, child: ColoredBox(color: color)),
      ),
    );
  }
}