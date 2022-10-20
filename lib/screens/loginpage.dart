import 'package:flutter/material.dart';
import 'package:new_project/dimension/dimension.dart';

import 'package:new_project/screens/forgot.dart';

import 'package:new_project/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase/firebase_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Service service = Service();

  @override
  Widget build(BuildContext context) {
    // print(
    //   "the current width is" + MediaQuery.of(context).size.width.toString());
    return Scaffold(
        body: Stack(children: [
      Image.asset(
        'images/rain.jpg',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
      SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: Dimension.height75 * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: Dimension.height50,
                        width: Dimension.width50,
                        child: Image.asset(
                          'images/logo.png',
                        )),
                    SizedBox(
                      width: Dimension.width5,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 3),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 184, 132, 194),
                                  width: 4))),
                      child: Text(
                        'FLOOD FORESIGHT',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimension.font30),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimension.height75,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: Dimension.width20, left: Dimension.width20),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: emailcontroller,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Enter Email Id or Login Id',
                        hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.circular(Dimension.radius20))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Dimension.height30,
                      right: Dimension.width20,
                      left: Dimension.width20),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: passwordcontroller,
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(color: Colors.black),
                        suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(Icons.visibility),
                        ),
                        prefixIcon: Icon(
                          Icons.keyboard,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius:
                              BorderRadius.circular(Dimension.radius20),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimension.height60),
                  child: Container(
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 201, 96, 219)),
                        // color: Color.fromRGBO(205, 189, 223, 1),
                        onPressed: () async {
                          setState(() {});
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          if (emailcontroller.text.isNotEmpty &&
                              passwordcontroller.text.isNotEmpty) {
                            service.loginUser(
                                context,
                                emailcontroller.text.trim(),
                                passwordcontroller.text);
                            pref.setString(
                                "email", emailcontroller.text.trim());
                          } else {
                            service.errorBox(context,
                                "Fields must not empty ,please provide valid email and password");
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimension.height50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.width10 / 2),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForgotPage()));
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: Dimension.font13,
                                    color: Colors.white),
                              ))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.width10 / 2),
                      child: Container(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage()));
                              },
                              child: Text(
                                "Don't have an Account?   ",
                                style: TextStyle(
                                    fontSize: Dimension.font13,
                                    color: Colors.white),
                              ))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ]));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
