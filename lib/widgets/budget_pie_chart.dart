import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// BudgetPieChart is a reusable widget that handles the visualization of the budget data
class BudgetPieChart extends StatelessWidget {
  final double salary;

  const BudgetPieChart({
    super.key,
    required this.salary,
  });

  // Calculate the sections for the pie chart based on the 50/30/20 rule
  List<PieChartSectionData> _getSections() {
    final monthly = salary / 12;
    return [
      PieChartSectionData(
        value: monthly * 0.5,
        title: 'Needs\n${(monthly * 0.5).toStringAsFixed(2)}',
        color: Colors.blue,
        radius: 100,
      ),
      PieChartSectionData(
        value: monthly * 0.3,
        title: 'Wants\n${(monthly * 0.3).toStringAsFixed(2)}',
        color: Colors.green,
        radius: 100,
      ),
      PieChartSectionData(
        value: monthly * 0.2,
        title: 'Investing\n${(monthly * 0.2).toStringAsFixed(2)}',
        color: Colors.amber,
        radius: 100,
      ),
    ];
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _legendItem('Needs (50%)', Colors.blue),
        _legendItem('Wants (30%)', Colors.green),
        _legendItem('Investing (20%)', Colors.amber),
      ],
    );
  }

  Widget _legendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 4),
        Text(text),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              sections: _getSections(),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLegend(),
      ],
    );
  }
}
