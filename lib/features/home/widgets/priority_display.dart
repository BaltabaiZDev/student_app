import 'package:flutter/material.dart';

class PriorityDisplay extends StatelessWidget {
  final int priority;
  const PriorityDisplay({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(5, (i) {
            return Icon(
              Icons.circle,
              size: 10,
              color: i < priority ? Colors.amber : Colors.grey[600],
            );
          }),
        ),
        const SizedBox(height: 2),
        const Text(
          'Маңыздылық',
          style: TextStyle(fontSize: 12, color: Colors.white60),
        ),
      ],
    );
  }
}
