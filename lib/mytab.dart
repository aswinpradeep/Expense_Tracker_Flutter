import './mydart4.dart';
import 'package:flutter/material.dart';
import './mydart1.dart';

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
              centerTitle: true,
              title: Text("Expense Tracker"),

              backgroundColor: Color(0xffa4a1fb),
              elevation: .01,
              bottom: TabBar(
                indicatorWeight: .1,
                labelPadding: EdgeInsets.all(0),
                tabs: [
                  // new Container(
                  //   width: 300.0,
                  //   child: new Tab(text: 'Expense'),
                  //   color: Color(0xFFF35B8C),
                  // ),

                  Tab(
                    child: Container(
                      // color:Color(0xffffffff) ,
                      decoration: BoxDecoration(
                        color: Color(0xFFF35B8C),
                        // borderRadius: BorderRadius.circular(50),
                        // border: Border.all(color: Colors.blue, width: 1)
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Expense"),
                      ),
                    ),
                  ),

                  // Tab(text: "Expense",),
                  Tab(
                    child: Container(
                      // color:Color(0xffffffff) ,
                      decoration: BoxDecoration(
                        color: Color(0xff69b5ff),
                        // borderRadius: BorderRadius.circular(50),
                        // border: Border.all(color: Colors.blue, width: 1)
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Income"),
                      ),
                    ),
                  ),
                ],
              ),
              // title: Text('Tabs Demo'),
            ),
          ),
          body: TabBarView(
            children: [
              MyApp1(),
              MyApp4(),
            ],
          ),
        ),
      ),
    );
  }
}
