import 'package:flutter/material.dart';

class TodoPriorityDropdown extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const TodoPriorityDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Маңыздылығы:'),
        const SizedBox(width: 10),
        DropdownButton<int>(
          value: value,
          onChanged: (val) {
            if (val != null) onChanged(val);
          },
          items: List.generate(
            5,
                (index) => DropdownMenuItem(
              value: index + 1,
              child: Text('${index + 1}'),
            ),
          ),
        ),
      ],
    );
  }
}
