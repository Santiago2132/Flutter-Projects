import 'package:flutter/material.dart';
import 'calculator_display.dart';
import 'calculator_button.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Column(
        children: [
          const CalculatorDisplay(),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: const [
                CalculatorButton(label: 'AC'),
                CalculatorButton(label: 'CE'),
                CalculatorButton(label: '%'),
                CalculatorButton(label: '/'),
                CalculatorButton(label: '7'),
                CalculatorButton(label: '8'),
                CalculatorButton(label: '9'),
                CalculatorButton(label: 'X'),
                CalculatorButton(label: '4'),
                CalculatorButton(label: '5'),
                CalculatorButton(label: '6'),
                CalculatorButton(label: '-'),
                CalculatorButton(label: '1'),
                CalculatorButton(label: '2'),
                CalculatorButton(label: '3'),
                CalculatorButton(label: '+'),
                CalculatorButton(label: '0'),
                CalculatorButton(label: '.'),
                CalculatorButton(label: '='),
                CalculatorButton(label: '+', isLarge: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}