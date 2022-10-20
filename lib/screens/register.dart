import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_project/dimension/dimension.dart';
import 'package:new_project/firebase/firebase_helper.dart';
import 'package:new_project/screens/homepage.dart';
import 'package:new_project/screens/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmpasswordcontroller = TextEditingController();
  TextEditingController _NameController = TextEditingController();

  senddata() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;

    final _CollectionReference =
        FirebaseFirestore.instance.collection("User_data").doc();
    return _CollectionReference.set({
      "Name": _NameController.text,
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("ERROR ${onError.toString()}"),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }

  bool _isHidden = true;
  Service service = Service();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/rain.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_circle_left_sharp,
                  size: Dimension.iconSize50,
                  color: Color.fromRGBO(205, 189, 223, 1),
                ),
              )),
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: Dimension.height75),
              child: Column(
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimension.font40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: Dimension.height20,
                  ),
                  Text(
                    'Register Here',
                    style: TextStyle(
                        color: Color.fromRGBO(205, 189, 223, 1),
                        fontSize: Dimension.font16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.25,
                    right: Dimension.width35,
                    left: Dimension.width35),
                child: Column(
                  children: [
                    TextField(
                      controller: _NameController,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Enter Name',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimension.radius15))),
                    ),
                    SizedBox(
                      height: Dimension.height30,
                    ),
                    TextField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Enter Email Id',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimension.radius15))),
                    ),
                    SizedBox(
                      height: Dimension.height30,
                    ),
                    TextField(
                      obscureText: _isHidden,
                      controller: _passwordcontroller,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          suffixIcon: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(Icons.visibility),
                          ),
                          hintText: 'Enter Password',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimension.radius15))),
                    ),
                    SizedBox(
                      height: Dimension.height30,
                    ),
                    TextField(
                      obscureText: _isHidden,
                      controller: _confirmpasswordcontroller,
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(Icons.visibility),
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Re-Enter Password',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimension.radius15))),
                    ),
                    SizedBox(
                      height: Dimension.height45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Sign In',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 214, 184, 248),
                                  fontSize: Dimension.font26,
                                  fontWeight: FontWeight.w700)),
                        ),
                        CircleAvatar(
                          radius: Dimension.radius30,
                          backgroundColor: Color.fromRGBO(205, 189, 223, 1),
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () async {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                // if (_passwordcontroller.text ==
                                //     _confirmpasswordcontroller) {
                                if (_emailcontroller.text.isNotEmpty &&
                                    _passwordcontroller.text.isNotEmpty) {
                                  service.createUser(
                                      context,
                                      _emailcontroller.text.toString().trim(),
                                      _passwordcontroller.text);
                                  pref.setString("email",
                                      _emailcontroller.text.toString().trim());
                                  senddata();
                                } else {
                                  service.errorBox(context,
                                      "Fields must not empty ,please provide valid email and password");
                                }
                                // } else {
                                //   ScaffoldMessenger.of(context)
                                //       .showSnackBar(SnackBar(
                                //     content: Text(
                                //         "ERROR : Passwords should be Same"),
                                //     behavior: SnackBarBehavior.floating,
                                //     backgroundColor: Colors.red,
                                //   ));
                                // }
                              },
                              icon: Icon(Icons.arrow_forward)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimension.height45,
                    ),
                  ],
                ),
              ),
            )
          ]),
        ));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
