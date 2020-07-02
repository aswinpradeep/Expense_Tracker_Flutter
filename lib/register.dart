import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:string_validator/string_validator.dart';
import 'url.dart';

RegExp _alpha = RegExp(r'^[\D\.]+$');
RegExp _pattern =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

class Register extends StatefulWidget {
  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  bool passwordVisible = true;
  bool confirmpasswordVisible = true;
  bool terms = false;

  Future<void> createUser(String name, String emailid, String password) async {
    final http.Response response = await http.post(
      '${Api.generalurl}',
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'emailId': emailid,
        'name': name,
        'password': password
      }),
    );
    if (response.statusCode == 200) {
      final int resbody = json.decode(response.body);
      if (resbody == 1) {
        globalKey.currentState.showSnackBar(
            new SnackBar(content: new Text("Registration Successful")));
        new Timer(const Duration(milliseconds: 600), () {
          Navigator.pop(context, true);
        });
      } else if (resbody == 2) {
        globalKey.currentState.showSnackBar(
            new SnackBar(content: new Text("Email Id already exists")));
      } else {
        globalKey.currentState.showSnackBar(
            new SnackBar(content: new Text("Registration Failed")));
      }
    } else {
      globalKey.currentState
          .showSnackBar(new SnackBar(content: new Text("Registration Failed")));
    }
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
                          child: Padding(
                            padding: const EdgeInsets.only(top: 65),
                            child: Container(
                              //height: MediaQuery.of(context).size.height / 1.4,
                              width: MediaQuery.of(context).size.width / 1.1,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: ButtonBar(
                                          buttonHeight: 50,
                                          buttonMinWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          alignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text('Register',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'SourceSansPro-Bold',
                                                    color: const Color(
                                                        0xFF000000))),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 60)),

                                            //Button for cancel
                                            RichText(
                                              textAlign: TextAlign.end,
                                              text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: Icon(Icons.close,
                                                        size: 20,
                                                        color: const Color(
                                                            0xFF9D9D9D)),
                                                  ),
                                                  TextSpan(
                                                    text: 'CANCEL',
                                                    style: const TextStyle(
                                                        fontSize: 18.0,
                                                        fontFamily:
                                                            'SourceSansPro-Bold',
                                                        color:
                                                            Color(0xFF9D9D9D)),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            Navigator.pop(
                                                                context, true);
                                                          },
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                      //Text field for taking name as input
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: TextFormField(
                                          controller: nameController,
                                          cursorColor: const Color(0xFFA4A1FB),
                                          decoration: InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color(0xFFA4A1FB)),
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  top:
                                                      20), // add padding to adjust text
                                              isDense: true,
                                              hintText: "Name",
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.only(
                                                    top:
                                                        10), // add padding to adjust icon
                                                child: Icon(Icons.person,
                                                    color: Color(0xFFA4A1FB),
                                                    size: 20.0),
                                              ),
                                              border: new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color:
                                                          Color(0xFFA4A1FB)))),
                                          style: const TextStyle(
                                              fontFamily: 'SourceSansPro-Bold',
                                              fontSize: 14.0,
                                              color: Color(0xFF000000),
                                              decoration: TextDecoration.none),

                                          // The validator receives the text that the user has entered.
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter some text';
                                            } else if (value.length <= 2) {
                                              return 'Name not long enough';
                                            } else if (!_alpha.hasMatch(
                                                nameController.text)) {
                                              return 'Name not valid';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),

                                      //Text field for taking email id as input

                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: TextFormField(
                                          controller: emailController,
                                          cursorColor: const Color(0xFFA4A1FB),
                                          decoration: InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color(0xFFA4A1FB)),
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
                                                      color:
                                                          Color(0xFFA4A1FB)))),
                                          style: const TextStyle(
                                              fontFamily: 'SourceSansPro-Bold',
                                              fontSize: 14.0,
                                              color: Color(0xFF000000),
                                              decoration: TextDecoration.none),

                                          // The validator receives the text that the user has entered.
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter Email Id';
                                            } else if (!isEmail(
                                                emailController.text)) {
                                              return 'Email Id is not valid';
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
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color(0xFFA4A1FB)),
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
                                                    passwordVisible =
                                                        !passwordVisible;
                                                  });
                                                },
                                              ),
                                              border: new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color:
                                                          Color(0xFFA4A1FB)))),
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
                                            } else if (!_pattern.hasMatch(
                                                passController.text)) {
                                              return 'Password not valid';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),

                                      //Text field for taking Password confirmation as input
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: TextFormField(
                                          controller: confirmpassController,
                                          cursorColor: const Color(0xFFA4A1FB),
                                          decoration: InputDecoration(
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color(0xFFA4A1FB)),
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  top:
                                                      20), // add padding to adjust text
                                              isDense: true,
                                              hintText: "Confirm Password",
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
                                                      color:
                                                          Color(0xFFA4A1FB)))),
                                          style: const TextStyle(
                                              fontFamily: 'SourceSansPro-Bold',
                                              fontSize: 14.0,
                                              color: Color(0xFF000000),
                                              decoration: TextDecoration.none),
                                          //Hide the password
                                          obscureText: confirmpasswordVisible,

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

                                      //Check box for agree the terms and conditions
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Center(
                                            child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.4,
                                          child: ButtonBar(
                                            buttonHeight: 50,
                                            buttonMinWidth:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.5,
                                            alignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Checkbox(
                                                checkColor: Color(
                                                    0xFFFFFFFF), // color of tick Mark
                                                activeColor: Color(0xFFA4A1FB),
                                                value: terms,
                                                onChanged: (bool value) {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());
                                                  setState(() {
                                                    terms = value;
                                                  });
                                                },
                                              ),
                                              RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: 'I agree to the ',
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          fontFamily:
                                                              'SourceSansPro-Regular',
                                                          color: const Color(
                                                              0xFF000000))),
                                                  TextSpan(
                                                    text: 'Terms & Conditions.',
                                                    style: TextStyle(
                                                      color: const Color(
                                                          0xFF000000),
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'SourceSansPro-Bold',
                                                    ),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {},
                                                  )
                                                ]),
                                              )
                                            ],
                                          ),
                                        )),
                                      ),

                                      //Button to submit registration
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: ButtonTheme(
                                            minWidth: 400,
                                            height: 55,
                                            child: RaisedButton(
                                              color: const Color(0xFFA4A1FB),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  side: const BorderSide(
                                                      color:
                                                          Color(0xFFA4A1FB))),
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());

                                                print(nameController.text);
                                                print(emailController.text);
                                                print(passController.text);
                                                print(
                                                    confirmpassController.text);
                                                print(passwordVisible);
                                                // Validate returns true if the form is valid, otherwise false.
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  // If the form is valid, display a snackbar. In the real world,
                                                  // you'd often call a server or save the information in a database.
                                                  if (terms) {
                                                    setState(() {
                                                      createUser(
                                                          nameController.text,
                                                          emailController.text,
                                                          passController.text);
                                                    });
                                                  } else {
                                                    final snackBar = SnackBar(
                                                        content: Text(
                                                            'Agree the terms and conditions'));
                                                    globalKey.currentState
                                                        .showSnackBar(snackBar);
                                                  }
                                                }
                                              },
                                              child: const Text('SUBMIT',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 24.0,
                                                      fontFamily:
                                                          'SourceSansPro-Bold',
                                                      color:
                                                          Color(0xFFFFFFFF))),
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                      ),
                                    ]),
                              ),
                            ),
                          ))),
                ]))));
  }
}
