/// Horizontal bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class HorizontalBarChart3 extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final List<String> list1 = ['2014', '2015', '2016', '2017'];
  final List<int> list2 = [5, 25, 100, 75];

  HorizontalBarChart3(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory HorizontalBarChart3.withCustomData(customData) {
    print("hello");
    print(customData);
    return new HorizontalBarChart3(
      _createCustomData(customData),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
//     final customTickFormatter =
// charts.BasicNumericTickFormatterSpec((num value) {
//   if (value == 1) {
//     return "Jan";
//   } else if (value == 2) {
//     return "Feb";
//   } else if (value == 3) {
//     return "Mar";
//   } else if (value == 4) {
//     return "Apr";
//   } else if (value == 5) {
//     return "May";
//   } else if (value == 6) {
//     return "Jun";
//   } else if (value == 7) {
//     return "Jul";
//   }else if (value == 8) {
//     return "Aug";
//   }else if (value == 9) {
//     return "Sep";
//   }else if (value == 10) {
//     return "Oct";
//   }else if (value == 11) {
//     return "Nov";
//   }else if (value == 12) {
//     return "Dec";
//   }
// });

    // For horizontal bar charts, set the [vertical] flag to false.
    return new charts.LineChart(
      seriesList,
      defaultRenderer: new charts.LineRendererConfig(
          includeArea: false, stacked: false, includePoints: true),
      animate: true,
      animationDuration: Duration(seconds: 0),
      primaryMeasureAxis:
          new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
      //               domainAxis: charts.NumericAxisSpec(

      //   tickProviderSpec:
      //   charts.BasicNumericTickProviderSpec(desiredTickCount: 12),
      //   tickFormatterSpec: customTickFormatter,
      // ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, int>> _createCustomData(customData) {
    // final data = [
    //   new OrdinalSales('2014', 5),
    //   new OrdinalSales('2015', 25),
    //   new OrdinalSales('2016', 100),
    //   new OrdinalSales('2017', 75),
    // ];
    List<OrdinalSales> data = [];
    customData.forEach((d) {
      data.add(new OrdinalSales(d['Day'], d['TotalExpense']));
    });

    return [
      new charts.Series<OrdinalSales, int>(
        id: 'Sales',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
        colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault,
        fillColorFn: (OrdinalSales sales, _) {
          return charts.MaterialPalette.black;
        },
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final int year;
  final double sales;

  OrdinalSales(this.year, this.sales);
}
