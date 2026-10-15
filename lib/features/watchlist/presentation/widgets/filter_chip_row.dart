import 'package:flutter/material.dart';

class FilterChipRow<T> extends StatelessWidget {
  const FilterChipRow({
    super.key,
    required this.options,
    required this.selected,
    required this.labelOf,
    required this.onSelected,
    this.wrap = false,
  });

  final List<T> options;
  final T? selected;
  final String Function(T option) labelOf;
  final ValueChanged<T?> onSelected;
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    final chips = [
      for (final option in options)
        FilterChip(
          label: Text(labelOf(option)),
          selected: option == selected,
          onSelected: (isOn) => onSelected(isOn ? option : null),
        ),
    ];

    if (wrap) {
      return Wrap(spacing: 8, runSpacing: 8, children: chips);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final chip in chips) ...[chip, const SizedBox(width: 8)],
        ],
      ),
    );
  }
}