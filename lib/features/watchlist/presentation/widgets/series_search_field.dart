import 'package:flutter/material.dart';

class SeriesSearchField extends StatelessWidget {
  const SeriesSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      hintText: 	'Search series',
      leading: const Icon(Icons.search),
      trailing: [
        if (controller.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Clear search',
            onPressed: () {
              controller.clear();
              onChanged('');
            },
          ),
      ],
      onChanged: onChanged,
    );
  }
}