enum WatchStatus {
  wantToWatch('Want to Watch'),
  watching('Watching'),
  watched('Watched');

  final String label;
  const WatchStatus(this.label);
}