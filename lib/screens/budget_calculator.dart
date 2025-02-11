import 'package:flutter/material.dart';
import '../widgets/budget_pie_chart.dart';

// BudgetCalculator is the main screen widget that manages the form and overall layout
class BudgetCalculator extends StatefulWidget {
  const BudgetCalculator({super.key});

  @override
  _BudgetCalculatorState createState() => _BudgetCalculatorState();
}

class _BudgetCalculatorState extends State<BudgetCalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _salaryController = TextEditingController();
  bool _isDarkMode = false;
  bool _showChart = false;
  double _salary = 0;

  // Clean up the controller when the widget is disposed
  @override
  void dispose() {
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Budget Calculator'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
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
      ),
    );
  }
}
