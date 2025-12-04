// lib/calculator_provider.dart
import 'package:flutter/foundation.dart';

class CalculatorProvider with ChangeNotifier {
  String _display = '0';
  double? _num1;
  double? _num2;
  String? _operand;

  String get display => _display;

  void inputNumber(String digit) {
    if (_display == '0' && digit != '.') {
      _display = digit;
    } else if (_display.contains('.') && digit == '.') {
      // Hindari titik desimal ganda
      return;
    } else {
      _display += digit;
    }
    notifyListeners();
  }

  void inputOperation(String op) {
    if (_display == '0') return;
    _num1 = double.parse(_display);
    _operand = op;
    _display = '0';
    notifyListeners();
  }

  void calculate() {
    if (_operand == null || _num1 == null) return;
    _num2 = double.parse(_display);

    double result = 0;
    switch (_operand) {
      case '+':
        result = _num1! + _num2!;
        break;
      case '-':
        result = _num1! - _num2!;
        break;
      case '×':
        result = _num1! * _num2!;
        break;
      case '÷':
        if (_num2 == 0) {
          _display = 'Error';
          reset();
          notifyListeners();
          return;
        }
        result = _num1! / _num2!;
        break;
      default:
        return;
    }

    // Tampilkan hasil tanpa .0 jika bilangan bulat
    if (result == result.toInt()) {
      _display = result.toInt().toString();
    } else {
      _display = result.toString();
    }

    reset();
    notifyListeners();
  }

  void clear() {
    _display = '0';
    reset();
    notifyListeners();
  }

  void reset() {
    _num1 = null;
    _num2 = null;
    _operand = null;
  }
}
