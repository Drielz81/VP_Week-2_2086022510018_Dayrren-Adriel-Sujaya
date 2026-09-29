import 'package:flutter/material.dart';

class FilterChipRow<T> extends StatelessWidget {
  const FilterChipRow({
    super.key,
    required this.options,
    required this.selected,
    required this.labelOf,
    required this.onSelected,
  });

  final List<T> options;
  final T? selected;
  final String Function(T option) labelOf;
  final ValueChanged<T?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final option in options) ...[
            FilterChip(
              label: Text(labelOf(option)),
              selected: option == selected,
              onSelected: (isOn) => onSelected(isOn ? option : null),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}