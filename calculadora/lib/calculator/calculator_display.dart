import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final String display;

  const CalculatorDisplay({super.key, required this.display});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerRight,
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        border: Border.all(color: Colors.grey),
      ),
      child: Text(
        display,
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}