class CalculatorLogic {//🐢
  String _displayValue = '0';

  String get displayValue => _displayValue;

  void clear() {
    _displayValue = '0';
  }

  void append(String value) {
    if (_displayValue == '0') {
      _displayValue = value;
    } else {
      _displayValue += value;
    }
  }

  void calculate() {
    // Implementar la lógica de cálculo aquí
  }
}//🐢