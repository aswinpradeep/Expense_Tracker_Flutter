
import 'expense.dart';
import 'income.dart';
import 'incomeexpense.dart';
import 'package:flutter/material.dart';


class CardsMyApp extends StatefulWidget {
  // MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<CardsMyApp> {
  bool _value1 = false;
  bool _value2 = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);

Widget h()
{
  if(_value1&&!_value2)
   return Income();
   else{
     if(_value2&&!_value1)
      return Expense();
     else {
           if(_value2&&_value1)
              return IncomeExpense();
            else
               return Text('No cards to display.');}
   }
}
 

 
Widget checkbox()
{
  return new Container(

       
          
          child: new Column(
            children: <Widget>[
               Padding(padding: EdgeInsets.fromLTRB(50,10,50,10),
               child: Column(
                     children: <Widget>[
                       Row(  children: <Widget>[const Text('Income ', style: TextStyle(
                  color: Colors.blue, fontSize: 14,)),
              Checkbox(value: _value1, onChanged: _value1Changed, activeColor: Colors.blue),
             Spacer(),
               Checkbox(value: _value2, onChanged: _value2Changed, activeColor: Colors.pink[400]),
               const Text('Expense', style: TextStyle(
                  color: Colors.pink, fontSize: 14, )),
               ])])),

               
          
             
            
             
            ],
          ),
        
      );
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transactions',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor:  Color(0xffa4a1fb),
          title: Text('Transactions'),  

        ),
        // body: Api()
          body:Column(
        children: [
      //  Dashboard(),
       checkbox(),
       new Expanded(child: h()),
          
      ],)
      ),
    );
  }
}
