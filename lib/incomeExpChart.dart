/// Horizontal bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class HorizontalBarChart1 extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final List<String> list1 = ['2014', '2015', '2016', '2017'];
  final List<int> list2 = [5, 25, 100, 75];

  HorizontalBarChart1(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory HorizontalBarChart1.withCustomData(customData) {
    print("hello");
    print(customData);
    return new HorizontalBarChart1(
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
    List<OrdinalSales> data = [];

    data.add(new OrdinalSales('Income', customData.income));
    data.add(new OrdinalSales('Expense', customData.expense));

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        labelAccessorFn: (OrdinalSales sales, _) => '${sales.sales}',
        data: data,
        fillColorFn: (OrdinalSales sales, _) {
          return (sales.year == 'Income')
              ? charts.MaterialPalette.blue.shadeDefault
              : charts.MaterialPalette.pink.shadeDefault;
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
