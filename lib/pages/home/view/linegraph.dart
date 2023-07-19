import 'package:flutter/material.dart';
import 'package:my_app/services/database_node.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Linegraph extends StatelessWidget {
  final List<DatabaseNote> nodes;
  final int maxvalue;

  const Linegraph({super.key, required this.nodes, required this.maxvalue});

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
        ),
        backgroundColor: const Color.fromARGB(127, 100, 180, 246),
        primaryXAxis: DateTimeAxis(
            majorGridLines: const MajorGridLines(width: 0.0),
            labelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            )),
        primaryYAxis: NumericAxis(
            maximum: maxvalue.toDouble(),
            majorGridLines: const MajorGridLines(width: 0.2),
            decimalPlaces: 0,
            minimum: 0,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            )),
        series: <ChartSeries>[
          // Ploating income graph
          plotLinegraph(true),
          plotAreagraph(true),
          // Ploating Expense graph
          plotLinegraph(false),
          plotAreagraph(false),
        ],
      ),
    );
  }

  LineSeries<DatabaseNote, DateTime> plotLinegraph(bool isIncome) {
    final incomenodes = nodes
        .where((node) =>
            node.isincome == isIncome && node.year == DateTime.now().year)
        .toList();

    return LineSeries<DatabaseNote, DateTime>(
      color: (isIncome) ? Colors.green.shade800 : Colors.red.shade600,
      width: 2.0,
      dataSource: incomenodes,
      xValueMapper: (DatabaseNote node, _) =>
          DateTime(node.year, node.month, node.date, node.hour),
      yValueMapper: (DatabaseNote node, _) => node.amount,
    );
  }

  AreaSeries<DatabaseNote, DateTime> plotAreagraph(bool isIncome) {
    final incomenodes = nodes
        .where((node) =>
            node.isincome == isIncome && node.year == DateTime.now().year)
        .toList();

    return AreaSeries<DatabaseNote, DateTime>(
      opacity: 0.7,
      color: (isIncome) ? Colors.green.shade800 : Colors.red.shade600,
      dataSource: incomenodes,
      xValueMapper: (DatabaseNote node, _) =>
          DateTime(node.year, node.month, node.date, node.hour),
      yValueMapper: (DatabaseNote node, _) => node.amount,
    );
  }
}
