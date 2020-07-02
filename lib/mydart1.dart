import './url.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:validation_extensions/validation_extensions.dart';
import 'package:dropdown_search/dropdown_search.dart';

class MyApp1 extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp1> {
  TextEditingController useridController = TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: "${"${DateTime.now().toLocal()}".split(' ')[0]}");
  TextEditingController itemController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController addcategoryController = TextEditingController();

  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  String password;

  String usernameValidation(String v) => v.isRequired()();

  String emailValidation(String v) => [v.isRequired(), v.isEmail()].validate();

  String ageValidation(String v) =>
      v.min(18, errorText: "You must be older than 18")();

  String passwordValidation(String v) => [
        v.isRequired(),
        v.minLength(8),
      ].validate();

  String confirmPasswordValidation(String v) => [
        v.isRequired(),
        v.minLength(8),
        v.match(password),
      ].validate();

  validate() {
    _formKey.currentState.validate();
  }

  resetForm() {
    _formKey.currentState.reset();
  }

  List<String> abc = List();

  var url = Api.listexpense;

  List<String> lst = List();
  List<int> lstid = List();

  List<String> _getapidetails = List();
  void getapidetails() async {
    var response = await http.get(url);
    var jsonResponse = convert.jsonDecode(response.body);

    jsonResponse.forEach((i) {
      lst.add(i["CATEGORY_NAME"]);
      lstid.add(i["ID"]);
    });
    setState(() {
      _getapidetails = lst;
      print(_getapidetails);
      print(abc);
      print(lstid);
      print(lstid[10]);
    });
  }

  @override
  void initState() {
    super.initState();
    getapidetails();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF35B8C),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      // width: 200,
                      padding: EdgeInsets.only(right: 100, left: 100),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        focusNode: FocusNode(),
                        enableInteractiveSelection: false,
                        controller: dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      validator: (v) => [
                        v.isRequired(
                          errorText: "Itemname is required",
                        ),
                        // v.isDouble(),
                        // v.minLength(
                        //   8,
                        //   errorText: "Password can not be less than 8 characters",
                        // ),
                      ].validate(),
                      style: TextStyle(color: Colors.white),
                      controller: itemController,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.account_circle),
                        labelText: 'Item Name',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[350]),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          //  when the TextFormField in focused
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      validator: (v) => [
                        v.isRequired(
                          errorText: "Amount is required",
                        ),
                        v.isDouble(errorText: "Amount must be numeric value"),
                      ].validate(),
                      style: TextStyle(color: Colors.white),
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: '₹',
                        labelText: 'Amount(₹)',
                        prefixStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[350]),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          //  when the TextFormField in focused
                        ),
                      ),
                    ),
                  ),

                  // Container(

                  //   padding: EdgeInsets.all(10),
                  //   child: SimpleAutoCompleteTextField(

                  //     // controller: categoryController,
                  //     controller: categoryController,
                  //     style: TextStyle(color: Colors.white),
                  //     key: key,

                  //     suggestions: lst,
                  //     // suggestions: [
                  //     //   "Apple",
                  //     //   "Armidillo",
                  //     //   "Actual",
                  //     //   "Actuary",
                  //     //   "America",
                  //     //   "Argentina",
                  //     //   "Australia",
                  //     //   "Antarctica",
                  //     //   "Blueberry",
                  //     // ],
                  //     decoration: InputDecoration(

                  //       labelText: 'Category',
                  //       labelStyle: TextStyle(color: Colors.grey[350]),
                  //       enabledBorder: UnderlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.grey[350]),
                  //         //  when the TextFormField in unfocused
                  //       ),
                  //       focusedBorder: UnderlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.white),
                  //         //  when the TextFormField in focused
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Container(
                    padding: EdgeInsets.all(5),
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,

                      validator: (String item) {
                        if (item == null)
                          return "choose a Category";
                        else if (item == "Brazil")
                          return "Invalid item";
                        else
                          return null;
                      },
                      showSelectedItem: true,
                      items: lst,

                      label: "Category",

                      popupBackgroundColor: Colors.white,
                      // hint: "Choose Category",

                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: (String data) {
                        print(data);
                        categoryController.text = data;
                      },
                      // onChanged:print,
                      // showClearButton: true,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0.0),
                        labelText: 'Category',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[350]),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          //  when the TextFormField in focused
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: 500,
                      height: 60,
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Color(0xFF37364B),
                        child: Text('Add Expense'),
                        onPressed: () async {
//  if (_formKey.currentState.validate()) {
//                   // If the form is valid, display a Snackbar.
//                   Scaffold.of(context)
//                       .showSnackBar(SnackBar(content: Text('Processing Data')));
//                 }
// Fluttertoast.showToast(
//         msg: "Insertion Successful",
//         gravity: ToastGravity.BOTTOM,
//     );
                          validate();

                          print(useridController.text);
                          print(dateController.text);
                          print(itemController.text);
                          print(amountController.text);
                          print(categoryController.text);
                          print(lst);
                          print(lstid);
                          print(lst.indexOf(categoryController.text));
                          var idx2;
                          var idx = lst.indexOf(categoryController.text);
                          if (idx > 0 && idx < 100) {
                            idx2 = lstid[idx];
                          }

                          var url =
                              '${Api.generalurl}/addexpense?userId=${Api.userid}&item=${itemController.text}&categoryId=$idx2&amount=${amountController.text}&transactionDate=${dateController.text}';

                          var response = await http.post(url);
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');
                          if (response.statusCode == 200) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Insertion Successfull')));
                            // itemController.text = '';
                            // amountController.text = '';
                            // categoryController.text = '';
                            resetForm();
                            setState(() {});
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                duration: const Duration(seconds: 1),
                                content:
                                    Text('Error!Cannot complete operation.')));
                          }
                        },
                      )),
                ],
              )),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add_to_queue,
          ),
          onPressed: _onAlertWithCustomContentPressed,
          backgroundColor: Color(0xffa4a1fb),
          foregroundColor: Colors.black,
        ));
  }

  //void _selectDate(BuildContext context) {}

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;

        print("${selectedDate.toLocal()}".split(' ')[0]);
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }

  //   globalstate() async {
  //   var url = 'http://192.168.1.103:8081/tracker/register/liscategoryexpense';
  //   var response = await http.get(url);
  //   var jsonResponse = convert.jsonDecode(response.body);
  //   final lst=[];
  //   print("Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
  //   print(jsonResponse);
  //  print((jsonResponse[3]["CATEGORY_NAME"]));

  //  jsonResponse.forEach((i) {

  //   // print(i["CATEGORY_NAME"]);
  //   lst.add(i["CATEGORY_NAME"]);
  //   // print('index=$i');
  // });

  // print(lst);
  //  print("Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
  //  return(lst);

  // }

  _addcategoryexpense() async {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _addcategoryexpensexyz() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Full Name', hintText: 'eg. John Smith'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('OPEN'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  _onAlertWithCustomContentPressed() {
    Alert(
        context: context,
        title: "CATEGORY",
        content: Column(
          children: <Widget>[
            TextField(
              controller: addcategoryController,
              decoration: InputDecoration(
                icon: Icon(Icons.add_circle),
                labelText: 'Category Name',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Color(0xFFF35B8C),
            onPressed: _catapi,
            child: Text(
              "ADD CATEGORY",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  _catapi() async {
    var url =
        '${Api.generalurl}/addexpensecategory?categoryName=${addcategoryController.text}';
    var response = await http.post(url);
    getapidetails();
    print(response);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Navigator.of(context, rootNavigator: true).pop();
      addcategoryController.text = '';
      getapidetails();
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Category added Successfully')));
    } else if (response.statusCode != 200) {
      Navigator.of(context, rootNavigator: true).pop();

      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Cannot add category now!')));
    } else {
      Navigator.of(context, rootNavigator: true).pop();

      print("ultimate else");
    }
    // print("button pressed");
  }
}
