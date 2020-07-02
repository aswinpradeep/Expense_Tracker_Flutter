import 'dart:convert';

import 'package:flutter/material.dart';
import './xincomeExpChart.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'url.dart';

class Charts11 extends StatefulWidget {
  Charts11({Key key}) : super(key: key);

  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts11> {
  var url =
      '${Api.generalurl}/TotalExpenseTotalIncomeBar_year?userId=${Api.userid}';
  var isLoading = false;
  IncomeExpense customData;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    getapidetails();
  }

  void getapidetails() async {
    var response = await http.get(url);
    customData = IncomeExpense.fromJson(json.decode(response.body));
    print('heyy');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : HorizontalBarChart12.withCustomData(customData),
      // child: Text("fgfg"),
    );
  }
}

class IncomeExpense {
  double income;
  double expense;

  IncomeExpense({
    this.income,
    this.expense,
  });
  factory IncomeExpense.fromJson(Map<String, dynamic> parsedJson) {
    return IncomeExpense(
      income: parsedJson['TotalIncome'],
      expense: parsedJson['TotalExpense'],
    );
  }
}
