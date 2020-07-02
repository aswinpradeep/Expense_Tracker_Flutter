import './chartsmain.dart';
import './xchartsmain.dart';
import 'package:flutter/material.dart';

class ChartTab extends StatelessWidget {
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
              title: Text("Analytics"),

              backgroundColor: Color(0xffa4a1fb),
              elevation: .01,
              bottom: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                indicatorColor: Colors.white,
                // indicatorWeight: .1,
                labelPadding: EdgeInsets.all(0),
                tabs: [
                  Tab(
                    text: 'Monthly',
                  ),
                  Tab(
                    text: 'Yearly',
                  ),
                ],
              ),
              // title: Text('Tabs Demo'),
            ),
          ),
          body: TabBarView(
            children: [
              ChartsApp(),
              ChartsAppx(),
            ],
          ),
        ),
      ),
    );
  }
}
