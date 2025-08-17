import 'package:flutter/material.dart';

class TodoCompleteCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const TodoCompleteCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (val) {
            onChanged(val ?? false);
          },
        ),
        const Text('Аяқталған'),
      ],
    );
  }
}
