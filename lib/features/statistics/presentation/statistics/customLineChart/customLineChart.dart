// ignore: file_names
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LineChartSample extends StatefulWidget {
  const LineChartSample({Key? key, required this.chartData}) : super(key: key);
  final Map chartData;

  @override
  State<LineChartSample> createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            widget.chartData['dataTitle'],
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 8),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chartData['maxNumber'],
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          widget.chartData['percent'],
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                          textAlign: TextAlign.left,
                          softWrap: true,
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.arrow_downward,
                          color: Colors.red,
                          size: 14,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'mois passé',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                          textAlign: TextAlign.left,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                width: 190,
                child: mainData(cost: widget.chartData['cost']),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomTitlePoint(context, String day) {
    return Text(day,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 8,
              fontWeight: FontWeight.w400,
            ));
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = _bottomTitlePoint(context, 'L');
        break;
      case 2:
        text = _bottomTitlePoint(context, 'M');
        break;
      case 4:
        text = _bottomTitlePoint(context, 'M');
        break;
      case 6:
        text = _bottomTitlePoint(context, 'J');
        break;
      case 8:
        text = _bottomTitlePoint(context, 'V');
        break;
      case 10:
        text = _bottomTitlePoint(context, 'S');
        break;
      default:
        text = const SizedBox();
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChart mainData({required List<double> cost}) {
    return LineChart(LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, cost[0]),
            FlSpot(2, cost[1]),
            FlSpot(4, cost[2]),
            FlSpot(6, cost[3]),
            FlSpot(8, cost[4]),
            FlSpot(10, cost[5]),
          ],
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    ));
  }
}
