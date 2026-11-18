import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final firstController = TextEditingController();
  final secondController = TextEditingController();
  String result = '';

  void calculate(String operation) {
    final first = double.tryParse(firstController.text.trim());
    final second = double.tryParse(secondController.text.trim());
    if (first == null || second == null) {
      setState(() => result = 'Enter two valid numbers.');
      return;
    }
    if (operation == '/' && second == 0) {
      setState(() => result = 'Cannot divide by zero.');
      return;
    }

    final value = switch (operation) {
      '+' => first + second,
      '-' => first - second,
      '*' => first * second,
      '/' => first / second,
      _ => 0,
    };
    setState(() => result = 'Result: $value');
  }

  void clear() {
    firstController.clear();
    secondController.clear();
    setState(() => result = '');
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: firstController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'First number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: secondController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Second number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => calculate('+'),
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => calculate('-'),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => calculate('*'),
                  child: const Text('×'),
                ),
                ElevatedButton(
                  onPressed: () => calculate('/'),
                  child: const Text('÷'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(result, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: clear, child: const Text('Clear')),
          ],
        ),
      ),
    );
  }
}
