import 'package:flutter/material.dart';
import './categoryData.dart';

// import './chart.dart';
import './incomeExpData.dart';
import './lineData.dart';
// import './homepage.dart';

class ChartsApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Animated Charts App',
      theme: ThemeData(
        primaryColor: Color(0xffa4a1fb),
      ),
      home: Scaffold(
          //   appBar: AppBar(
          //     title: Text('Analytics',style: TextStyle(
          // color: Colors.white)),
          //   ),

          body: Container(
              child: Padding(
                  padding: EdgeInsets.all(7),
                  child: Stack(children: <Widget>[
                    Align(
                        alignment: Alignment.centerRight,
                        child: Column(children: <Widget>[
                          //  Padding(
                          //  padding: EdgeInsets.fromLTRB(20, 20, 20, 350),
                          //  child:  Charts1(),),
                          // Padding(
                          //  padding: EdgeInsets.fromLTRB(20, 200, 20, 180),
                          //  child:  Charts3(),),
                          //  Padding(
                          //  padding: EdgeInsets.fromLTRB(20, 350, 20, 20),
                          //  child:  Charts(),),
                          Expanded(
                            child: Card(
                                elevation: 0,
                                margin: EdgeInsets.all(5),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Charts1(),
                                )),
                          ),

                          Expanded(
                            child: Card(
                                elevation: 0,
                                margin: EdgeInsets.all(5),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Charts3(),
                                  ),
                                )),
                          ),
                          Expanded(
                            child: Card(
                                elevation: 0,
                                margin: EdgeInsets.all(5),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Charts(),
                                  ),
                                )),
                          ),
                        ]))
                  ])))
          // Container(
          //   padding: EdgeInsets.fromLTRB(20, 20, 20, 350),
          //   child: barChart(),

          // ),
          ),
    );
  }
}
