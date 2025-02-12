import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/budget_calculator.dart';
import 'providers/theme_provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: BudgetCalculatorApp(),
      ),
    );

class BudgetCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Budget Calculator',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: BudgetCalculator(),
        );
      },
    );
  }
}
