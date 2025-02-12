import 'package:flutter/material.dart';

class WantsScreen extends StatelessWidget {
  final double monthlyAmount;

  const WantsScreen({
    Key? key,
    required this.monthlyAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The theme will automatically be applied because we're using MaterialApp's theme
    return Scaffold(
      appBar: AppBar(
        title: Text('Wants Breakdown'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Wants Budget',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text(
              '\$${monthlyAmount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // Add more content specific to wants here
          ],
        ),
      ),
    );
  }
}
