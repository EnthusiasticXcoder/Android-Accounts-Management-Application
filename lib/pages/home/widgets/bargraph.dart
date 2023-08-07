import 'package:flutter/material.dart';
import 'package:my_app/services/node/database_node.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatelessWidget {
  final List<DatabaseNode> nodes;

  const BarChart({super.key, required this.nodes});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3.0),
      height: 150,
      child: SfCartesianChart(
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enablePanning: true,
          enableDoubleTapZooming: true,
          zoomMode: ZoomMode.x,
          maximumZoomLevel: 0.25,
        ),
        primaryXAxis: CategoryAxis(
          maximumLabels: 12,
          majorGridLines: const MajorGridLines(width: 0.0),
        ),
        primaryYAxis: NumericAxis(
          axisLabelFormatter: (axisLabelRenderArgs) {
            final label = formatNumber(axisLabelRenderArgs.value.toInt());
            const style = TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            );

            return ChartAxisLabel(label, style);
          },
          majorGridLines: const MajorGridLines(width: 0.2),
          decimalPlaces: 0,
          minimum: 0,
        ),
        series: <ChartSeries>[
          // Income Bar Graph
          plotBargraph(true),
          // Expense Bar graph
          plotBargraph(false),
        ],
      ),
    );
  }

  ColumnSeries<List, String> plotBargraph(bool isIncome) {
    final List<List> incomenodes = filterPlotData(isIncome);

    return ColumnSeries<List, String>(
      opacity: 0.9,
      color: (isIncome) ? Colors.green.shade800 : Colors.red.shade600,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0)),
      dataSource: incomenodes,
      xValueMapper: (List node, _) => node.elementAt(0),
      yValueMapper: (List node, _) => node.elementAt(1),
    );
  }

  List<List> filterPlotData(bool isIncome) {
    final monthlySum = <int, int>{};
    final notes = nodes;
    for (var note in notes) {
      if (note.isincome == isIncome && note.year == DateTime.now().year) {
        final month = note.month;
        final amount = note.amount;

        if (monthlySum.containsKey(month)) {
          monthlySum[month] = monthlySum[month]! + amount;
        } else {
          monthlySum[month] = amount;
        }
      }
    }
    List<List> data = [];
    monthlySum.forEach((key, value) {
      final month = monlist.elementAt(key - 1);
      data.add([month, value]);
    });
    return data;
  }

  String formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(0)}M';
    } else if (number <= 1000000 && number >= 1000) {
      return '${(number / 1000).toStringAsFixed(0)}k';
    } else {
      return number.toString();
    }
  }
}

const monlist = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];
