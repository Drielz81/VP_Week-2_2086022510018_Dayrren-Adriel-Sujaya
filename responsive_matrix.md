# Responsive matrix: Series list screen

| Screen | Test | Harness setting | Result | Fix noted |
|---|---|---|---|---|
| Series list | 1 Small phone | Small, portrait, Normal | Pass | |
| Series list | 2 Large phone | Large, portrait, Normal | Pass | |
| Series list | 3 Tablet | Tablet, portrait, Normal | Pass | Breakpoint 600 dp: filters move to a side panel (LayoutBuilder) |
| Series list | 4 Landscape | Small + Landscape | Pass | |
| Series list | 4 Landscape | Large + Landscape | Pass | |
| Series list | 4 Landscape | Tablet + Landscape | Pass | |
| Series list | 5 Long text | Small, 200-char name | Fail | Title uses maxLines 2 + ellipsis |
| Series list | 5 Long text | Tablet, 200-char name | Fail | |
| Series list | 6 Empty state | Small, Zero items | Pass | Icon + message + required action button |
| Series list | 6 Empty state | Tablet, Zero items | Paass | |
| Series list | 7 Long list | Small, 500 items | Pass | SliverList.separated (builder), no shrinkWrap |
| Series list | 7 Long list | Tablet, 500 items | Pass | |
| Series list | 8 Keyboard | Small + Landscape + Keyboard open | Pass | Filters moved into the scroll view (CustomScrollView) |
| Series list | 8 Keyboard | Small portrait + Keyboard open | Pass | |
| Series list | 9 Dark mode | Small + Dark | Pass | |
| Series list | 9 Dark mode | Tablet + Dark | Pass | |