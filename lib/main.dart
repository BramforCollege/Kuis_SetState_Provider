import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CalculatorProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator dengan Provider',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Layar kalkulator
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                calc.display,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Baris tombol
            buildButtonRow([
              CalculatorButton(
                text: 'C',
                onPressed: calc.clear,
                color: Colors.red,
              ),
              CalculatorButton(
                text: '÷',
                onPressed: () => calc.inputOperation('÷'),
              ),
              CalculatorButton(
                text: '×',
                onPressed: () => calc.inputOperation('×'),
              ),
              CalculatorButton(
                text: '⌫',
                onPressed: () {},
              ), // opsional: hapus karakter
            ]),
            buildButtonRow([
              CalculatorButton(
                text: '7',
                onPressed: () => calc.inputNumber('7'),
              ),
              CalculatorButton(
                text: '8',
                onPressed: () => calc.inputNumber('8'),
              ),
              CalculatorButton(
                text: '9',
                onPressed: () => calc.inputNumber('9'),
              ),
              CalculatorButton(
                text: '-',
                onPressed: () => calc.inputOperation('-'),
              ),
            ]),
            buildButtonRow([
              CalculatorButton(
                text: '4',
                onPressed: () => calc.inputNumber('4'),
              ),
              CalculatorButton(
                text: '5',
                onPressed: () => calc.inputNumber('5'),
              ),
              CalculatorButton(
                text: '6',
                onPressed: () => calc.inputNumber('6'),
              ),
              CalculatorButton(
                text: '+',
                onPressed: () => calc.inputOperation('+'),
              ),
            ]),
            buildButtonRow([
              CalculatorButton(
                text: '1',
                onPressed: () => calc.inputNumber('1'),
              ),
              CalculatorButton(
                text: '2',
                onPressed: () => calc.inputNumber('2'),
              ),
              CalculatorButton(
                text: '3',
                onPressed: () => calc.inputNumber('3'),
              ),
            ]),
            buildButtonRow([
              CalculatorButton(
                text: '0',
                onPressed: () => calc.inputNumber('0'),
                flex: 2,
              ),
              CalculatorButton(
                text: '.',
                onPressed: () => calc.inputNumber('.'),
              ),
              CalculatorButton(
                text: '=',
                onPressed: calc.calculate,
                color: Colors.green,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget buildButtonRow(List<Widget> buttons) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons,
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final int flex;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[800],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
