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
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 columnas
                childAspectRatio: 1, // Mantiene los botones cuadrados
              ),
              itemCount: 19, // Número total de botones
              itemBuilder: (context, index) {
                // Definir los botones
                List<Map<String, dynamic>> buttons = [
                  {'label': 'AC', 'color': Theme.of(context).colorScheme.errorContainer},
                  {'label': 'CE', 'color': Theme.of(context).colorScheme.errorContainer},
                  {'label': '%', 'color': Theme.of(context).colorScheme.secondaryContainer},
                  {'label': '/', 'color': Theme.of(context).colorScheme.secondaryContainer},
                  {'label': '7', 'color': Theme.of(context).colorScheme.surfaceVariant},
                  {'label': '8', 'color': Theme.of(context).colorScheme.surfaceVariant},
                  {'label': '9', 'color': Theme.of(context).colorScheme.surfaceVariant},
                  {'label': 'X', 'color': Theme.of(context).colorScheme.secondaryContainer},
                  {'label': '4', 'color': Theme.of(context).colorScheme.surfaceVariant},
                  {'label': '5', 'color': Theme.of(context).colorScheme.surfaceVariant},
                  {'label': '6', 'color': Theme.of(context).colorScheme.surfaceVariant},
                  {'label': '-', 'color': Theme.of(context).colorScheme.secondaryContainer},
                  {'label': '1', 'color': Theme.of(context).colorScheme.surfaceVariant},
                  {'label': '2', 'color': Theme.of(context).colorScheme.surfaceVariant},
                  {'label': '3', 'color': Theme.of(context).colorScheme.surfaceVariant},
                  {'label': '0', 'color': Theme.of(context).colorScheme.surfaceVariant, 'isLarge': true},
                  {'label': '.', 'color': Theme.of(context).colorScheme.surfaceVariant},
                  {'label': '=', 'color': Theme.of(context).colorScheme.primaryContainer},
                ];

                // Si estamos en la posición del botón '+', lo colocamos más alto
                if (index == 15) {
                  return GridTile(
                    child: CalculatorButton(
                      label: '+',
                      onPressed: _onButtonPressed,
                      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      isTall: true, // Activa el tamaño doble
                    ),
                  );
                }

                // Si es cualquier otro botón, lo renderizamos normalmente
                Map<String, dynamic> btn = buttons[index < 15 ? index : index - 1];
                return CalculatorButton(
                  label: btn['label'],
                  onPressed: _onButtonPressed,
                  backgroundColor: btn['color'],
                  isLarge: btn.containsKey('isLarge') ? btn['isLarge'] : false,
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}