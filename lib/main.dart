import 'package:flutter/material.dart';

import 'app.dart';
import 'features/watchlist/data/dummy_data.dart';

void main() {
  runApp(const DonghuaWatchlistApp(loadSeries: loadDummySeries));
}
