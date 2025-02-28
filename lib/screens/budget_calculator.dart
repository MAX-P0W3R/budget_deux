import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/budget_pie_chart.dart';
import '../providers/theme_provider.dart';

class BudgetCalculator extends StatefulWidget {
  const BudgetCalculator({super.key});

  @override
  _BudgetCalculatorState createState() => _BudgetCalculatorState();
}

class _BudgetCalculatorState extends State<BudgetCalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _salaryController = TextEditingController();
  bool _showChart = false;
  double _salary = 0;

  @override
  void dispose() {
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Calculator'),
        actions: [
          IconButton(
            icon: Icon(
                themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _salaryController,
                decoration: InputDecoration(
                  labelText: 'Annual Salary',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your salary';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _salary = double.parse(_salaryController.text);
                      _showChart = true;
                    });
                  }
                },
                child: Text('Calculate'),
              ),
              if (_showChart) ...[
                SizedBox(height: 32),
                Expanded(
                  child: BudgetPieChart(salary: _salary),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
