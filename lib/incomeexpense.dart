import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';

import './podo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'url.dart';

class IncomeExpense extends StatefulWidget {
  // MyApp({Key key}) : super(key: key);

  @override
  _App createState() => _App();
}

class _App extends State<IncomeExpense> {
  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax

  Color type1 = Colors.pink[400];
  Color type2 = Colors.blue[400];
  List<Article> list;
  var isLoading = false;

  void fetchAlbum() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get('${Api.generalurl}/getIncomeExpense?userId=${Api.userid}');

    if (response.statusCode == 200) {
      var jsonResp = convert.jsonDecode(response.body);
      print(jsonResp);

      list = (json.decode(response.body) as List)
          .map((data) => new Article.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    // print('**********************************************hey');
    fetchAlbum();
  }

  Color color(int type) {
    if (type == 0) return type1;
    if (type == 1) return type2;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(7),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          date(list[index].date,
                                              color(list[index].type)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          //  cryptoNameSymbol(),
                                          Spacer(),
                                          //  cryptoChange(),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          category(list[index].category,
                                              color(list[index].type)),
                                          SizedBox(
                                            width: 20,
                                          )
                                        ],
                                      ),
                                      //  Row(
                                      //    children: <Widget>[cryptoAmount()],
                                      //  )
                                    ],
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 70),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          item(list[index].item),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          //  cryptoNameSymbol(),
                                          Spacer(),
                                          //  cryptoChange(),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          amount(list[index].amount),
                                          SizedBox(
                                            width: 20,
                                          )
                                        ],
                                      ),
                                      //  Row(
                                      //    children: <Widget>[cryptoAmount()],
                                      //  )
                                    ],
                                  )),
                            ],
                          ),
                        )
                      ]),
                    ),
                  );
                  // ListTile(

                  //   contentPadding: EdgeInsets.all(10.0),
                  //   title: new Text('${list[index].category}, ${list[index].amount}, ${list[index].date}, ${list[index].item}'),

                  // );
                }));
  }

  Widget date(String val, Color c) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text('$val',
              style: TextStyle(
                color: c,
              ))),
    );
  }

  Widget category(String val, Color c) {
    return Align(
        alignment: Alignment.topRight,
        child: Text('$val',
            style: TextStyle(
              color: c,
            )));
  }

  Widget item(String val) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text('$val',
              style: TextStyle(
                  color: Colors.grey[900], fontSize: 18, letterSpacing: 3))),
    );
  }

  Widget amount(double val) {
    return Align(
        alignment: Alignment.topRight,
        child: Text('$val',
            style: TextStyle(
                color: Colors.grey[900], fontSize: 18, letterSpacing: 3)));
  }
}
