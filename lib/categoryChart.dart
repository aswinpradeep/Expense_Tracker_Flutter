/// Horizontal bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class HorizontalBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final List<String> list1 = ['2014', '2015', '2016', '2017'];
  final List<int> list2 = [5, 25, 100, 75];

  HorizontalBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory HorizontalBarChart.withCustomData(customData) {
    print("hello");
    print(customData);
    return new HorizontalBarChart(
      _createCustomData(customData),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // For horizontal bar charts, set the [vertical] flag to false.
    return new charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,

      barRendererDecorator: new charts.BarLabelDecorator<String>(
          labelPosition: charts.BarLabelPosition.auto),

      domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis:
          new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createCustomData(
      customData) {
    // final data = [
    //   new OrdinalSales('2014', 5),
    //   new OrdinalSales('2015', 25),
    //   new OrdinalSales('2016', 100),
    //   new OrdinalSales('2017', 75),
    // ];
    List<OrdinalSales> data = [];
    customData.forEach((d) {
      data.add(new OrdinalSales(d['CATEGORY_NAME'], d['SUMAMOUNT']));
    });

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        labelAccessorFn: (OrdinalSales sales, _) => '${sales.year}',
        data: data,
        fillColorFn: (OrdinalSales sales, _) {
          return charts.MaterialPalette.pink.shadeDefault;
        },
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final double sales;

  OrdinalSales(this.year, this.sales);
}
