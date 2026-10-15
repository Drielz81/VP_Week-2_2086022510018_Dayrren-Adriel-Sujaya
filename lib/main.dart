import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'dev/harness.dart';
import 'features/watchlist/data/dummy_data.dart';

const bool _useHarness = true;

void main() {
  runApp(
    kDebugMode && _useHarness
        ? const LabHarness()
        : const DonghuaWatchlistApp(loadSeries: loadDummySeries),
  );
}