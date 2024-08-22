import 'package:flutter/material.dart';

class DropdownRow<T> extends StatelessWidget {
  final String title;
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final Widget Function(T) itemBuilder;
  final T Function(T) valueBuilder;

  const DropdownRow({
    super.key,
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.itemBuilder,
    required this.valueBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        DropdownButton<T>(
          value: value,
          onChanged: onChanged,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: valueBuilder(item), // Usa valueBuilder aquí
              child: itemBuilder(item),
            );
          }).toList(),
        ),
      ],
    );
  }
}
