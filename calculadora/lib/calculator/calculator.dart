import 'package:flutter/material.dart';
import 'calculator_display.dart';
import 'calculator_button.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _display = '0';
  String _currentValue = '';
  String _operator = '';
  double _firstNumber = 0;
  double _secondNumber = 0;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        _display = '0';
        _currentValue = '';
        _operator = '';
        _firstNumber = 0;
        _secondNumber = 0;
      } else if (buttonText == 'CE') {
        _currentValue = '';
        _display = '0';
      } else if (buttonText == '+' || buttonText == '-' || buttonText == 'X' || buttonText == '/' || buttonText == '%') {
        _operator = buttonText;
        _firstNumber = double.parse(_currentValue);
        _currentValue = '';
      } else if (buttonText == '=') {
        _secondNumber = double.parse(_currentValue);
        _calculateResult();
      } else {
        _currentValue += buttonText;
        _display = _currentValue;
      }
    });
  }

  void _calculateResult() {
    switch (_operator) {
      case '+':
        _display = (_firstNumber + _secondNumber).toString();
        break;
      case '-':
        _display = (_firstNumber - _secondNumber).toString();
        break;
      case 'X':
        _display = (_firstNumber * _secondNumber).toString();
        break;
      case '/':
        _display = (_firstNumber / _secondNumber).toString();
        break;
      case '%':
        _display = (_firstNumber % _secondNumber).toString();
        break;
      default:
        _display = 'Error';
    }
    _currentValue = _display;
    _operator = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Column(
        children: [
          CalculatorDisplay(display: _display),
          Expanded(
            child: Column(
              children: [
                // Primera fila
                Row(
                  children: [
                    Expanded(
                      child: CalculatorButton(
                        label: 'AC',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.errorContainer,
                      ),
                    ),
                    Expanded(
                      child: CalculatorButton(
                        label: 'CE',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.errorContainer,
                      ),
                    ),
                    Expanded(
                      child: CalculatorButton(
                        label: '%',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                    Expanded(
                      child: CalculatorButton(
                        label: '/',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                  ],
                ),
                // Segunda fila
                Row(
                  children: [
                    Expanded(
                      child: CalculatorButton(
                        label: '7',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                    ),
                    Expanded(
                      child: CalculatorButton(
                        label: '8',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                    ),
                    Expanded(
                      child: CalculatorButton(
                        label: '9',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                    ),
                    Expanded(
                      child: CalculatorButton(
                        label: 'X',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                  ],
                ),
                // Tercera fila
                Row(
                  children: [
                    Expanded(
                      child: CalculatorButton(
                        label: '4',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                    ),
                    Expanded(
                      child: CalculatorButton(
                        label: '5',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                    ),
                    Expanded(
                      child: CalculatorButton(
                        label: '6',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                    ),
                    Expanded(
                      child: CalculatorButton(
                        label: '-',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                  ],
                ),
                // Cuarta fila
                Row(
                  children: [
                    Expanded(
                      child: CalculatorButton(
                        label: '1',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                    ),
                    Expanded(
                      child: CalculatorButton(
                        label: '2',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                    ),
                    Expanded(
                      child: CalculatorButton(
                        label: '3',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                    ),
                    // Botón "+" que ocupa dos filas
                    Expanded(
                      child: Container(
                        height: 150, // Altura para dos filas
                        padding: const EdgeInsets.all(8.0),
                        child: CalculatorButton(
                          label: '+',
                          onPressed: _onButtonPressed,
                          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
                // Quinta fila
                Row(
                  children: [
                    Expanded(
                      flex: 2, // Ocupa dos celdas
                      child: CalculatorButton(
                        label: '0',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                        isLarge: true,
                      ),
                    ),
                    Expanded(
                      child: CalculatorButton(
                        label: '.',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                    ),
                    Expanded(
                      child: CalculatorButton(
                        label: '=',
                        onPressed: _onButtonPressed,
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}