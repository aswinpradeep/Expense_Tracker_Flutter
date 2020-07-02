import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'url.dart';
// import 'home.dart';

RegExp _pattern =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

class ForgotPassword extends StatefulWidget {
  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<ForgotPassword> {
  TextEditingController passController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  bool passwordVisible = true;
  bool cpasswordVisible = true;
  bool terms = false;

  //HomePage({Key key, this.fetchData}): super(key:key);

  Future<void> updatePassword(String email, String password) async {
    String uri = '${Api.generalurl}/';
    final String updateurl = uri + email + "/" + password;
    final http.Response response = await http.put(
      Uri.encodeFull(updateurl),
      headers: <String, String>{
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final int resbody = json.decode(response.body);
      if (resbody == 0) {
        globalKey.currentState
            .showSnackBar(new SnackBar(content: new Text("Invalid Email Id")));
      } else {
        globalKey.currentState.showSnackBar(
            new SnackBar(content: new Text("Successfully reset password")));
        new Timer(const Duration(milliseconds: 600), () {
          Navigator.pop(context, true);
        });
      }
    } else {
      globalKey.currentState.showSnackBar(
          new SnackBar(content: new Text("Failed to load values")));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        body: Form(
            key: _formKey,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xFFA4A1FB),
                child: Stack(children: <Widget>[
                  Center(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      //height: MediaQuery.of(context).size.height / 1.4,
                      width: MediaQuery.of(context).size.width / 1.1,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        border: Border.all(
                            width: 3,
                            color: const Color(0xFFFFFFFF),
                            style: BorderStyle.solid),
                        color: const Color(0xFFFFFFFF),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  'Forgot Password ',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontFamily: 'SourceSansPro--Bold',
                                    color: Color(0xFF000000),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),

                              //Text field for taking email id as input

                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  controller: emailController,
                                  cursorColor: const Color(0xFFA4A1FB),
                                  decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: Color(0xFFA4A1FB)),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          top:
                                              20), // add padding to adjust text
                                      isDense: true,
                                      hintText: "Email Id",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            top:
                                                10), // add padding to adjust icon
                                        child: Icon(Icons.email,
                                            color: Color(0xFFA4A1FB),
                                            size: 20.0),
                                      ),
                                      border: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color(0xFFA4A1FB)))),
                                  style: const TextStyle(
                                      fontFamily: 'SourceSansPro-Bold',
                                      fontSize: 14.0,
                                      color: Color(0xFF000000),
                                      decoration: TextDecoration.none),

                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Email Id';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              //Text field for taking password as input
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  controller: passController,
                                  cursorColor: const Color(0xFFA4A1FB),
                                  decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: Color(0xFFA4A1FB)),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          top:
                                              20), // add padding to adjust text
                                      isDense: true,
                                      hintText: "Password",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            top:
                                                10), // add padding to adjust icon
                                        child: Icon(Icons.lock,
                                            color: Color(0xFFA4A1FB),
                                            size: 20.0),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          passwordVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Color(0xFFA4A1FB),
                                        ),
                                        onPressed: () {
                                          print(passwordVisible);
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            passwordVisible = !passwordVisible;
                                          });
                                        },
                                      ),
                                      border: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color(0xFFA4A1FB)))),
                                  style: const TextStyle(
                                      fontFamily: 'SourceSansPro-Bold',
                                      fontSize: 14.0,
                                      color: Color(0xFF000000),
                                      decoration: TextDecoration.none),
                                  //Hide the password
                                  obscureText: passwordVisible,
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Password';
                                    } else if (!_pattern
                                        .hasMatch(passController.text)) {
                                      return 'Password not valid';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              //Text field for taking confirm password as input
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  controller: confirmpassController,
                                  cursorColor: const Color(0xFFA4A1FB),
                                  decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: Color(0xFFA4A1FB)),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          top:
                                              20), // add padding to adjust text
                                      isDense: true,
                                      hintText: "Confirm password",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(
                                            top:
                                                10), // add padding to adjust icon
                                        child: Icon(Icons.lock,
                                            color: Color(0xFFA4A1FB),
                                            size: 20.0),
                                      ),
                                      border: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color(0xFFA4A1FB)))),
                                  style: const TextStyle(
                                      fontFamily: 'SourceSansPro-Bold',
                                      fontSize: 14.0,
                                      color: Color(0xFF000000),
                                      decoration: TextDecoration.none),
                                  //Hide the password
                                  obscureText: cpasswordVisible,

                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please re-enter password';
                                    } else if (passController.text !=
                                        confirmpassController.text) {
                                      return ("Confirm password does not match password");
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              //Button to Submit
                              Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: ButtonTheme(
                                    minWidth: 400,
                                    height: 55,
                                    child: RaisedButton(
                                      color: const Color(0xFFA4A1FB),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          side: const BorderSide(
                                              color: Color(0xFFA4A1FB))),
                                      onPressed: () {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());

                                        //print(nameController.text);
                                        print(emailController.text);
                                        print(passController.text);
                                        //print(confirmpassController.text);
                                        print(passwordVisible);
                                        // Validate returns true if the form is valid, otherwise false.
                                        if (_formKey.currentState.validate()) {
                                          updatePassword(emailController.text,
                                              passController.text);

                                          /* setState(() {
                              getData(emailController.text,passController.text);
                            }); */

                                        }
                                      },
                                      child: const Text('SUBMIT',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              fontFamily: 'SourceSansPro-Bold',
                                              color: Color(0xFFFFFFFF))),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                              ),
                            ]),
                      ),
                    ),
                  )),
                ]))));
  }
}
