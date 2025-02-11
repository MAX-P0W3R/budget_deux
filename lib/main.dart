import 'package:flutter/material.dart';
import 'screens/budget_calculator.dart';

void main() => runApp(BudgetCalculatorApp());

class BudgetCalculatorApp extends StatelessWidget {
  const BudgetCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: BudgetCalculator(),
    );
  }
}
