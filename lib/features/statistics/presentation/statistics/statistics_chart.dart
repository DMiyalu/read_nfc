import 'package:flutter/material.dart';
import 'customLineChart/customLineChart.dart';

class StatisticsChart extends StatefulWidget {
  const StatisticsChart({Key? key}) : super(key: key);

  @override
  State<StatisticsChart> createState() => _StatisticsChartState();
}

class _StatisticsChartState extends State<StatisticsChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            LineChartSample(chartData: {
              'dataTitle': 'Nombre des incitations recoltées',
              'maxNumber': '306.020',
              'percent': '1.3%',
              'cost': <double>[3.4, 2.9, 2.7, 1.9, 2.6, 3.2],
            }),
            LineChartSample(chartData: {
              'dataTitle': 'Nombre des incitations payées',
              'maxNumber': '253.031',
              'percent': '1.2%',
              'cost': <double>[2.8, 3.2, 2.6, 2.1, 2.9, 3.0],
            }),
            LineChartSample(chartData: {
              'dataTitle': 'Nombre des supervisions menées',
              'maxNumber': '288.459',
              'percent': '0.8%',
              'cost': <double>[2.2, 3.2, 3.6, 2.4, 2.8, 2.9],
            }),
            LineChartSample(chartData: {
              'dataTitle': 'Nombre des controls menés',
              'maxNumber': '288.459',
              'percent': '0.8%',
              'cost': <double>[2.2, 3.2, 3.6, 2.4, 2.8, 2.9],
            }),
          ],
        ),
      ),
    );
  }
}
