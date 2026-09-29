enum Genre {
  xianxia('Xianxia'),
  wuxia('Wuxia'),
  action('Action'),
  fantasy('Fantasy'),
  romance('Romance'),
  comedy('Comedy'),
  historical('Historical'),
  mystery('Mystery'),
  sciFi('Sci-Fi');

  const Genre(this.label);

  final String label;
}