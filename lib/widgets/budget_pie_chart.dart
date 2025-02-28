import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../screens/needs_screen.dart';
import '../screens/wants_screen.dart';
import '../screens/investing_screen.dart';

class BudgetPieChart extends StatelessWidget {
  final double salary;

  const BudgetPieChart({
    super.key,
    required this.salary,
  });

  void _onPieChartSectionPressed(int index, BuildContext context) {
    final monthly = salary / 12;
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NeedsScreen(monthlyAmount: monthly * 0.5)),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WantsScreen(monthlyAmount: monthly * 0.3)),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InvestingScreen(monthlyAmount: monthly * 0.2)),
        );
        break;
    }
  }

  List<PieChartSectionData> _getSections() {
    final monthly = salary / 12;
    return [
      PieChartSectionData(
        value: monthly * 0.5,
        title: 'Needs\n${(monthly * 0.5).toStringAsFixed(2)}',
        color: Colors.blue,
        radius: 100,
        titleStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        value: monthly * 0.3,
        title: 'Wants\n${(monthly * 0.3).toStringAsFixed(2)}',
        color: Colors.green,
        radius: 100,
        titleStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        value: monthly * 0.2,
        title: 'Investing\n${(monthly * 0.2).toStringAsFixed(2)}',
        color: Colors.amber,
        radius: 100,
        titleStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  if (event is FlTapUpEvent &&
                      pieTouchResponse?.touchedSection != null) {
                    final sectionIndex =
                        pieTouchResponse!.touchedSection!.touchedSectionIndex;
                    _onPieChartSectionPressed(sectionIndex, context);
                  }
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLegend(),
      ],
    );
  }
}
