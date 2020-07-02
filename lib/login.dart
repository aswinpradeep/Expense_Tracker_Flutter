import 'dart:convert' as convert;

import './curvedbar.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'forgotPassword.dart';
import 'register.dart';
import 'url.dart';

class Login extends StatefulWidget {
  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<Login> {
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  bool passwordVisible = true;
  bool terms = false;

  //HomePage({Key key, this.fetchData}): super(key:key);

  Future<void> getData(String email, String password) async {
    String uri = '${Api.generalurl}/';
    final String loginurl = uri + email + "/" + password;
    final http.Response response = await http.get(
      Uri.encodeFull(loginurl),
      headers: <String, String>{
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = List();
      var extractdata = convert.jsonDecode(response.body);
      if (extractdata.length == 0) {
        globalKey.currentState.showSnackBar(
            new SnackBar(content: new Text("Email Id or Password invalid")));
      } else {
        data = extractdata;
        String name = data[0]["name"];
        int id = data[0]["id"];
        print(name);
        print(id);
        Api.userid = id;

        Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => BottomNavBar()));
      }
      /* FetchData fetchData = FetchData.fromJson(item);
    print(fetchData); */
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
                                  'Login ',
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
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              //Forgot password
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: InkWell(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          'Forgot Password',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontFamily: 'SourceSansPro-Bold',
                                              color: Color(0xFF000000)),
                                        ),
                                      ]),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                            builder: (BuildContext context) =>
                                                ForgotPassword()));
                                  },
                                ),
                              ),

                              //Button to Login
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
                                          getData(emailController.text,
                                              passController.text);
                                        }
                                      },
                                      child: const Text('LOGIN',
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
                  Container(
                    padding: const EdgeInsets.only(top: 500),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new RichText(
                            text: new TextSpan(
                                text: "Don't have an account yet?",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'SourceSansPro-Regular',
                                    color: Color(0xFFFFFFFF)),
                                children: [
                                  new TextSpan(
                                    text: ' Register',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'SourceSansPro-Bold',
                                        color: Color(0xFF000000)),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute<dynamic>(
                                                builder:
                                                    (BuildContext context) =>
                                                        Register()));
                                      },
                                  )
                                ]),
                          ),
                        ]),
                  ),
                ]))));
  }
}
