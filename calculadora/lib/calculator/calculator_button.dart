import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final Function(String) onPressed;
  final Color backgroundColor;
  final bool isLarge;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isLarge ? 150 : 70,
        height: 70,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}