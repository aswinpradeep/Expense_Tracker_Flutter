import 'package:flutter/material.dart';
import './xcategoryChart.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'url.dart';

class Charts13 extends StatefulWidget {
  Charts13({Key key}) : super(key: key);

  @override
  _ChartsState createState() => _ChartsState();
}

class _ChartsState extends State<Charts13> {
  var url = '${Api.generalurl}/yearlycategorysum?userId=${Api.userid}';
  List customData;
  @override
  void initState() {
    super.initState();
    setState(() {
      customData = [];
    });
    getapidetails();
  }

  void getapidetails() async {
    var response = await http.get(url);
    var jsonResponse = convert.jsonDecode(response.body);
    print('heyy');
    print(jsonResponse);
    setState(() {
      customData = jsonResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HorizontalBarChart11.withCustomData(customData),
      // child: Text("fgfg"),
    );
  }
}
