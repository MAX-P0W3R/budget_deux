import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NeedsScreen extends StatefulWidget {
  final double monthlyAmount;

  const NeedsScreen({
    super.key,
    required this.monthlyAmount,
  });

  @override
  _NeedsScreenState createState() => _NeedsScreenState();
}

class _NeedsScreenState extends State<NeedsScreen> {
  late Map<String, int> categories;
  late double remainingBudget;
  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    categories = {
      'Rent/Mortgage': 0,
      'Groceries': 0,
      'Utilities': 0,
      'Car Payment': 0,
      'Health Insurance': 0,
      'Kids Daycare': 0,
    };

    // Initialize controllers for each category
    categories.forEach((key, value) {
      controllers[key] = TextEditingController();
    });

    remainingBudget = widget.monthlyAmount;
  }

  @override
  void dispose() {
    // Dispose all controllers
    controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void updateCategory(String category, String value) {
    int? newValue = int.tryParse(value);
    if (newValue != null && newValue >= 0 && newValue <= 100000) {
      setState(() {
        // Calculate the difference between new and old value
        int difference = newValue - categories[category]!;
        // Update category value
        categories[category] = newValue;
        // Update remaining budget
        remainingBudget -= difference;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Needs Breakdown'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Budget',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '\$${widget.monthlyAmount.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Remaining',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '\$${remainingBudget.toStringAsFixed(0)}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: remainingBudget < 0 ? Colors.red : null,
                              ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String category = categories.keys.elementAt(index);
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: controllers[category],
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(
                                6), // Limit to 6 digits (max 100000)
                          ],
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            border: OutlineInputBorder(),
                            hintText: 'Enter amount (\$USD)',
                            errorText: categories[category]! > 100000
                                ? 'Maximum amount is \$100000'
                                : null,
                          ),
                          onChanged: (value) => updateCategory(category, value),
                        ),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: categories[category]! / 100000,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
